#!/usr/bin/env bash
# ============================================================================
# ARKA OS — UserPromptSubmit Hook
# Injects contextual rules per prompt (project detection, dept routing, time)
# Timeout: 10s | Output: JSON to stdout
# ============================================================================

input=$(cat)

# Extract fields
PROMPT=$(echo "$input" | jq -r '.prompt // ""' 2>/dev/null)
CWD=$(echo "$input" | jq -r '.cwd // ""' 2>/dev/null)
SESSION_ID=$(echo "$input" | jq -r '.session_id // ""' 2>/dev/null)

CONTEXT_PARTS=()

# ─── 1. Active Project Detection ──────────────────────────────────────────
# Check if CWD matches a known ARKA project
ARKA_OS="${ARKA_OS:-$HOME/.claude/skills/arka}"
if [ -n "$CWD" ] && [ -d "$ARKA_OS/knowledge" ]; then
  # Check projects directory for matching paths
  for proj_dir in "$HOME/.claude/skills/arka"/../arka-*/; do
    [ -d "$proj_dir" ] || continue
    if [ -f "$proj_dir/.project-path" ]; then
      PROJ_PATH=$(cat "$proj_dir/.project-path" 2>/dev/null)
      if [ -n "$PROJ_PATH" ] && [[ "$CWD" == "$PROJ_PATH"* ]]; then
        PROJ_NAME=$(basename "$proj_dir" | sed 's/^arka-//')
        CONTEXT_PARTS+=("[Active Project: $PROJ_NAME]")
        break
      fi
    fi
  done

  # Also check ARKA OS projects/ directory
  REPO_PATH=$(cat "$ARKA_OS/.repo-path" 2>/dev/null || echo "")
  if [ -n "$REPO_PATH" ] && [ -d "$REPO_PATH/projects" ]; then
    for proj_md in "$REPO_PATH/projects"/*/PROJECT.md; do
      [ -f "$proj_md" ] || continue
      PROJ_DIR=$(dirname "$proj_md")
      if [ -f "$PROJ_DIR/.project-path" ]; then
        PROJ_PATH=$(cat "$PROJ_DIR/.project-path" 2>/dev/null)
        if [ -n "$PROJ_PATH" ] && [[ "$CWD" == "$PROJ_PATH"* ]]; then
          PROJ_NAME=$(basename "$PROJ_DIR")
          CONTEXT_PARTS+=("[Active Project: $PROJ_NAME]")
          break
        fi
      fi
    done
  fi
fi

# ─── 2. Department Routing Hints ──────────────────────────────────────────
# Fast string matching — no heavy operations
PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')

if echo "$PROMPT_LOWER" | grep -qE '\b(build|code|feature|deploy|test|review|scaffold|debug|refactor|api|migration|stack)\b'; then
  CONTEXT_PARTS+=("[Department hint: dev]")
elif echo "$PROMPT_LOWER" | grep -qE '\b(budget|invoice|revenue|forecast|profit|loss|roi|margin|cash.?flow|financial|invest)\b'; then
  CONTEXT_PARTS+=("[Department hint: finance]")
elif echo "$PROMPT_LOWER" | grep -qE '\b(social|content|campaign|post|instagram|linkedin|twitter|tiktok|seo|marketing|ads|email.?campaign)\b'; then
  CONTEXT_PARTS+=("[Department hint: marketing]")
elif echo "$PROMPT_LOWER" | grep -qE '\b(store|product|shop|shopify|ecommerce|catalog|inventory|cart|checkout|pricing)\b'; then
  CONTEXT_PARTS+=("[Department hint: ecommerce]")
elif echo "$PROMPT_LOWER" | grep -qE '\b(strategy|brainstorm|market|swot|competitor|roadmap|pivot|growth)\b'; then
  CONTEXT_PARTS+=("[Department hint: strategy]")
elif echo "$PROMPT_LOWER" | grep -qE '\b(task|email|calendar|automate|meeting|workflow|process|schedule|slack|discord|notify)\b'; then
  CONTEXT_PARTS+=("[Department hint: operations]")
elif echo "$PROMPT_LOWER" | grep -qE '\b(learn|persona|knowledge|youtube|transcribe|article|research)\b'; then
  CONTEXT_PARTS+=("[Department hint: knowledge]")
fi

# ─── 3. Time-of-Day Context ──────────────────────────────────────────────
HOUR=$(date +%H)
if [ "$HOUR" -lt 12 ]; then
  CONTEXT_PARTS+=("[Time: morning]")
elif [ "$HOUR" -lt 18 ]; then
  CONTEXT_PARTS+=("[Time: afternoon]")
else
  CONTEXT_PARTS+=("[Time: evening]")
fi

# ─── Output ───────────────────────────────────────────────────────────────
if [ ${#CONTEXT_PARTS[@]} -gt 0 ]; then
  # Join context parts with spaces
  CONTEXT=""
  for part in "${CONTEXT_PARTS[@]}"; do
    CONTEXT+="$part "
  done
  CONTEXT="${CONTEXT% }"  # trim trailing space

  # Output JSON for Claude Code
  jq -n --arg ctx "$CONTEXT" '{
    "hookSpecificOutput": {
      "hookEventName": "UserPromptSubmit",
      "additionalContext": $ctx
    }
  }'
else
  # Silent pass-through — no context to inject
  echo '{}'
fi
