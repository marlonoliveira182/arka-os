#!/usr/bin/env bash
# ============================================================================
# ARKA OS — UserPromptSubmit Hook (5-Layer Context Injection)
# Injects contextual rules per prompt with caching for performance
# Timeout: 10s | Output: JSON to stdout | Target: <200ms
# ============================================================================

input=$(cat)

# Extract fields
PROMPT=$(echo "$input" | jq -r '.prompt // ""' 2>/dev/null)
CWD=$(echo "$input" | jq -r '.cwd // ""' 2>/dev/null)
SESSION_ID=$(echo "$input" | jq -r '.session_id // ""' 2>/dev/null)

CONTEXT_PARTS=()
ARKA_OS="${ARKA_OS:-$HOME/.claude/skills/arka}"
CACHE_DIR="/tmp/arka-context-cache"
mkdir -p "$CACHE_DIR"

# ─── Cache Helper ─────────────────────────────────────────────────────────
# cache_get <key> <ttl_seconds> — returns cached value or empty
cache_get() {
  local file="$CACHE_DIR/$1"
  local ttl="$2"
  if [ -f "$file" ]; then
    local age=$(( $(date +%s) - $(stat -f%m "$file" 2>/dev/null || stat -c%Y "$file" 2>/dev/null || echo 0) ))
    if [ "$age" -lt "$ttl" ]; then
      cat "$file"
      return 0
    fi
  fi
  return 1
}

cache_set() {
  echo "$2" > "$CACHE_DIR/$1"
}

# ─── L0: Constitution (compressed, 300s cache) ───────────────────────────
L0=$(cache_get "constitution" 300) || {
  REPO_PATH=$(cat "$ARKA_OS/.repo-path" 2>/dev/null || echo "")
  CONSTITUTION_FILE=""
  [ -f "$REPO_PATH/CONSTITUTION.md" ] && CONSTITUTION_FILE="$REPO_PATH/CONSTITUTION.md"
  if [ -n "$CONSTITUTION_FILE" ]; then
    L0="[Constitution] NON-NEGOTIABLE: worktree-isolation, obsidian-output, authority-boundaries, security-gate, context-first | MUST: conventional-commits, test-coverage, pattern-matching, actionable-output, memory-persistence"
    cache_set "constitution" "$L0"
  else
    L0=""
  fi
}
[ -n "$L0" ] && CONTEXT_PARTS+=("$L0")

# ─── L1: Department Routing (no cache — fast string match) ───────────────
PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')
DETECTED_DEPT=""

if echo "$PROMPT_LOWER" | grep -qE '\b(build|code|feature|deploy|test|review|scaffold|debug|refactor|api|migration|stack)\b'; then
  DETECTED_DEPT="dev"
elif echo "$PROMPT_LOWER" | grep -qE '\b(budget|invoice|revenue|forecast|profit|loss|roi|margin|cash.?flow|financial|invest)\b'; then
  DETECTED_DEPT="finance"
elif echo "$PROMPT_LOWER" | grep -qE '\b(social|content|campaign|post|instagram|linkedin|twitter|tiktok|seo|marketing|ads|email.?campaign)\b'; then
  DETECTED_DEPT="marketing"
elif echo "$PROMPT_LOWER" | grep -qE '\b(store|product|shop|shopify|ecommerce|catalog|inventory|cart|checkout|pricing)\b'; then
  DETECTED_DEPT="ecommerce"
elif echo "$PROMPT_LOWER" | grep -qE '\b(strategy|brainstorm|market|swot|competitor|roadmap|pivot|growth)\b'; then
  DETECTED_DEPT="strategy"
elif echo "$PROMPT_LOWER" | grep -qE '\b(task|email|calendar|automate|meeting|workflow|process|schedule|slack|discord|notify)\b'; then
  DETECTED_DEPT="operations"
elif echo "$PROMPT_LOWER" | grep -qE '\b(learn|persona|knowledge|youtube|transcribe|article|research)\b'; then
  DETECTED_DEPT="knowledge"
fi
[ -n "$DETECTED_DEPT" ] && CONTEXT_PARTS+=("[dept:$DETECTED_DEPT]")

# ─── L2: Agent Memory (30s cache) ────────────────────────────────────────
# Detect agent name from prompt
DETECTED_AGENT=""
if echo "$PROMPT_LOWER" | grep -qE '\bmarco\b|/.*cto\b'; then
  DETECTED_AGENT="cto"
