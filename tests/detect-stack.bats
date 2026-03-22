#!/usr/bin/env bats
# ============================================================================
# ARKA OS — Stack Detection Tests
# ============================================================================

load helpers/setup

@test "detect-stack.py rejects missing path argument" {
  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py"
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "detect-stack.py rejects non-existent directory" {
  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "/nonexistent/path" --json
  [ "$status" -ne 0 ]
}

@test "detect-stack.py detects Laravel project" {
  PROJECT="$TEST_TEMP_DIR/laravel-project"
  mkdir -p "$PROJECT/app/Models" "$PROJECT/app/Http/Controllers" "$PROJECT/database/migrations" "$PROJECT/routes" "$PROJECT/resources/views"

  cat > "$PROJECT/composer.json" << 'COMPOSER'
{
  "require": {
    "laravel/framework": "^11.0",
    "laravel/sanctum": "^4.0"
  },
  "require-dev": {
    "pestphp/pest": "^2.0"
  }
}
COMPOSER

  cat > "$PROJECT/.env.example" << 'ENV'
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
REDIS_HOST=127.0.0.1
ENV

  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "$PROJECT" --json
  [ "$status" -eq 0 ]

  FRAMEWORK=$(echo "$output" | jq -r '.framework')
  [ "$FRAMEWORK" = "Laravel" ]

  MCP_PROFILE=$(echo "$output" | jq -r '.mcp_profile')
  [ "$MCP_PROFILE" = "laravel" ]

  # Check auth detection
  echo "$output" | jq -e '.auth | index("Sanctum")'

  # Check database detection
  echo "$output" | jq -e '.database | index("PostgreSQL")'
}

@test "detect-stack.py detects Nuxt project" {
  PROJECT="$TEST_TEMP_DIR/nuxt-project"
  mkdir -p "$PROJECT/pages" "$PROJECT/components"

  cat > "$PROJECT/package.json" << 'PKG'
{
  "dependencies": {
    "nuxt": "^3.10",
    "vue": "^3.4",
    "@nuxt/ui": "^2.0"
  },
  "devDependencies": {
    "typescript": "^5.3",
    "vitest": "^1.0"
  }
}
PKG

  cat > "$PROJECT/nuxt.config.ts" << 'NUXT'
export default defineNuxtConfig({})
NUXT

  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "$PROJECT" --json
  [ "$status" -eq 0 ]

  FRAMEWORK=$(echo "$output" | jq -r '.framework')
  [ "$FRAMEWORK" = "Nuxt" ]

  MCP_PROFILE=$(echo "$output" | jq -r '.mcp_profile')
  [ "$MCP_PROFILE" = "nuxt" ]
}

@test "detect-stack.py detects Next.js project" {
  PROJECT="$TEST_TEMP_DIR/nextjs-project"
  mkdir -p "$PROJECT/app" "$PROJECT/components"

  cat > "$PROJECT/package.json" << 'PKG'
{
  "dependencies": {
    "next": "^15.0",
    "react": "^19.0",
    "react-dom": "^19.0"
  },
  "devDependencies": {
    "typescript": "^5.3"
  }
}
PKG

  cat > "$PROJECT/next.config.mjs" << 'NEXT'
const nextConfig = {};
export default nextConfig;
NEXT

  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "$PROJECT" --json
  [ "$status" -eq 0 ]

  FRAMEWORK=$(echo "$output" | jq -r '.framework')
  [ "$FRAMEWORK" = "Next.js" ]

  MCP_PROFILE=$(echo "$output" | jq -r '.mcp_profile')
  [ "$MCP_PROFILE" = "nextjs" ]
}

@test "detect-stack.py detects architecture patterns" {
  PROJECT="$TEST_TEMP_DIR/laravel-patterns"
  mkdir -p "$PROJECT/app/Services" "$PROJECT/app/Repositories" "$PROJECT/app/DTOs" "$PROJECT/app/Models"

  cat > "$PROJECT/composer.json" << 'COMPOSER'
{
  "require": {
    "laravel/framework": "^11.0"
  }
}
COMPOSER

  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "$PROJECT" --json
  [ "$status" -eq 0 ]

  echo "$output" | jq -e '.architecture.patterns | index("Services")'
  echo "$output" | jq -e '.architecture.patterns | index("Repositories")'
  echo "$output" | jq -e '.architecture.patterns | index("DTOs")'
}

@test "detect-stack.py detects monorepo" {
  PROJECT="$TEST_TEMP_DIR/monorepo"
  mkdir -p "$PROJECT/api" "$PROJECT/frontend"

  cat > "$PROJECT/api/composer.json" << 'COMPOSER'
{"require": {"laravel/framework": "^11.0"}}
COMPOSER
  cat > "$PROJECT/frontend/package.json" << 'PKG'
{"dependencies": {"nuxt": "^3.10"}}
PKG

  # Need a root package.json or composer.json for detection
  cat > "$PROJECT/composer.json" << 'COMPOSER'
{"require": {"laravel/framework": "^11.0"}}
COMPOSER

  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "$PROJECT" --json
  [ "$status" -eq 0 ]

  ARCH=$(echo "$output" | jq -r '.architecture.type')
  [ "$ARCH" = "monorepo" ]
}

@test "detect-stack.py outputs valid human-readable report" {
  PROJECT="$TEST_TEMP_DIR/simple-project"
  mkdir -p "$PROJECT"
  echo '{"dependencies": {"vue": "^3.4"}}' > "$PROJECT/package.json"

  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "$PROJECT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Framework:"* ]]
  [[ "$output" == *"MCP Profile:"* ]]
}

@test "detect-stack.py empty project returns base profile" {
  PROJECT="$TEST_TEMP_DIR/empty-project"
  mkdir -p "$PROJECT"

  run python3 "$REPO_DIR/departments/dev/skills/onboard/scripts/detect-stack.py" "$PROJECT" --json
  [ "$status" -eq 0 ]

  MCP_PROFILE=$(echo "$output" | jq -r '.mcp_profile')
  [ "$MCP_PROFILE" = "base" ]
}
