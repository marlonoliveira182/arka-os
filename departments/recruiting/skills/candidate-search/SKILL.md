---
name: recruit/candidate-search
description: >
  Search the candidate database by skills, position, score, status,
  or date range. Fuzzy matching on skills and role titles.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Candidate Search — `/recruit search <query>`

> **Agent:** Mariana Alves (Screening Analyst)

## What It Does

Searches the candidate database in the Obsidian vault. Reads all candidate files, parses frontmatter, and filters based on the query. Supports multiple search criteria.

## Search Capabilities

| Criteria | Example | Match Type |
|----------|---------|-----------|
| Skills | `python`, `react` | Fuzzy (Python matches python, py) |
| Position | `backend developer` | Fuzzy on role title |
| Status | `status:interview` | Exact match |
| Score | `score:>70` | Numeric comparison |
| Source | `source:linkedin` | Exact match |
| Date | `after:2026-03-01` | Date range |
| Combined | `python status:pool score:>60` | AND logic |

## Output

1. **Results Table**:
   | Name | Position | Score | Status | Skills Match | Source |
2. **Result Count** — total matches
3. **Quick Actions** — suggested next steps per candidate

## Usage

```
/recruit search "python senior"
/recruit search "status:pool score:>70"
/recruit search "react frontend after:2026-01-01"
```