elif echo "$PROMPT_LOWER" | grep -qE '\bpaulo\b|tech.?lead'; then
  DETECTED_AGENT="tech-lead"
elif echo "$PROMPT_LOWER" | grep -qE '\bgabriel\b|architect'; then
  DETECTED_AGENT="architect"
elif echo "$PROMPT_LOWER" | grep -qE '\bandre\b|senior.?dev|backend'; then
  DETECTED_AGENT="senior-dev"
elif echo "$PROMPT_LOWER" | grep -qE '\bdiana\b|frontend.?dev'; then
  DETECTED_AGENT="frontend-dev"
elif echo "$PROMPT_LOWER" | grep -qE '\bbruno\b|security'; then
  DETECTED_AGENT="security"
elif echo "$PROMPT_LOWER" | grep -qE '\bcarlos\b|devops'; then
  DETECTED_AGENT="devops"
elif echo "$PROMPT_LOWER" | grep -qE '\brita\b|\bqa\b'; then
  DETECTED_AGENT="qa"
elif echo "$PROMPT_LOWER" | grep -qE '\blucas\b|analyst'; then
  DETECTED_AGENT="analyst"
elif echo "$PROMPT_LOWER" | grep -qE '\bhelena\b|cfo'; then
  DETECTED_AGENT="cfo"
elif echo "$PROMPT_LOWER" | grep -qE '\bsofia\b|coo'; then
  DETECTED_AGENT="coo"
elif echo "$PROMPT_LOWER" | grep -qE '\bluna\b|content.?creator'; then
  DETECTED_AGENT="content-creator"
elif echo "$PROMPT_LOWER" | grep -qE '\bricardo\b|ecommerce.?manager'; then
  DETECTED_AGENT="ecommerce-manager"
elif echo "$PROMPT_LOWER" | grep -qE '\btomas\b|strategist'; then
  DETECTED_AGENT="strategist"
elif echo "$PROMPT_LOWER" | grep -qE '\bclara\b|knowledge.?curator'; then
  DETECTED_AGENT="knowledge-curator"
fi

if [ -n "$DETECTED_AGENT" ]; then
  AGENT_CACHE_KEY="agent-${DETECTED_AGENT}"
  AGENT_CTX=$(cache_get "$AGENT_CACHE_KEY" 30) || {
    AGENT_MEM="$HOME/.claude/agent-memory/arka-${DETECTED_AGENT}/MEMORY.md"
    AGENT_CTX="[agent:$DETECTED_AGENT]"
    if [ -f "$AGENT_MEM" ]; then
      # Extract last 3 gotchas from agent memory
      GOTCHAS=$(sed -n '/^## Gotchas/,/^## /{ /^## Gotchas/d; /^## /d; /^$/d; p; }' "$AGENT_MEM" 2>/dev/null | head -3)
      if [ -n "$GOTCHAS" ]; then
        AGENT_CTX="[agent:$DETECTED_AGENT gotchas: $(echo "$GOTCHAS" | tr '\n' '; ' | head -c 200)]"
      fi
    fi
    cache_set "$AGENT_CACHE_KEY" "$AGENT_CTX"
  }
  CONTEXT_PARTS+=("$AGENT_CTX")
fi

