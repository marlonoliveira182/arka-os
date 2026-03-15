---
name: dev
description: >
  Full-stack development department. Scaffolds new projects, implements features end-to-end,
  reviews code, generates APIs with tests, deploys to environments, manages MCP configurations,
  handles database migrations, debugging, refactoring, and technical documentation.
  Supports Laravel, Vue 3, Nuxt 3, React, Next.js, and Python.
  Use when user says "dev", "build", "code", "feature", "deploy", "test", "review", "scaffold",
  "mcp", "debug", "refactor", "api", "database", "migration", "docs", "stack-check", or any
  development-related task.
---

# Development Department — ARKA OS

Full-stack development team powered by specialized personas.

## Commands

| Command | Description | Personas Involved |
|---------|-------------|-------------------|
| `/dev scaffold <type> <name>` | Create project from real git repos (see sub-skill) | CTO + Senior Dev |
| `/dev feature <description>` | Implement a feature end-to-end | CTO + Senior Dev + QA |
| `/dev api <spec>` | Generate API endpoints + tests + docs | Senior Dev + QA |
| `/dev review` | Code review of current changes | CTO + QA |
| `/dev test` | Generate and run test suite | QA |
| `/dev deploy <env>` | Deploy to environment | DevOps |
| `/dev db <description>` | Database schema + migrations | Senior Dev |
| `/dev refactor <target>` | Refactor code with quality gates | CTO + Senior Dev |
| `/dev debug <issue>` | Diagnose and fix a bug | Senior Dev |
| `/dev docs` | Generate technical documentation | Senior Dev |
| `/dev stack-check` | Check for updates in project dependencies | DevOps + CTO |
| `/dev mcp apply <profile>` | Apply MCP profile to project (see sub-skill) | DevOps |
| `/dev mcp add <name>` | Add single MCP to current project | DevOps |
| `/dev mcp list` | Show all available MCPs from registry | DevOps |
| `/dev mcp status` | Show MCPs active in current project | DevOps |
| `/dev onboard <path>` | Onboard existing project into ARKA OS (see sub-skill) | CTO + Senior Dev |
| `/dev onboard <path> --ecosystem <name>` | Onboard and assign to ecosystem | CTO + Senior Dev |
| `/dev ecosystem list` | List all project ecosystems | CTO |
| `/dev ecosystem create <name>` | Create a new ecosystem | CTO |
| `/dev ecosystem add <project> --to <ecosystem>` | Add project to ecosystem | CTO |
| `/dev skill add <url>` | Install external skill from GitHub | CTO |
| `/dev skill list` | List installed external skills | CTO |
| `/dev skill remove <name>` | Remove external skill | CTO |
| `/dev skill create <name>` | Scaffold new skill from template | CTO + Senior Dev |

## Sub-Skills

| Skill | Path | Purpose |
|-------|------|---------|
| Scaffold | `departments/dev/skills/scaffold/SKILL.md` | Project creation from git repos with auto MCP + Obsidian |
| Onboard | `departments/dev/skills/onboard/SKILL.md` | Onboard existing projects with auto stack detection + MCP + Obsidian |
| MCP | `departments/dev/skills/mcp/SKILL.md` | MCP profile management per project |
| External Skills | (via `arka-skill` CLI) | Install, manage, and create external skills |

For `/dev scaffold` and `/dev mcp` commands, read the respective sub-skill SKILL.md for full workflow instructions.

## Scaffold Types (Quick Reference)

| Type | Git Repository | MCP Profile |
|------|---------------|-------------|
| `laravel` | `git@andreagroferreira:andreagroferreira/laravel-starter-kit.git` | laravel |
| `nuxt-saas` | `https://github.com/nuxt-ui-templates/dashboard.git` | nuxt |
| `nuxt-landing` | `https://github.com/nuxt-ui-templates/landing.git` | nuxt |
| `nuxt-docs` | `https://github.com/nuxt-ui-templates/docs.git` | nuxt |
| `vue-saas` | `https://github.com/nuxt-ui-templates/dashboard-vue.git` | vue |
| `vue-landing` | `https://github.com/nuxt-ui-templates/starter-vue.git` | vue |
| `full-stack` | Laravel + Nuxt (both) | full-stack |
| `react` | React starter (TBD) | react |
| `nextjs` | Next.js starter (TBD) | nextjs |

## Obsidian Output

All development documentation goes to Obsidian vault at `{{OBSIDIAN_VAULT}}`:
- **Architecture decisions:** `Projects/<name>/Architecture/`
- **Tech docs:** `Projects/<name>/Docs/`
- Uses YAML frontmatter, wikilinks `[[]]`, kebab-case tags

## Workflow: /dev feature

1. **CTO** reads project CLAUDE.md/PROJECT.md → decides architecture approach
2. **Senior Dev** implements using project conventions:
   - Laravel: Migration → Model → Service → Controller → FormRequest → Resource → Routes
   - Vue/Nuxt: Composable → Component → Page → Route
3. **QA** generates tests (Feature tests for API, component tests for frontend)
4. **Senior Dev** runs tests and fixes failures
5. All output follows the project's established patterns

## Context Loading

Before ANY development command:
1. Detect which project we're in (check for PROJECT.md or CLAUDE.md)
2. Load project-specific stack, conventions, and patterns
3. Use Context7 MCP to fetch latest docs for the project's framework versions
4. Apply project standards, NOT global defaults (unless no project context)
