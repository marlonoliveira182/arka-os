# ARKA OS — WizardingCode Company Operating System

> AI-Powered Company OS. One system. Multiple departments. Infinite capability.

## Version

- **Current:** 0.3.0
- **Version file:** `VERSION`
- **Auto-update:** `version-check.sh` checks for updates once per 24h
- **Update:** Run `arka update` or `cd <repo> && git pull && bash install.sh`

## Identity

- **Company:** WizardingCode
- **System:** ARKA OS
- **Owner:** Andrea Groferreira
- **Purpose:** AI-augmented company operating system that manages development, marketing, e-commerce, finance, operations, and strategy through specialized departments and personas

## Core Principles

1. **One System, Many Departments** — Everything lives here. No scattered projects.
2. **Personas Are Team Members** — Each agent has a name, personality, expertise, and opinion.
3. **Knowledge Compounds** — Every interaction can grow the knowledge base.
4. **Context Is King** — Always read project CLAUDE.md before working on a project.
5. **Action Over Theory** — Every output must be actionable, not academic.
6. **Client-Ready Always** — Reports, proposals, code — ready to deliver without editing.
7. **Obsidian Is The Brain** — ALL output goes to the Obsidian vault. No local files for knowledge.

## CLI Command

ARKA OS installs a global `arka` command:

| Command | Description |
|---------|-------------|
| `arka` | Open Claude Code with ARKA OS |
| `arka --version` | Show installed version |
| `arka update` | Pull latest + reinstall |
| `arka skill install <url>` | Install external skill |
| `arka skill list` | List external skills |
| `arka skill remove <name>` | Remove external skill |
| `arka skill update <name>` | Update external skill |
| `arka skill create <name>` | Scaffold new skill from template |
| `arka kb queue` | Show KB job queue (no Claude Code needed) |
| `arka kb status [job-id]` | Check KB job status (no Claude Code needed) |
| `arka kb capabilities` | Show available tools and API keys |
| `arka kb cleanup` | Remove old media files |
| `arka doctor` | Run health check system (12 checks) |
| `arka doctor --fix` | Run health checks with auto-repair |
| `arka doctor --json` | Output health checks as JSON |

## Tech Stack (Default)

| Layer | Technology | Notes |
|-------|-----------|-------|
| Backend | Laravel 11 (PHP 8.3) | Primary backend framework |
| Frontend | Vue 3 (Composition API) + TypeScript | Always `<script setup>` |
| React | React 19 + Next.js 15 | For React-based projects |
| SSR/Full-stack | Nuxt 3 | For full-stack apps |
| Database | PostgreSQL (via Supabase) | Default DB |
| CSS | Tailwind CSS | Utility-first |
| Python | Python 3.11+ | Scripts, AI, automation |
| Deploy | Vercel / Azure | Depends on project |
| Auth | Laravel Sanctum / Supabase Auth / NextAuth | Depends on project |
| Localhost | Laravel Herd | Always for Laravel projects |

## Coding Standards

- **Laravel:** Services + Repositories pattern, Form Requests, API Resources, Feature Tests
- **Vue/Nuxt:** Composition API only, TypeScript, composables for shared logic
- **React/Next.js:** TypeScript, Server Components, App Router, shadcn/ui
- **Python:** Type hints, docstrings, virtual environments
- **Git:** Conventional commits, feature branches, PR reviews
- **Never:** Options API, raw SQL in controllers, business logic in controllers
- **Enterprise workflow:** All `/dev feature` and `/dev api` commands follow an 8-phase workflow: orchestration → research → architecture → implementation → self-critique → security audit → QA → documentation

## Development Worktree (Mandatory)

All `/dev` commands that modify project code MUST run inside a git worktree. This ensures feature branch isolation, prevents conflicts, and keeps the main branch clean.

**Enforced by:** `departments/dev/SKILL.md` — every code-modifying command starts with `EnterWorktree`

**Commands requiring worktree:** `/dev feature`, `/dev api`, `/dev debug`, `/dev refactor`, `/dev db`

**Branch naming:**
| Type | Prefix | Example |
|------|--------|---------|
| Feature | `feature/` | `feature/user-auth` |
| Bug fix | `fix/` | `fix/login-crash` |
| Refactor | `refactor/` | `refactor/controllers` |