# ─── L3: Active Project (30s cache) ──────────────────────────────────────
if [ -n "$CWD" ]; then
  PROJECT_CACHE_KEY="project-$(echo "$CWD" | md5 2>/dev/null || echo "$CWD" | md5sum 2>/dev/null | cut -d' ' -f1 || echo "nocache")"
  PROJECT_CTX=$(cache_get "$PROJECT_CACHE_KEY" 30) || {
    PROJECT_CTX=""
    # Check ARKA OS projects/ directory
    REPO_PATH=$(cat "$ARKA_OS/.repo-path" 2>/dev/null || echo "")
    if [ -n "$REPO_PATH" ] && [ -d "$REPO_PATH/projects" ]; then
      for proj_md in "$REPO_PATH/projects"/*/PROJECT.md; do
        [ -f "$proj_md" ] || continue
        PROJ_DIR=$(dirname "$proj_md")
        if [ -f "$PROJ_DIR/.project-path" ]; then
          PROJ_PATH=$(cat "$PROJ_DIR/.project-path" 2>/dev/null)
          if [ -n "$PROJ_PATH" ] && [[ "$CWD" == "$PROJ_PATH"* ]]; then
            PROJ_NAME=$(basename "$PROJ_DIR")
            # Try to extract stack from PROJECT.md
            PROJ_STACK=$(grep -i 'stack\|framework' "$proj_md" 2>/dev/null | head -1 | sed 's/.*: *//' | head -c 50)
            PROJECT_CTX="[project:$PROJ_NAME"
            [ -n "$PROJ_STACK" ] && PROJECT_CTX+=" stack:$PROJ_STACK"
            PROJECT_CTX+="]"
            break
          fi
        fi
      done
    fi

    # Also check installed skills for project paths
    if [ -z "$PROJECT_CTX" ]; then
      for proj_dir in "$HOME/.claude/skills"/arka-*/; do
        [ -d "$proj_dir" ] || continue
        if [ -f "$proj_dir/.project-path" ]; then
          PROJ_PATH=$(cat "$proj_dir/.project-path" 2>/dev/null)
          if [ -n "$PROJ_PATH" ] && [[ "$CWD" == "$PROJ_PATH"* ]]; then
            PROJ_NAME=$(basename "$proj_dir" | sed 's/^arka-//')
            PROJECT_CTX="[project:$PROJ_NAME]"
            break
          fi
        fi
      done
    fi

    cache_set "$PROJECT_CACHE_KEY" "$PROJECT_CTX"
  }
  [ -n "$PROJECT_CTX" ] && CONTEXT_PARTS+=("$PROJECT_CTX")
fi

# ─── L4: Git Worktree Detection (no cache — fast check) ──────────────────
if [ -n "$CWD" ] && [ -d "$CWD/.git" ] || [ -f "$CWD/.git" ] 2>/dev/null; then
  # Check if inside a worktree (fast: .git is a file, not directory, in worktrees)
  if [ -f "$CWD/.git" ] 2>/dev/null; then
    WT_BRANCH=$(git -C "$CWD" branch --show-current 2>/dev/null || echo "")
    [ -n "$WT_BRANCH" ] && CONTEXT_PARTS+=("[worktree:$WT_BRANCH]")
  fi
fi

# ─── Gotchas Injection (30s cache) ───────────────────────────────────────
if [ -n "$DETECTED_DEPT" ]; then
  GOTCHA_CACHE_KEY="gotchas-${DETECTED_DEPT}"
  GOTCHA_CTX=$(cache_get "$GOTCHA_CACHE_KEY" 30) || {
    GOTCHA_CTX=""
    GOTCHAS_FILE="$HOME/.arka-os/gotchas.json"
    if [ -f "$GOTCHAS_FILE" ] && command -v jq &>/dev/null; then
      # Get top 2 recurring errors for this department with count >= 3
      TOP_GOTCHAS=$(jq -r --arg cat "$DETECTED_DEPT" \
        '[.[] | select(.category == $cat and .count >= 3)] | sort_by(-.count) | .[0:2] | .[].pattern' \
        "$GOTCHAS_FILE" 2>/dev/null)
      if [ -n "$TOP_GOTCHAS" ]; then
        GOTCHA_CTX="[gotchas:$DETECTED_DEPT $(echo "$TOP_GOTCHAS" | tr '\n' '; ' | head -c 200)]"
      fi
    fi
    cache_set "$GOTCHA_CACHE_KEY" "$GOTCHA_CTX"
  }
  [ -n "$GOTCHA_CTX" ] && CONTEXT_PARTS+=("$GOTCHA_CTX")
fi

# ─── Time of Day (no cache) ──────────────────────────────────────────────
HOUR=$(date +%H)
if [ "$HOUR" -lt 12 ]; then
  CONTEXT_PARTS+=("[time:morning]")
elif [ "$HOUR" -lt 18 ]; then
  CONTEXT_PARTS+=("[time:afternoon]")
else
  CONTEXT_PARTS+=("[time:evening]")
fi

# ─── Output ───────────────────────────────────────────────────────────────
if [ ${#CONTEXT_PARTS[@]} -gt 0 ]; then
  CONTEXT=""
  for part in "${CONTEXT_PARTS[@]}"; do
    CONTEXT+="$part "
  done
  CONTEXT="${CONTEXT% }"

  jq -n --arg ctx "$CONTEXT" '{
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": $ctx
    }
  }'
else
  echo '{}'
fi
