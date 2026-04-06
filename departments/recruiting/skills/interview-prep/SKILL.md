---
name: recruit/interview-prep
description: >
  Generate an interview guide for a role. STAR questions, technical probes,
  culture fit assessment, and evaluation grid.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Interview Prep — `/recruit interview <role>`

> **Agent:** Tiago Rocha (Interview Coach) | **Framework:** STAR Method (DDI), Structured Interviewing (Google re:Work)

## What It Does

Generates a complete interview guide for a role, mapped to the scorecard criteria. Ensures every interviewer asks structured, comparable questions.

## Output

Saved to `Recruiting/Interviews/{date}-{role-slug}-guide.md`:

1. **Opening** (5 min) — rapport questions, process overview
2. **Behavioral Questions** (25 min) — STAR-formatted, mapped to scorecard:
   - Each question includes: criterion targeted, what good looks like, follow-up probes
3. **Technical Probes** (15 min) — role-specific knowledge checks
4. **Culture Fit / Culture Add** (10 min) — Atlassian Culture Add model:
   - What perspectives does this person bring that we lack?
   - How do they handle disagreement? Learning from failure?
5. **Candidate Questions** (5 min) — time for candidate to ask
6. **Evaluation Grid** — aligned to scorecard, pre-filled with criteria and rating scale
7. **Interviewer Notes** — tips for this specific role type
8. **Time Allocation** — minute-by-minute guide

## Usage

```
/recruit interview "Senior Backend Developer"
/recruit interview "Product Manager" — for candidate João Silva
```