**Workflow:**
1. User runs `/dev feature "description"` (or similar)
2. System calls `EnterWorktree(name: "feature-description")`
3. All code changes happen inside the worktree (isolated branch)
4. Work is committed with conventional commit message
5. User can review, create PR, or merge

## Laravel Mandatory Packages

Every new Laravel project MUST install these in order:

| # | Package | Post-Install | Notes |
|---|---------|-------------|-------|
| 1 | `laravel/boost` | `php artisan boost:install` | MUST be first — enables MCP |
| 2 | `laravel/horizon` | `php artisan horizon:install` | Queue monitoring |
| 3 | `echolabs/prism` | — | AI SDK (multi-provider LLM) |
| 4 | `php-mcp/laravel` | `php artisan vendor:publish` | MCP server for Laravel |

Config: `mcps/stacks/laravel-packages.json`

## Department Commands

| Department | Prefix | Purpose |
|-----------|--------|---------|
| Core System | `/arka` | System-level commands (standup, monitor, status, onboard) |
| Development | `/dev` | Code, build, deploy, review, scaffold, plan, security-audit, research, onboard, MCP management, ecosystems, external skills |
| Marketing | `/mkt` | Social media, content, affiliates, ads |
| E-commerce | `/ecom` | Store management, products, optimization |
| Finance | `/fin` | Financial planning, investment, negotiation |
| Operations | `/ops` | Automations, tasks, emails, calendar, messaging channels |
| Strategy | `/strat` | Market analysis, brainstorming, planning |
| Knowledge | `/kb` | Async content learning, transcription queue, personas, search knowledge |

## Project Scaffolding

Create new projects from real git repositories (9 types):

| Command | Repository | MCP Profile |
|---------|-----------|-------------|
| `/dev scaffold laravel <name>` | `git@andreagroferreira:andreagroferreira/laravel-starter-kit.git` | laravel |
| `/dev scaffold nuxt-saas <name>` | `https://github.com/nuxt-ui-templates/dashboard.git` | nuxt |
| `/dev scaffold nuxt-landing <name>` | `https://github.com/nuxt-ui-templates/landing.git` | nuxt |
| `/dev scaffold nuxt-docs <name>` | `https://github.com/nuxt-ui-templates/docs.git` | nuxt |
| `/dev scaffold vue-saas <name>` | `https://github.com/nuxt-ui-templates/dashboard-vue.git` | vue |
| `/dev scaffold vue-landing <name>` | `https://github.com/nuxt-ui-templates/starter-vue.git` | vue |
| `/dev scaffold full-stack <name>` | Laravel + Nuxt (both repos) | full-stack |
| `/dev scaffold react <name>` | React starter (TBD) | react |
| `/dev scaffold nextjs <name>` | Next.js starter (TBD) | nextjs |

Scaffolding auto-installs dependencies, mandatory packages, applies MCPs, links Herd, and creates Obsidian project page.

## Project Onboarding

Onboard existing projects (mid-development) into ARKA OS with automatic stack detection:

| Command | Description |
|---------|-------------|
| `/dev onboard <path>` | Auto-detect stack, generate PROJECT.md, apply MCPs, create Obsidian docs |
| `/dev onboard <path> --ecosystem <name>` | Onboard and assign to an ecosystem |

Onboarding runs a bundled Python script (`detect-stack.py`) that analyzes `composer.json`, `package.json`, `.env`, and directory structure to auto-detect framework, database, auth, payments, architecture patterns, and recommend the correct MCP profile. No manual input required.

## MCP System

### Registry
Central catalog of all MCPs at `mcps/registry.json` (21 MCPs).

### Profiles
Pre-configured sets of MCPs applied per project type:

| Profile | MCPs |
|---------|------|
| `base` | obsidian, context7, playwright, memory-bank, sentry, gh-grep, clickup, firecrawl, supabase |
| `laravel` | base + laravel-boost, serena |
| `nuxt` | base + nuxt, nuxt-ui |
| `vue` | base + nuxt-ui |
| `react` | base + next-devtools |
| `nextjs` | base + next-devtools, supabase |
| `ecommerce` | base + laravel-boost, serena, mirakl, shopify-dev |
| `full-stack` | base + laravel-boost, serena, nuxt, nuxt-ui |
| `comms` | base + slack, discord, whatsapp, teams |

