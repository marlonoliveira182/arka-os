#!/usr/bin/env bats
# ============================================================================
# ARKA OS — Status Line Tests
# ============================================================================

load helpers/setup

@test "statusline.sh exists and is executable" {
  [ -f "$REPO_DIR/config/statusline.sh" ]
  [ -x "$REPO_DIR/config/statusline.sh" ]
}

@test "statusline.sh produces output" {
  run bash "$REPO_DIR/config/statusline.sh"
  [ "$status" -eq 0 ]
  [ -n "$output" ]
}

@test "statusline.sh output contains ARKA" {
  run bash "$REPO_DIR/config/statusline.sh"
  [ "$status" -eq 0 ]
  [[ "$output" == *"ARKA"* ]]
}

@test "statusline.sh produces exactly 2 lines" {
  run bash "$REPO_DIR/config/statusline.sh"
  [ "$status" -eq 0 ]
  line_count=$(echo "$output" | wc -l | tr -d ' ')
  [ "$line_count" -eq 2 ]
}
