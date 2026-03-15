# ARKA OS

**Your AI-powered company operating system.** One system runs your entire business — development, marketing, sales, finance, operations, and strategy — with a team of AI specialists that actually know what they're doing.

Built by [WizardingCode](https://wizardingcode.com). Current version: **0.2.0**

---

## What Is ARKA OS?

ARKA OS turns Claude into a full company operating system. Instead of one generic AI assistant, you get **10 specialized team members** organized into **7 departments** — each with their own expertise, personality, and opinions. They write code, create marketing content, analyze finances, plan strategy, and manage operations.

Everything they produce is saved to your [Obsidian](https://obsidian.md) vault, so your company knowledge grows with every interaction.

## Key Features

- **10 AI Team Members** — A CTO, developer, QA engineer, DevOps, content creator, e-commerce manager, CFO, COO, strategist, and knowledge curator
- **7 Departments** — Development, Marketing, E-commerce, Finance, Operations, Strategy, Knowledge Base
- **Project Scaffolding** — Create new projects from real starter templates (Laravel, Nuxt, Vue, React, Next.js) with one command
- **21 Built-in Integrations** — Connect to Slack, Discord, ClickUp, Shopify, Sentry, GitHub, databases, and more
- **Obsidian Knowledge Base** — Every report, analysis, and document is saved to your Obsidian vault automatically
- **External Skills** — Extend ARKA OS with community-built skills from GitHub
- **Auto-Updates** — Checks for new versions automatically

---

## Quick Install

```bash
# 1. Clone the repository
git clone https://github.com/andreagroferreira/arka-os.git

# 2. Run the installer
cd arka-os && bash install.sh

# 3. Load the CLI (or restart your terminal)
source ~/.zshrc    # or: source ~/.bashrc
```

That's it. Type `arka` to start.

> **Requires:** [Claude Code](https://claude.ai/code) must be installed first.

---

## What Can You Do?

Here are real commands you can run right away:

| Command | What It Does |
|---------|-------------|
| `/arka help` | See every available command across all departments |
| `/dev scaffold laravel my-app` | Create a new Laravel project with everything set up |
| `/mkt social instagram "New product launch"` | Generate Instagram posts for a product launch |
| `/fin report monthly` | Generate a monthly financial report |
| `/strat brainstorm "Enter the US market"` | Run a strategy brainstorm with 5 different perspectives |
| `/kb learn https://youtube.com/watch?v=...` | Learn from a YouTube video and build a knowledge profile |

---

## Your AI Team

Every team member has a name, a personality, and real expertise. They don't just answer questions — they have opinions and push back when something doesn't make sense.

| Name | Role | What They Do |
|------|------|-------------|
| **Marco** | CTO | Makes architecture decisions, reviews code, prioritizes security and scalability |
| **Andre** | Senior Developer | Writes code, follows patterns, handles edge cases, tests everything |
| **Rita** | QA Engineer | Tests happy paths, sad paths, and edge cases — finds what will break |
| **Carlos** | DevOps Engineer | Automates deployments, manages infrastructure, monitors systems |
| **Luna** | Content Creator | Creates platform-native content for Instagram, LinkedIn, TikTok, YouTube, X |
| **Ricardo** | E-commerce Manager | Optimizes stores, analyzes conversions, scales revenue |
| **Helena** | CFO | Manages finances, budgets, forecasts, investor pitches, and negotiations |
| **Sofia** | COO | Runs operations, creates processes, manages tasks and client onboarding |
| **Tomas** | Chief Strategist | Analyzes markets, runs brainstorms, plans strategy with proven frameworks |
| **Clara** | Knowledge Curator | Learns from content, builds expert profiles, organizes company knowledge |

---

## Departments

| Prefix | Department | What It Does |
|--------|-----------|-------------|
| `/arka` | System | Daily standups, system status, monitoring, project onboarding |
| `/dev` | Development | Scaffold projects, write features, review code, manage integrations |
| `/mkt` | Marketing | Social media posts, content calendars, ad copy, email sequences |
| `/ecom` | E-commerce | Store audits, product optimization, pricing strategy, launch plans |
| `/fin` | Finance | Financial reports, budgets, forecasts, investor prep, negotiation |
| `/ops` | Operations | Task management, emails, calendar, meetings, messaging channels |
| `/strat` | Strategy | Market analysis, brainstorming, SWOT, competitive intelligence |
| `/kb` | Knowledge | Learn from videos/articles, build expert personas, search knowledge |

---

## Available Commands

### System (`/arka`)

| Command | What It Does |
|---------|-------------|
| `/arka help` | Show all commands from all departments |
| `/arka standup` | Daily summary — projects, tasks, meetings, emails |
| `/arka status` | System status — version, departments, personas, integrations |
| `/arka monitor` | Check for tech stack updates and recommendations |
| `/arka onboard <project>` | Set up a new project with context files and Obsidian page |

### Development (`/dev`)

| Command | What It Does |
|---------|-------------|
| `/dev scaffold <type> <name>` | Create a new project from a starter template |
| `/dev feature <description>` | Implement a new feature following project conventions |
| `/dev review` | Get a code review from the CTO |
| `/dev test` | Run tests and get a quality report |
| `/dev deploy <env>` | Deploy to staging or production |
| `/dev db migrate` | Run database migrations |
| `/dev mcp apply <profile>` | Set up integrations for a project |
| `/dev mcp add <name>` | Add a single integration to a project |
| `/dev mcp list` | Show all available integrations |
| `/dev mcp status` | Show active integrations for current project |
| `/dev skill install <url>` | Install an external skill |
| `/dev skill list` | List installed external skills |
| `/dev skill remove <name>` | Remove an external skill |
| `/dev skill create <name>` | Create a new skill from the template |

### Marketing (`/mkt`)

| Command | What It Does |
|---------|-------------|
| `/mkt social <platform> <topic>` | Generate social media posts |
| `/mkt calendar <period>` | Create a content calendar |
| `/mkt reels <topic>` | Script short-form video content (Reels, TikTok, Shorts) |
| `/mkt email <type> <topic>` | Write email sequences |
| `/mkt landing <product>` | Create landing page copy |
| `/mkt ads <platform> <product>` | Write ad copy for any platform |
| `/mkt affiliate <analysis>` | Analyze affiliate marketing opportunities |
| `/mkt blog <topic>` | Write a blog article |
| `/mkt copy-analysis <url>` | Analyze existing copy and suggest improvements |
| `/mkt brand-guide` | Create brand guidelines |
| `/mkt audit` | Run a full marketing audit |

### E-commerce (`/ecom`)

| Command | What It Does |
|---------|-------------|
| `/ecom audit <store-url>` | Full store audit (UX, SEO, performance, content, conversion) |
| `/ecom product <listing>` | Optimize a product listing |
| `/ecom pricing <product>` | Analyze and recommend pricing strategy |
| `/ecom competitors <niche>` | Competitive analysis for your niche |
| `/ecom launch <product>` | Create a product launch plan |
| `/ecom ads <product>` | Create ad campaigns for products |
| `/ecom email-flows` | Design automated email sequences |
| `/ecom report` | Generate e-commerce performance report |

### Finance (`/fin`)

| Command | What It Does |
|---------|-------------|
| `/fin report <type>` | Generate financial reports (monthly, quarterly, annual) |
| `/fin forecast <period>` | Create revenue and expense forecasts |
| `/fin budget <project>` | Build a project or company budget |
| `/fin negotiate <context>` | Prepare for a negotiation with strategy and talking points |
| `/fin pitch <context>` | Prepare an investor pitch with financial data |
| `/fin analysis <topic>` | Run financial analysis on any topic |
| `/fin investment <opportunity>` | Analyze an investment opportunity |
| `/fin portfolio` | Review and manage investment portfolio |
| `/fin invoice <client>` | Generate an invoice |

### Operations (`/ops`)

| Command | What It Does |
|---------|-------------|
| `/ops tasks` | View and manage tasks (via ClickUp) |
| `/ops email <type>` | Draft professional emails |
| `/ops calendar` | View upcoming calendar events |
| `/ops meeting <topic>` | Prepare meeting agenda and materials |
| `/ops invoice <client>` | Generate and track invoices |
| `/ops automate <process>` | Design process automations |
| `/ops report` | Generate operational reports |
| `/ops onboard <client>` | Create client onboarding workflow |
| `/ops standup` | Run daily standup review |
| `/ops channel add <platform> <id>` | Add a messaging channel (Slack, Discord, WhatsApp, Teams) |
| `/ops channel list` | Show configured messaging channels |
| `/ops channel remove <platform>` | Remove a messaging channel |
| `/ops notify <message>` | Send a message to the default channel |
| `/ops broadcast <message>` | Send a message to all channels |

### Strategy (`/strat`)

| Command | What It Does |
|---------|-------------|
| `/strat brainstorm <topic>` | Structured brainstorm with 5 perspectives |
| `/strat market <industry>` | Full market analysis (TAM/SAM/SOM) |
| `/strat prospect <criteria>` | Find and analyze potential clients |
| `/strat compete <competitor>` | Competitive intelligence report |
| `/strat swot <business>` | SWOT analysis |
| `/strat evaluate <idea>` | Evaluate a business idea |
| `/strat pivot <context>` | Analyze strategic pivot options |
| `/strat roadmap <product>` | Create a product or business roadmap |
| `/strat trends <industry>` | Analyze industry trends |

### Knowledge Base (`/kb`)

| Command | What It Does |
|---------|-------------|
| `/kb learn <source>` | Learn from a YouTube video, article, or text |
| `/kb search <query>` | Search the knowledge base |
| `/kb persona list` | List all expert personas |
| `/kb persona <name>` | View a specific persona's profile |
| `/kb topic <name>` | View or create a topic page |
| `/kb generate <persona> <topic>` | Generate content in a persona's voice and style |

---

## Project Types

Create fully configured projects with one command. Each comes with dependencies installed, integrations configured, and an Obsidian project page.

| Command | What You Get |
|---------|-------------|
| `/dev scaffold laravel <name>` | Laravel 11 + PHP 8.3 backend |
| `/dev scaffold nuxt-saas <name>` | Nuxt 3 SaaS dashboard |
| `/dev scaffold nuxt-landing <name>` | Nuxt 3 landing page |
| `/dev scaffold nuxt-docs <name>` | Nuxt 3 documentation site |
| `/dev scaffold vue-saas <name>` | Vue 3 SaaS dashboard |
| `/dev scaffold vue-landing <name>` | Vue 3 landing page |
| `/dev scaffold full-stack <name>` | Laravel backend + Nuxt frontend |
| `/dev scaffold react <name>` | React starter project |
| `/dev scaffold nextjs <name>` | Next.js starter project |

---

## Integrations

ARKA OS connects to 21 external services. Integrations are automatically configured when you create a project.

| Integration | What It Does |
|------------|-------------|
| Obsidian | Reads and writes to your knowledge vault |
| Context7 | Gets up-to-date documentation for any library |
| Playwright | Automates browser testing |
| Memory Bank | Remembers context between sessions |
| ClickUp | Manages tasks and projects |
| Firecrawl | Crawls and scrapes websites for research |
| Sentry | Tracks errors and performance |
| GitHub Search | Searches across GitHub repositories |
| Supabase | Manages databases and APIs |
| Laravel Boost | AI-powered Laravel development tools |
| Serena | Code intelligence and refactoring |
| Nuxt UI | Nuxt component library |
| Shopify | Shopify store development |
| Slack | Send and receive Slack messages |
| Discord | Discord bot and messaging |
| WhatsApp | WhatsApp Business messaging |
| Teams | Microsoft Teams messaging |
| PostgreSQL | Direct database access |

[Full integration setup guide &rarr;](docs/INTEGRATIONS.md)

---

## Community vs Pro

| Feature | Community (Free) | Pro |
|---------|:-:|:-:|
| 7 departments | Yes | Yes |
| 10 AI team members | Yes | Yes |
| 21 integrations | Yes | Yes |
| 9 project types | Yes | Yes |
| External skills | Yes | Yes |
| CLI + auto-updates | Yes | Yes |
| Growth Hacker agent | - | Yes |
| Copywriter agent | - | Yes |
| Data Analyst agent | - | Yes |
| Advanced SEO skill | - | Yes |
| Funnel Builder skill | - | Yes |
| SaaS Playbook | - | Yes |

[Learn more about Pro &rarr;](https://wizardingcode.com/arka-pro)

---

## External Skills

Extend ARKA OS with community-built skills from GitHub:

```bash
# Install a skill
arka skill install https://github.com/someone/cool-skill

# List installed skills
arka skill list

# Create your own skill
arka skill create my-skill
```

[Full external skills guide &rarr;](docs/EXTERNAL-SKILLS.md)

---

## Documentation

| Guide | What It Covers |
|-------|---------------|
| [Getting Started](docs/GETTING-STARTED.md) | Installation, first run, beginner walkthrough |
| [Commands](docs/COMMANDS.md) | Complete command reference |
| [Departments](docs/DEPARTMENTS.md) | Deep dive into each department and team member |
| [Integrations](docs/INTEGRATIONS.md) | How to connect external services |
| [External Skills](docs/EXTERNAL-SKILLS.md) | Installing, managing, and creating skills |
| [Skill Standard](docs/SKILL-STANDARD.md) | Technical spec for skill developers |

---

## License

MIT License. See [LICENSE](LICENSE) for details.

Built with purpose by [WizardingCode](https://wizardingcode.com).