### Commands
- `/dev mcp apply <profile>` — Apply profile to project
- `/dev mcp add <name>` — Add single MCP
- `/dev mcp list` — Show all available MCPs
- `/dev mcp status` — Show active MCPs

### Environment Setup
Run `bash env-setup.sh` to interactively configure API keys for MCPs that require them (ClickUp, Firecrawl, PostgreSQL, Discord, WhatsApp, Teams).

### How It Works
`mcps/scripts/apply-mcps.sh` generates `.mcp.json` + `.claude/settings.local.json` in the target project.

## Messaging Integration

ARKA OS supports 4 messaging platforms via the `comms` MCP profile:

| Platform | MCP | Auth |
|----------|-----|------|
| Slack | `slack` | OAuth (no manual keys) |
| Discord | `discord` | `DISCORD_TOKEN` |
| WhatsApp | `whatsapp` | `WHATSAPP_API_TOKEN`, `WHATSAPP_PHONE_ID` |
| Teams | `teams` | `TEAMS_APP_ID`, `TEAMS_APP_SECRET` |

**Channel management:**
- `/ops channel add <platform> <channel-id>` — Add messaging channel
- `/ops channel list` — List configured channels
- `/ops channel remove <platform>` — Remove channel
- `/ops notify <message>` — Send to default channel
- `/ops broadcast <message>` — Send to all channels

Config: `knowledge/channels-config.json`

## Community vs Pro

ARKA OS has two tiers:

### Community (this repo)
- 7 departments, 15 personas, 21 MCPs
- Full scaffolding (9 types), MCP management, Obsidian integration
- External skill system, CLI command, auto-updates

### Pro (private repo)
- Additional agents: growth-hacker, copywriter, data-analyst
- Premium skills: advanced-seo, funnel-builder
- Knowledge packs: saas-playbook
- Install: `bash pro-install.sh`
- Info: https://wizardingcode.com/arka-pro

**Naming convention:**

| Type | Prefix | Example |
|------|--------|---------|
| Built-in | `arka-` | `arka-cto.md`, `arka-dev/` |
| Pro | `arka-pro-` | `arka-pro-growth-hacker.md` |
| External | `arka-ext-` | `arka-ext-geo-seo/` |

Manifest: `pro-manifest.json`

## External Skills

Third-party skills can be installed from GitHub repos:

### Standard Format
```
my-skill/
  SKILL.md            (Required — Claude Code skill definition)
  arka-skill.json     (Required — metadata)
  agents/             (Optional — agent definitions)
  mcps/               (Optional — MCPs to register)
    registry-ext.json
```

### Commands
- `arka skill install <github-url>` — Install from GitHub
- `arka skill list` — List installed skills
- `arka skill remove <name>` — Uninstall
- `arka skill update <name>` — Update to latest
- `arka skill create <name>` — Scaffold from template
- `/dev skill add <url>` — Install via Claude Code
- `/dev skill list` — List via Claude Code
- `/dev skill remove <name>` — Remove via Claude Code
- `/dev skill create <name>` — Create via Claude Code

Full spec: `docs/SKILL-STANDARD.md`

## Obsidian Vault

**Path:** `{{OBSIDIAN_VAULT}}` (auto-detected during installation)

ALL department output goes to this Obsidian vault. No local knowledge files.

### Conventions (match existing vault format)
- **Frontmatter:** YAML (type, name/title, tags, date)
- **Links:** Wikilinks `[[Note Name]]`
- **Tags:** kebab-case (`digital-marketing`, `laravel-project`)
- **MOC:** Map of Content pages (`Personas MOC`, `Topics MOC`, etc.)

### Department Output Paths

| Department | Vault Path |
|-----------|-----------|
| `/kb` | `Personas/`, `Sources/`, `Topics/`, `🧠 Knowledge Base/` |
| `/dev` | `Projects/<name>/Architecture/`, `Projects/<name>/Docs/` |
| `/mkt` | `WizardingCode/Marketing/` |
| `/ecom` | `WizardingCode/Ecommerce/` |
| `/fin` | `WizardingCode/Finance/` |
| `/ops` | `WizardingCode/Operations/` |
| `/strat` | `WizardingCode/Strategy/` |

