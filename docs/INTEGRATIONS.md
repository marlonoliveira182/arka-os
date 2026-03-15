# ARKA OS — Integrations Guide

Integrations connect ARKA OS to external services — task managers, messaging platforms, databases, e-commerce tools, and more. They're optional but unlock powerful features.

---

## What Are Integrations?

Integrations are connections between ARKA OS and external services. When an integration is active, your AI team members can interact with that service directly. For example, with the Slack integration active, you can send messages to your Slack channels without leaving ARKA OS.

ARKA OS comes with **21 built-in integrations**. Some work out of the box, others need an API key or token that you set up once.

---

## All Integrations

| Integration | What It Does | Setup Needed? |
|------------|-------------|:---:|
| Obsidian | Reads and writes to your Obsidian knowledge vault | No |
| Context7 | Gets current documentation for any programming library | No |
| Playwright | Automates browser actions and testing | No |
| Memory Bank | Remembers context between sessions | No* |
| GitHub Search | Searches code across GitHub repositories | No |
| ClickUp | Manages tasks and projects | Yes — API token |
| Firecrawl | Researches and scrapes websites | Yes — API key |
| Sentry | Tracks application errors and performance | No |
| Supabase | Manages databases and APIs | No |
| Laravel Boost | AI-powered tools for Laravel development | No |
| Serena | Code intelligence and refactoring assistance | No |
| Nuxt | Nuxt framework documentation and tools | No |
| Nuxt UI | Nuxt UI component library | No |
| Next DevTools | Next.js development and debugging tools | No |
| Mirakl | Mirakl marketplace API connection | No |
| Shopify | Shopify store development tools | No |
| PostgreSQL | Direct database access and queries | Yes — connection string |
| Slack | Send and receive Slack messages | No (auto sign-in) |
| Discord | Discord bot messaging | Yes — bot token |
| WhatsApp | WhatsApp Business messaging | Yes — API token + phone ID |
| Teams | Microsoft Teams messaging | Yes — app ID + secret |

*Memory Bank may need a storage path configuration depending on your setup.

---

## Setting Up Integrations

### Quick Setup Wizard

The easiest way to set up integrations is the interactive wizard:

```bash
cd arka-os
bash env-setup.sh
```

This walks you through each integration that needs a key or token. For each one, it will:

1. Explain what the integration does
2. Tell you where to get the required credentials
3. Ask you to paste them in
4. Save them securely on your computer

You can skip any integration and come back later by running the wizard again.

### Where Credentials Are Stored

All your credentials are saved in `~/.arka-os/.env` on your computer. They're loaded automatically when you start ARKA OS. They never leave your machine.

---

## Integration Setup Guides

### ClickUp — Task Management

**What it does:** Lets you view, create, and manage tasks in your ClickUp workspace using `/ops tasks`.

**What you need:** A ClickUp API token.

