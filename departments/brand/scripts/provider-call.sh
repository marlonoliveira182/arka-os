#!/usr/bin/env bash
# ============================================================================
# ARKA OS — Generic AI Provider API Caller
# Makes API calls to image/video/text providers using the provider registry
# Usage: bash provider-call.sh --type image --prompt "..." [--provider openai] [--model gpt-image-1] [--output /path]
# ============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"
REGISTRY="$REPO_DIR/config/providers-registry.json"
ENV_FILE="$HOME/.arka-os/.env"
MEDIA_DIR="$HOME/.arka-os/media/brand"
COST_LOG="$MEDIA_DIR/cost-log.json"

# Load env
[ -f "$ENV_FILE" ] && source "$ENV_FILE"

# Require jq and curl
command -v jq &>/dev/null || { echo "Error: jq required"; exit 1; }
command -v curl &>/dev/null || { echo "Error: curl required"; exit 1; }

# ─── Parse Arguments ─────────────────────────────────────────────────────────
TYPE=""
PROMPT=""
PROVIDER=""
MODEL=""
OUTPUT_DIR=""
SIZE="1024x1024"

while [ $# -gt 0 ]; do
  case "$1" in
    --type)     TYPE="$2"; shift 2 ;;
    --prompt)   PROMPT="$2"; shift 2 ;;
    --provider) PROVIDER="$2"; shift 2 ;;
    --model)    MODEL="$2"; shift 2 ;;
    --output)   OUTPUT_DIR="$2"; shift 2 ;;
    --size)     SIZE="$2"; shift 2 ;;
    --list)
      echo "Available providers with configured keys:"
      for pid in $(jq -r '.providers | keys[]' "$REGISTRY"); do
        auth_env=$(jq -r --arg id "$pid" '.providers[$id].auth_env' "$REGISTRY")
        value="${!auth_env:-}"
        if [ -n "$value" ] && [ ${#value} -ge 8 ]; then
          echo "  ● $pid ($auth_env)"
          jq -r --arg id "$pid" '.providers[$id].models | to_entries[] | "    - \(.key) [\(.value.type)]"' "$REGISTRY"
        fi
      done
      exit 0
      ;;
    *) shift ;;
  esac
done

[ -z "$TYPE" ] && { echo "Error: --type (image|video|text) is required"; exit 1; }
[ -z "$PROMPT" ] && { echo "Error: --prompt is required"; exit 1; }

# ─── Setup output directory ──────────────────────────────────────────────────
JOB_ID=$(date +%s | md5 2>/dev/null | head -c 8 || echo "$$")
DATE_DIR=$(date +%Y-%m-%d)
[ -z "$OUTPUT_DIR" ] && OUTPUT_DIR="$MEDIA_DIR/$DATE_DIR/$JOB_ID"
mkdir -p "$OUTPUT_DIR"

# ─── Resolve provider from routing chain ─────────────────────────────────────
resolve_provider() {
  local type="$1"
  local routing_key=""

  case "$type" in
    image) routing_key="image-generation" ;;
    video) routing_key="video-generation" ;;
    text)  routing_key="text-completion" ;;
  esac

  local chain
  chain=$(jq -r --arg key "$routing_key" '.routing[$key] // [] | .[]' "$REGISTRY" 2>/dev/null)

  for ref in $chain; do
    local pid="${ref%%/*}"
    local auth_env
    auth_env=$(jq -r --arg id "$pid" '.providers[$id].auth_env' "$REGISTRY")
    local value="${!auth_env:-}"
    if [ -n "$value" ] && [ ${#value} -ge 8 ]; then
      echo "$ref"
      return 0
    fi
  done

  return 1
}

# If no provider specified, resolve from routing chain
if [ -z "$PROVIDER" ] && [ -z "$MODEL" ]; then
  RESOLVED=$(resolve_provider "$TYPE") || { echo "Error: No provider with configured API key found for type '$TYPE'. Run: arka providers add-key <KEY>"; exit 1; }
  PROVIDER="${RESOLVED%%/*}"
  MODEL="${RESOLVED#*/}"
elif [ -n "$PROVIDER" ] && [ -z "$MODEL" ]; then
  # Pick first model of the right type from this provider
  MODEL=$(jq -r --arg pid "$PROVIDER" --arg type "$TYPE" \
    '.providers[$pid].models | to_entries[] | select(.value.type == $type) | .key' "$REGISTRY" | head -1)
  [ -z "$MODEL" ] && { echo "Error: No $TYPE model found for provider '$PROVIDER'"; exit 1; }
fi

# Get provider config
BASE_URL=$(jq -r --arg id "$PROVIDER" '.providers[$id].base_url' "$REGISTRY")
AUTH_ENV=$(jq -r --arg id "$PROVIDER" '.providers[$id].auth_env' "$REGISTRY")
AUTH_HEADER=$(jq -r --arg id "$PROVIDER" '.providers[$id].auth_header' "$REGISTRY")
API_KEY="${!AUTH_ENV:-}"

[ -z "$API_KEY" ] && { echo "Error: $AUTH_ENV not set. Run: arka providers add-key $AUTH_ENV"; exit 1; }

# ─── Provider-specific API calls ─────────────────────────────────────────────

call_openai_image() {
  local response
  response=$(curl -s "$BASE_URL/images/generations" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg model "$MODEL" --arg prompt "$PROMPT" --arg size "$SIZE" \
      '{model: $model, prompt: $prompt, size: $size, n: 1, response_format: "url"}')")

  local url
  url=$(echo "$response" | jq -r '.data[0].url // empty' 2>/dev/null)
  if [ -n "$url" ]; then
    curl -sL "$url" -o "$OUTPUT_DIR/output.png"
    echo "$OUTPUT_DIR/output.png"
  else
    echo "$response" | jq -r '.error.message // "Unknown error"' 2>/dev/null >&2
    echo "$response" > "$OUTPUT_DIR/error.json"
    return 1
  fi
}

call_replicate() {
  # Create prediction
  local response
  response=$(curl -s "$BASE_URL/predictions" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg model "$MODEL" --arg prompt "$PROMPT" \
      '{version: $model, input: {prompt: $prompt}}')")

  local prediction_url
  prediction_url=$(echo "$response" | jq -r '.urls.get // empty' 2>/dev/null)
  [ -z "$prediction_url" ] && { echo "Error: Failed to create prediction" >&2; echo "$response" > "$OUTPUT_DIR/error.json"; return 1; }

  # Poll for result
  local status=""
  local max_polls=60
  local poll_count=0
  while [ "$status" != "succeeded" ] && [ "$status" != "failed" ] && [ "$poll_count" -lt "$max_polls" ]; do
    sleep 5
    response=$(curl -s "$prediction_url" -H "Authorization: Bearer $API_KEY")
    status=$(echo "$response" | jq -r '.status' 2>/dev/null)
    poll_count=$((poll_count + 1))
  done

  if [ "$status" = "succeeded" ]; then
    local output_url
    output_url=$(echo "$response" | jq -r '.output | if type == "array" then .[0] else . end' 2>/dev/null)
    local ext="png"
    echo "$output_url" | grep -q "\.mp4" && ext="mp4"
    curl -sL "$output_url" -o "$OUTPUT_DIR/output.$ext"
    echo "$OUTPUT_DIR/output.$ext"
  else
    echo "Error: Prediction $status" >&2
    echo "$response" > "$OUTPUT_DIR/error.json"
    return 1
  fi
}

call_fal() {
  local response
  response=$(curl -s "$BASE_URL/$MODEL" \
    -H "Authorization: Key $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg prompt "$PROMPT" '{prompt: $prompt}')")

  # FAL may return a request_id for async, or direct result
  local request_id
  request_id=$(echo "$response" | jq -r '.request_id // empty' 2>/dev/null)

  if [ -n "$request_id" ]; then
    # Poll for result
    local status=""
    local max_polls=60
    local poll_count=0
    while [ "$status" != "COMPLETED" ] && [ "$poll_count" -lt "$max_polls" ]; do
      sleep 5
      response=$(curl -s "$BASE_URL/$MODEL/requests/$request_id/status" \
        -H "Authorization: Key $API_KEY")
      status=$(echo "$response" | jq -r '.status // ""' 2>/dev/null)
      poll_count=$((poll_count + 1))
    done
    # Get result
    response=$(curl -s "$BASE_URL/$MODEL/requests/$request_id" \
      -H "Authorization: Key $API_KEY")
  fi

  # Extract output URL
  local output_url
  output_url=$(echo "$response" | jq -r '.images[0].url // .video.url // .output.url // empty' 2>/dev/null)
  if [ -n "$output_url" ]; then
    local ext="png"
    echo "$output_url" | grep -qE "\.(mp4|webm)" && ext="mp4"
    curl -sL "$output_url" -o "$OUTPUT_DIR/output.$ext"
    echo "$OUTPUT_DIR/output.$ext"
  else
    echo "Error: No output URL in response" >&2
    echo "$response" > "$OUTPUT_DIR/error.json"
    return 1
  fi
}

call_generic() {
  # Generic OpenAI-compatible API call (for text providers like OpenRouter)
  local response
  response=$(curl -s "$BASE_URL/chat/completions" \
    -H "$AUTH_HEADER $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg model "$MODEL" --arg prompt "$PROMPT" \
      '{model: $model, messages: [{role: "user", content: $prompt}]}')")

  local content
  content=$(echo "$response" | jq -r '.choices[0].message.content // empty' 2>/dev/null)
  if [ -n "$content" ]; then
    echo "$content" > "$OUTPUT_DIR/output.txt"
    echo "$OUTPUT_DIR/output.txt"
  else
    echo "$response" > "$OUTPUT_DIR/error.json"
    return 1
  fi
}

# ─── Execute call based on provider ──────────────────────────────────────────
echo "Calling $PROVIDER/$MODEL ($TYPE)..." >&2

RESULT=""
case "$PROVIDER" in
  openai)    RESULT=$(call_openai_image) ;;
  replicate) RESULT=$(call_replicate) ;;
  fal)       RESULT=$(call_fal) ;;
  *)         RESULT=$(call_generic) ;;
esac

EXIT_CODE=$?

# ─── Log cost entry ──────────────────────────────────────────────────────────
mkdir -p "$(dirname "$COST_LOG")"
[ ! -f "$COST_LOG" ] && echo '[]' > "$COST_LOG"
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
jq --arg ts "$NOW" --arg provider "$PROVIDER" --arg model "$MODEL" --arg type "$TYPE" \
   --arg output "${RESULT:-error}" --argjson success "$([ $EXIT_CODE -eq 0 ] && echo true || echo false)" \
   '. += [{timestamp: $ts, provider: $provider, model: $model, type: $type, output: $output, success: $success}]' \
   "$COST_LOG" > "$COST_LOG.tmp" 2>/dev/null && mv "$COST_LOG.tmp" "$COST_LOG"

if [ $EXIT_CODE -eq 0 ] && [ -n "$RESULT" ]; then
  echo "$RESULT"
else
  echo "Error: API call failed. Check $OUTPUT_DIR/error.json" >&2
  exit 1
fi
