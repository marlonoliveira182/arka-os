# ARKA OS — External Skills Guide

External skills let you add new capabilities to ARKA OS. They're created by the community and installed from GitHub.

---

## What Are External Skills?

Skills are packages that teach ARKA OS new tricks. A skill might add:

- New commands (like `/dev geo-seo` for local SEO optimization)
- New AI team members (like a growth hacker or copywriter)
- New integrations (connecting to services ARKA OS doesn't support yet)

Think of them as apps for your AI operating system. Anyone can create one and share it on GitHub.

---

## Installing a Skill

### From Your Terminal

```bash
arka skill install https://github.com/someone/their-skill
```

### From Inside ARKA OS

```
/dev skill install https://github.com/someone/their-skill
```

Both do the same thing — pick whichever you prefer.

### What Happens During Installation

1. The skill is downloaded from GitHub
2. ARKA OS checks that it's a valid skill (has the required files)
3. The skill is copied into your ARKA OS setup
4. Any AI team members included in the skill are installed
5. Any integrations included in the skill are registered
6. The skill appears in your installed skills list

---

## Managing Skills

### List Installed Skills

See everything you've installed:

```bash
# From terminal
arka skill list

# From inside ARKA OS
/dev skill list
```

### Update a Skill

Get the latest version of an installed skill:

```bash
# From terminal
arka skill update skill-name

# From inside ARKA OS
/dev skill update skill-name
```

### Remove a Skill

Uninstall a skill you no longer need:

```bash
# From terminal
arka skill remove skill-name

# From inside ARKA OS
/dev skill remove skill-name
```

This removes the skill, its AI team members, and its integrations.

---

## Creating Your Own Skill

Want to build a skill? ARKA OS includes a template to get you started.

### Step 1: Generate the Template

```bash
arka skill create my-awesome-skill
```

This creates a folder with everything you need:

```
my-awesome-skill/
├── SKILL.md              ← What the skill does and its commands
├── arka-skill.json       ← Skill info (name, version, description)
├── README.md             ← Documentation for GitHub
├── agents/               ← AI team members (optional)
└── mcps/                 ← Integrations (optional)
    └── registry-ext.json
```

### Step 2: Define Your Skill

Edit `SKILL.md` to describe what your skill does and what commands it adds. This file is what ARKA OS reads to understand the skill.

Edit `arka-skill.json` to set your skill's metadata:

```json
{
  "name": "my-awesome-skill",
  "version": "1.0.0",
  "description": "What this skill does in one sentence",
  "author": "Your Name",
  "requires_arka_version": ">=0.2.0",
  "commands": ["/dev my-command"]
}
```

### Step 3: Add Team Members (Optional)

If your skill includes AI team members, add them as markdown files in the `agents/` folder. Each file defines a team member's name, personality, expertise, and behavior.

### Step 4: Add Integrations (Optional)

If your skill connects to external services, define them in `mcps/registry-ext.json`. These get merged into ARKA OS's integration registry when the skill is installed.

### Step 5: Share It

Push your skill to GitHub and anyone can install it with:

```bash
arka skill install https://github.com/you/my-awesome-skill
```

---

## Skill Structure

Every skill must have at least these two files:

| File | Required | What It Does |
|------|:---:|-------------|
| `SKILL.md` | Yes | Defines the skill — commands, workflows, and behavior |
| `arka-skill.json` | Yes | Metadata — name, version, description, author |
| `agents/` | No | AI team member definitions |
| `mcps/registry-ext.json` | No | Integration definitions |
| `README.md` | No | Documentation for GitHub |

### arka-skill.json Fields

| Field | Required | Description |
|-------|:---:|------------|
| `name` | Yes | Skill name (lowercase, hyphens) |
| `version` | Yes | Version number (e.g., "1.0.0") |
| `description` | Yes | One-sentence description |
| `author` | Yes | Creator name or organization |
| `requires_arka_version` | No | Minimum ARKA OS version needed (e.g., ">=0.2.0") |
| `commands` | No | List of commands the skill adds |

---

## Naming Conventions

ARKA OS uses prefixes to distinguish where things come from:

| Prefix | What It Means | Example |
|--------|-------------|---------|
| `arka-` | Built into ARKA OS | `arka-cto.md` |
| `arka-pro-` | Part of ARKA OS Pro | `arka-pro-growth-hacker.md` |
| `arka-ext-` | Installed external skill | `arka-ext-geo-seo.md` |

When you install a skill, ARKA OS automatically adds the `arka-ext-` prefix. You don't need to include it in your skill's name.

---

## Pro Content

ARKA OS Pro adds premium team members, skills, and knowledge packs that aren't in the free version.

### What's in Pro

| Type | Name | What It Does |
|------|------|-------------|
| Team Member | Growth Hacker | Data-driven growth strategies and experiments |
| Team Member | Copywriter | Specialized persuasive writing |
| Team Member | Data Analyst | Advanced data analysis and visualization |
| Skill | Advanced SEO | In-depth SEO audits and optimization |
| Skill | Funnel Builder | Sales funnel design and optimization |
| Knowledge Pack | SaaS Playbook | Proven strategies for building and scaling SaaS |

### Installing Pro

```bash
bash pro-install.sh
```

This requires access to the private Pro repository. Visit [wizardingcode.com/arka-pro](https://wizardingcode.com/arka-pro) for access.

---

## Technical Details

For developers building skills, the full technical specification is available at [SKILL-STANDARD.md](SKILL-STANDARD.md). It covers:

- File format requirements
- Agent definition format
- Integration registry format
- Version compatibility
- Installation flow details
