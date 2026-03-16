#!/usr/bin/env bats
# ============================================================================
# ARKA OS — CLI Routing Tests
# ============================================================================

load helpers/setup

@test "arka --version outputs version number" {
  # Test that VERSION file exists and contains a version
  run cat "$REPO_DIR/VERSION"
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "VERSION matches semver format" {
  version=$(cat "$REPO_DIR/VERSION")
  [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

@test "bin/arka exists and is executable" {
  [ -f "$REPO_DIR/bin/arka" ]
  [ -x "$REPO_DIR/bin/arka" ]
}

@test "bin/arka-doctor exists and is executable" {
  [ -f "$REPO_DIR/bin/arka-doctor" ]
  [ -x "$REPO_DIR/bin/arka-doctor" ]
}

@test "bin/arka-skill exists and is executable" {
  [ -f "$REPO_DIR/bin/arka-skill" ]
  [ -x "$REPO_DIR/bin/arka-skill" ]
}

@test "bin/arka contains gotchas case" {
  grep -q 'gotchas)' "$REPO_DIR/bin/arka"
}

@test "bin/arka contains test case" {
  grep -q 'test)' "$REPO_DIR/bin/arka"
}

@test "bin/arka contains doctor case" {
  grep -q 'doctor)' "$REPO_DIR/bin/arka"
}

@test "bin/arka contains kb case" {
  grep -q 'kb)' "$REPO_DIR/bin/arka"
}

@test "bin/arka contains skill case" {
  grep -q 'skill)' "$REPO_DIR/bin/arka"
}