**How to get it:**
1. Log into [ClickUp](https://clickup.com)
2. Click your profile picture (bottom left) → **Settings**
3. Go to **Apps** in the sidebar
4. Under **API Token**, click **Generate**
5. Copy the token

**Set it up:**
```bash
bash env-setup.sh
```
When prompted for ClickUp, paste your API token.

---

### Firecrawl — Web Research

**What it does:** Lets ARKA OS crawl and scrape websites to gather information for market research, competitive analysis, and content learning.

**What you need:** A Firecrawl API key.

**How to get it:**
1. Go to [firecrawl.dev](https://firecrawl.dev)
2. Create an account
3. Navigate to the API section
4. Copy your API key

**Set it up:**
```bash
bash env-setup.sh
```
When prompted for Firecrawl, paste your API key.

---

### Slack — Team Messaging

**What it does:** Lets you send and receive Slack messages using `/ops notify`, `/ops broadcast`, and `/ops channel` commands.

**What you need:** Nothing — Slack uses automatic sign-in (OAuth). The first time you use it, you'll be prompted to authorize access to your Slack workspace.

**Set up a channel:**
```
/ops channel add slack C0123456789
```

**Find your channel ID:** In Slack, right-click on a channel name → **View channel details** → scroll to the bottom to find the Channel ID.

---

### Discord — Community Messaging

**What it does:** Lets you send messages to Discord channels using `/ops notify` and `/ops broadcast`.

**What you need:** A Discord bot token.

**How to get it:**
1. Go to the [Discord Developer Portal](https://discord.com/developers/applications)
2. Click **New Application** → give it a name → **Create**
3. Go to **Bot** in the sidebar
4. Click **Reset Token** and copy it
5. Under **Privileged Gateway Intents**, enable **Message Content Intent**
6. Go to **OAuth2** → **URL Generator** → select **bot** scope → select permissions you need
7. Copy the generated URL and open it in your browser to add the bot to your server

**Set it up:**
```bash
bash env-setup.sh
```
When prompted for Discord, paste your bot token.

**Set up a channel:**
```
/ops channel add discord 123456789012345678
```

**Find your channel ID:** In Discord, enable Developer Mode (User Settings → App Settings → Advanced → Developer Mode). Then right-click a channel → **Copy Channel ID**.

---

### WhatsApp — Business Messaging

**What it does:** Lets you send WhatsApp messages using `/ops notify` and `/ops broadcast`.

**What you need:** A WhatsApp Business API token and Phone Number ID.

**How to get it:**
1. Go to [Meta for Developers](https://developers.facebook.com)
2. Create a new app → select **Business** type
3. Add the **WhatsApp** product
4. In WhatsApp → **Getting Started**, you'll find:
   - **Temporary access token** (or generate a permanent one)
   - **Phone number ID**
5. Copy both values

**Set it up:**
```bash
bash env-setup.sh
```
When prompted for WhatsApp, paste your API token and Phone Number ID.

**Set up a channel:**
```
/ops channel add whatsapp <phone-number>
```

---

### Microsoft Teams — Business Messaging

**What it does:** Lets you send messages to Teams channels using `/ops notify` and `/ops broadcast`.

**What you need:** A Teams App ID and App Secret.

**How to get it:**
1. Go to the [Azure Portal](https://portal.azure.com)
2. Navigate to **App registrations** → **New registration**
3. Give it a name and register
4. Copy the **Application (client) ID** — this is your App ID
5. Go to **Certificates & secrets** → **New client secret**
6. Copy the secret value — this is your App Secret

**Set it up:**
```bash
bash env-setup.sh
```
When prompted for Teams, paste your App ID and App Secret.

**Set up a channel:**
```
/ops channel add teams <channel-id>
```

---

### PostgreSQL — Database Access

**What it does:** Lets ARKA OS connect directly to a PostgreSQL database for queries, migrations, and data management.

**What you need:** A PostgreSQL connection string.

**Connection string format:**
```
postgresql://username:password@hostname:5432/database_name
```

**Set it up:**
```bash
bash env-setup.sh
```
When prompted for PostgreSQL, paste your connection string.

> **Using Supabase?** Your connection string is in the Supabase dashboard under **Settings** → **Database** → **Connection string**.

---

### Sentry — Error Tracking

**What it does:** Tracks application errors and performance issues. When active, your development team can see error reports and diagnose issues.

**Setup:** Sentry is configured per-project. When you create a project with `/dev scaffold`, the Sentry integration is included in the base profile automatically. You'll configure your Sentry DSN in your project's environment variables.

---

### Shopify — E-commerce Development

**What it does:** Connects to Shopify's development tools for building and managing Shopify stores. Used with `/ecom` commands.

**Setup:** Shopify development tools are included in the `ecommerce` integration profile. They're automatically configured when you create an e-commerce project:
```
/dev mcp apply ecommerce
```

---

## Integration Profiles

When you create a project or apply a profile, ARKA OS automatically configures the right integrations. You don't need to set them up one by one.

| Profile | What It Includes | Best For |
|---------|-----------------|---------|
| **base** | Obsidian, Context7, Playwright, Memory Bank, Sentry, GitHub Search, ClickUp, Firecrawl, Supabase | Every project (applied automatically) |
| **laravel** | Everything in base + Laravel Boost, Serena | Laravel PHP projects |
| **nuxt** | Everything in base + Nuxt, Nuxt UI | Nuxt 3 projects |
| **vue** | Everything in base + Nuxt UI | Vue 3 projects |
| **react** | Everything in base + Next DevTools | React projects |
| **nextjs** | Everything in base + Next DevTools, Supabase | Next.js projects |
| **ecommerce** | Everything in base + Laravel Boost, Serena, Mirakl, Shopify | Online store projects |
| **full-stack** | Everything in base + Laravel Boost, Serena, Nuxt, Nuxt UI | Laravel + Nuxt projects |
| **comms** | Everything in base + Slack, Discord, WhatsApp, Teams | Messaging-focused setups |

### Apply a Profile

```
/dev mcp apply laravel
```

### Add a Single Integration

```
/dev mcp add shopify-dev
```

### Check What's Active

```
/dev mcp status
```

---

## Messaging Channels

ARKA OS can send messages to Slack, Discord, WhatsApp, and Teams. Here's how to set it up:

### 1. Set Up Credentials

Run `bash env-setup.sh` and enter your tokens for the platforms you want to use.

### 2. Add Channels

```
/ops channel add slack C0123456789
/ops channel add discord 987654321012345678
```

### 3. Send Messages

```
# Send to your default channel
/ops notify "Deployment complete!"

# Send to all channels at once
/ops broadcast "New version released!"
```

### 4. Manage Channels

```
# See all configured channels
/ops channel list

# Remove a channel
/ops channel remove discord
```

---

## External Integrations

If you have Gmail, Google Calendar, Google Drive, or Canva configured in your Claude Code environment, ARKA OS can use those too. These are managed outside ARKA OS — check Claude Code's documentation for setup instructions.

---

## Troubleshooting

### "Integration not found" or "not available"

1. Check if the integration is in the registry: `/dev mcp list`
2. Make sure you've applied the right profile: `/dev mcp apply <profile>`
3. Verify your credentials are set: restart your terminal and try again

### Messages not sending

1. Check that you've added a channel: `/ops channel list`
2. Verify your token is valid in the service's dashboard
3. Make sure the bot has permission to post in the target channel

### Database connection failing

1. Verify your connection string format: `postgresql://user:pass@host:5432/dbname`
2. Check that the database server is running and accessible
3. Ensure your IP is allowed in the database's firewall rules

### Integration credentials lost

Run the setup wizard again — it will show your current values and let you update them:

```bash
bash env-setup.sh
```
