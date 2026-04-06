---
name: recruit/sourcing-plan
description: >
  Design a sourcing strategy for a position. Channels, outreach templates,
  employer value proposition, and timeline.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Sourcing Plan — `/recruit source <role>`

> **Agent:** Renato Costa (Talent Sourcer) | **Framework:** Inbound Recruiting (HubSpot model)

## What It Does

Designs a multi-channel sourcing strategy for a given position. References the job brief if it exists in the vault. Produces outreach templates ready to use.

## Output

1. **Channel Strategy** — ranked list of sourcing channels with expected yield
   - Job boards (LinkedIn, Indeed, niche boards)
   - Communities (GitHub, Stack Overflow, Discord, meetups)
   - Referral program design
   - Direct outreach via LinkedIn/email
2. **Outreach Templates** — 3 templates per channel:
   - Initial contact (cold)
   - Follow-up (warm)
   - Referral request
3. **Employer Value Proposition** — 3-4 selling points for this specific role
4. **Boolean Search Strings** — ready-to-paste search queries for LinkedIn and Google
5. **Timeline** — sourcing sprint plan (week-by-week)
6. **Budget Estimate** — if paid channels are recommended

## Usage

```
/recruit source "Senior Backend Developer"
/recruit source "DevOps Engineer" — remote, EU timezone
```
