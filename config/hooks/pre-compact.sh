#!/usr/bin/env bash
# ============================================================================
# ARKA OS — PreCompact Hook
# Saves session digest before context compaction
# Timeout: 30s | No LLM analysis — raw context preservation
# ============================================================================

input=$(cat)

# Extract fields
SESSION_ID=$(echo "$input" | jq -r '.session_id // "unknown"' 2>/dev/null)
TRANSCRIPT=$(echo "$input" | jq -r '.transcript // ""' 2>/dev/null)

# ─── Setup ────────────────────────────────────────────────────────────────
DIGEST_DIR="$HOME/.arka-os/session-digests"
mkdir -p "$DIGEST_DIR"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SHORT_ID=$(echo "$SESSION_ID" | head -c 8)
DIGEST_FILE="${DIGEST_DIR}/${TIMESTAMP}-${SHORT_ID}.md"

# ─── Extract Context ──────────────────────────────────────────────────────
# Get last 50 lines of transcript
if [ -n "$TRANSCRIPT" ]; then
  TAIL_LINES=$(echo "$TRANSCRIPT" | tail -50)
else
  TAIL_LINES="(no transcript available)"
fi

# Extract last 5 assistant messages from JSON if available
ASSISTANT_MSGS=""
if echo "$input" | jq -e '.messages' &>/dev/null; then
  ASSISTANT_MSGS=$(echo "$input" | jq -r '
    [.messages[] | select(.role == "assistant") | .content] | last(5) | .[] // empty
  ' 2>/dev/null)
fi

# ─── Write Digest ─────────────────────────────────────────────────────────
cat > "$DIGEST_FILE" << DIGEST_EOF
---
type: session-digest
session_id: ${SESSION_ID}
timestamp: ${TIMESTAMP}
trigger: pre-compact
---

# Session Digest — ${TIMESTAMP}

**Session:** \`${SESSION_ID}\`
**Saved at:** $(date '+%Y-%m-%d %H:%M:%S')
**Trigger:** Context compaction

## Last Assistant Messages

${ASSISTANT_MSGS:-_(none captured)_}

## Transcript Tail (last 50 lines)

\`\`\`
${TAIL_LINES}
\`\`\`
DIGEST_EOF

# ─── Auto-Cleanup: Keep Only Last 50 Digests ─────────────────────────────
DIGEST_COUNT=$(ls -1 "$DIGEST_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$DIGEST_COUNT" -gt 50 ]; then
  REMOVE_COUNT=$((DIGEST_COUNT - 50))
  ls -1t "$DIGEST_DIR"/*.md | tail -"$REMOVE_COUNT" | xargs rm -f 2>/dev/null
fi

# ─── Output ───────────────────────────────────────────────────────────────
# Silent — no output needed for PreCompact hook
echo '{}'