Config: `knowledge/obsidian-config.json`

## Active Projects

Check `projects/` directory for project-specific context. Each project has:
- `PROJECT.md` — Full context (client, stack, decisions, conventions)
- `.project-path` — Absolute path to the actual project directory
- Project-specific overrides to global standards
- Corresponding Obsidian page at `Projects/<name>/Home.md`

## Ecosystems

Group related projects (e.g., API + frontend + admin) into ecosystems:

| Command | Description |
|---------|-------------|
| `/dev ecosystem list` | List all ecosystems and their projects |
| `/dev ecosystem create <name>` | Create a new ecosystem |
| `/dev ecosystem add <project> --to <ecosystem>` | Add project to ecosystem |

Each project in an ecosystem has a role: `api`, `frontend`, `admin`, `worker`, `docs`, `landing`.

Config: `knowledge/ecosystems.json`

## Enhanced Status Line

Two-line color-coded display showing session context and metrics:

```
▲ARKA  project-name  on feature/auth  [wt:feat-auth]  |  Opus 4.6
██████░░░░ 62%  |  145K in 5.2K out  |  +50 -10  |  3m25s  |  $1.23
```

**Features:**
- Color-coded context bar: green <60%, yellow 60-79%, red 80-89%, blinking red 90%+
- Token count in K/M format from `context_window.total_input_tokens`
- Smart git branch: hidden on `main`/`master`
- Worktree indicator: `[wt:name]` when in a worktree
- Cached git operations: `/tmp/arka-statusline-git-cache` (5s TTL)

Config: `config/statusline.sh`

## Hooks System

ARKA OS uses Claude Code hooks for contextual intelligence:

### UserPromptSubmit Hook
Injects context per prompt (10s timeout):
- **Active project detection** — if CWD matches a known project, injects `[Active Project: name]`
- **Department routing hints** — signal word detection (build/code → dev, budget/invoice → fin, etc.)
- **Time-of-day context** — morning/afternoon/evening

Config: `config/hooks/user-prompt-submit.sh`

### PreCompact Hook
Saves session digest before context compaction (30s timeout):
- Extracts last 5 assistant messages
- Saves markdown digest to `~/.arka-os/session-digests/`
- Auto-cleanup: keeps only last 50 digests
- No LLM analysis — raw context preservation

Config: `config/hooks/pre-compact.sh`

## Doctor System

`arka doctor [--fix] [--json]` — 12 modular health checks:

| # | Check | Type | What |
|---|-------|------|------|
| 1 | `claude-cli` | fail | Claude Code CLI installed |
| 2 | `arka-install` | fail | ARKA OS version + SKILL.md |
| 3 | `jq` | fail | jq available |
| 4 | `profile` | warn | User profile exists + has name |
| 5 | `statusline` | warn | Status line configured in settings.json |
| 6 | `hooks` | warn | Hooks configured in settings.json |
| 7 | `obsidian` | warn | Vault path exists and is valid |
| 8 | `departments` | warn | 7+ department skills installed |
| 9 | `personas` | warn | 10+ agent files installed |
| 10 | `mcp-registry` | fail | MCP registry.json present |
| 11 | `prerequisites` | warn | yt-dlp, ffmpeg, python3 |
| 12 | `capabilities` | warn | capabilities.json < 7 days old |

- `--fix` attempts auto-repair (profile, statusline, hooks, capabilities)
- `--json` outputs JSON array for programmatic use

Config: `bin/arka-doctor`

## Capabilities System

ARKA OS detects available tools and API keys via `~/.arka-os/capabilities.json`. This file is generated by `kb-check-capabilities.sh` and updated during install, env-setup, and before `/kb learn`.

**Detected binaries:** `whisper`, `yt-dlp`, `ffmpeg`, `jq`, `python3`
**Detected API keys:** `OPENAI_API_KEY`, `GEMINI_API_KEY`, `OPENROUTER_API_KEY`
**Transcription fallback chain:** local whisper > OpenAI Whisper API > download-only

