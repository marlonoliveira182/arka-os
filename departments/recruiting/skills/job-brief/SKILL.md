---
name: recruit/job-brief
description: >
  Generate a structured job description from a role title. Includes requirements,
  must-haves, nice-to-haves, salary range guidance, and culture markers.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Job Brief — `/recruit brief <role>`

> **Agent:** Renato Costa (Talent Sourcer) | **Framework:** Topgrading (Bradford Smart)

## What It Does

Generates a complete, structured job description from a role title or brief description. Researches the role, identifies key requirements, and produces a document ready for sourcing and screening.

## Output

Markdown document saved to `Recruiting/Positions/{date}-{role-slug}.md` with:

1. **Role Summary** — one-paragraph overview of the position
2. **Responsibilities** — 5-8 key responsibilities
3. **Must-Have Requirements** — non-negotiable qualifications (used by scorecard)
4. **Nice-to-Have Requirements** — preferred but not required
5. **Salary Range Guidance** — market-informed range (user validates)
6. **Culture Markers** — traits that indicate culture add
7. **Red Flag Indicators** — signals to watch for during screening
8. **Sourcing Hints** — where this type of candidate is typically found

## Frontmatter Schema

```yaml
---
type: position
name: "{Role Title}"
department: "{Department}"
status: open
priority: medium
location: ""
salary_range: ""
candidates_count: 0
created: {date}
---
```

## Usage

```
/recruit brief Senior Backend Developer
/recruit brief "Data Engineer with Kafka experience"
/recruit brief Product Manager — fintech startup
```
