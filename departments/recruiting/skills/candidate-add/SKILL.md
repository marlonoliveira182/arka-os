---
name: recruit/candidate-add
description: >
  Add or update a candidate in the vault database. Structured markdown
  with YAML frontmatter, position, score, status, GDPR retention date.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Candidate Add — `/recruit add <candidate>`

> **Agent:** Mariana Alves (Screening Analyst)

## What It Does

Creates or updates a candidate record in the Obsidian vault. Each candidate is a markdown file with structured YAML frontmatter for searchability and compliance.

## Output

Saved to `Recruiting/Candidates/{date}-{name-slug}.md`:

### Frontmatter Schema

```yaml
---
type: candidate
name: "Full Name"
email: "email@example.com"
phone: "+351 XXX XXX XXX"
positions:
  - role: "Senior Backend Developer"
    score: 78
    status: new  # new|screening|interview|offer|hired|rejected|pool
    applied: 2026-04-06
source: "LinkedIn"
skills:
  - Python
  - FastAPI
  - PostgreSQL
tags: [senior, backend, python]
gdpr:
  consent_date: 2026-04-06
  retention_until: 2027-04-06
  processing_basis: "consent"
created: 2026-04-06
updated: 2026-04-06
---
```

### Body Content

- **Summary** — brief candidate profile
- **Screening History** — linked screening reports
- **Interview History** — linked debrief reports
- **Notes** — free-form observations

### Status Transitions

```
new → screening → interview → offer → hired
                                    → rejected
                          → rejected
               → rejected
         → pool (for future positions)
```

## Usage

```
/recruit add "João Silva" — senior backend, scored 82, from LinkedIn
/recruit add "Maria Santos" — update status to interview
```