Commands:
- `arka kb capabilities` — Show capabilities from terminal
- `/kb capabilities` — Show capabilities in Claude Code

Config: `~/.arka-os/capabilities.json`

## KB Async Processing

The Knowledge Base processes YouTube videos asynchronously. Downloads and transcriptions run as background jobs (`nohup`), allowing the user to continue working.

| Command | Description |
|---------|-------------|
| `/kb learn <url> [url2 ...] [--persona "Name"]` | Queue URLs for async download + transcription |
| `/kb queue` | Show all jobs and their status |
| `/kb status [job-id]` | Detailed status of a specific job |
| `/kb process <job-id>` | Interactively analyze a ready transcription |
| `/kb process --all` | Process all ready jobs |
| `/kb capabilities` | Show available tools and API keys |
| `/kb cleanup [--older-than 90d]` | Remove old completed media files |

**Job status flow:** `queued` → `downloading` → `transcribing` → `ready` → `analyzing` → `completed`

The `ready` → `analyzing` transition requires Claude Code (LLM analysis with 5 parallel agents).

## Media Storage

KB media files are stored permanently in `~/.arka-os/media/`, organized by date:

```
~/.arka-os/media/
├── 2026-03-15/
│   ├── a1b2c3d4/          # Job ID
│   │   ├── metadata.json  # Video title, duration
│   │   ├── audio.wav      # Downloaded audio
│   │   ├── audio.txt      # Transcription
│   │   └── worker.log     # Process log
```

State tracking: `~/.arka-os/kb-jobs.json` (all jobs, all statuses, concurrent-safe via `flock`)

Cleanup: `/kb cleanup --older-than 90d` removes completed job media older than 90 days.

## Memory System

- **Obsidian Vault** — Primary knowledge store (personas, topics, sources, reports)
- **Memory Bank MCP** — Persistent session-to-session memory
- **projects/** — Project-specific context and decisions

## MCP Integrations

### ARKA OS MCPs (managed by the system — 21 in registry)

| MCP | Category | Purpose |
|-----|----------|---------|
| Obsidian | base | Vault read/write (Obsidian MCP) |
| Context7 | base | Up-to-date library documentation |
| Playwright | base | Browser automation and testing |
| Memory Bank | base | Persistent memory across sessions |
| Sentry | base | Error tracking and performance |
| GH Grep | base | Search across GitHub repos |
| ClickUp | base | Task management |
| Firecrawl | base | Web crawling and scraping |
| Supabase | base | Database management and APIs |
| Laravel Boost | laravel | AI-powered Laravel development tools |
| Serena | laravel | Code intelligence and refactoring |
| Nuxt UI | nuxt | Nuxt UI component library |
| Nuxt | nuxt | Nuxt framework documentation |
| Next DevTools | react | Next.js development tools |
| Mirakl | ecommerce | Mirakl marketplace API |
| Shopify Dev | ecommerce | Shopify development tools |
| Postgres | base | PostgreSQL direct database access |
| Slack | comms | Slack messaging (OAuth) |
| Discord | comms | Discord bot and messaging |
| WhatsApp | comms | WhatsApp Business API |
| Teams | comms | Microsoft Teams messaging |

### External MCPs (user environment — available if configured)

These MCPs are part of the user's Claude Code environment, not managed by ARKA OS:

| MCP | Purpose |
|-----|---------|
| Gmail | Email communication |
| Google Calendar | Scheduling |
| Google Drive | Document storage |
| Canva | Visual design |

## How To Work

1. **Starting a task:** Read relevant department skill + project CLAUDE.md
2. **Making decisions:** Consult appropriate persona (CTO for tech, CFO for money)
3. **Learning something new:** Use `/kb learn` to add to knowledge base (→ Obsidian)
4. **Creating a project:** Use `/dev scaffold` to bootstrap from real repos
5. **Configuring MCPs:** Use `/dev mcp apply` for per-project MCP setup
6. **Installing skills:** Use `arka skill install <url>` for external skills
7. **Messaging:** Use `/ops channel add` to configure, `/ops notify` to send
8. **Cross-department work:** Skills can reference other departments
9. **All output → Obsidian:** Every report, analysis, and document goes to the vault
