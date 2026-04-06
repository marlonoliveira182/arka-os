---
name: recruit/cv-screen
description: >
  Analyse a single CV against a job description and scorecard. Match score,
  must-haves checklist, gaps, red flags, and recommendation.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# CV Screen — `/recruit screen <cv>`

> **Agent:** Mariana Alves (Screening Analyst) | **Framework:** Competency-Based Screening

## What It Does

Analyses a single CV against a job description/scorecard. Produces a structured evaluation with evidence-based scoring. The recommendation is a suggestion — humans always make the final decision.

## Input

- CV text (pasted directly or file path)
- Position reference (matched from vault or specified)

## Output

1. **Match Score** (0-100) — weighted against scorecard criteria
2. **Must-Haves Checklist** — each requirement with:
   - Met / Partially Met / Not Met
   - Evidence from CV (quoted)
3. **Nice-to-Haves Matched** — bonus qualifications found
4. **Experience Analysis** — years, progression, domain relevance
5. **Red Flags** — gaps, inconsistencies, overqualification, concerns
6. **Culture Fit Signals** — indicators from CV (consulting, international, learning)
7. **Recommendation**: ADVANCE / ADVANCE WITH RESERVATIONS / REJECT
   - With reasoning (2-3 sentences)

Candidate is automatically added to the database via `candidate-add`.

## Usage

```
/recruit screen [paste CV text]
/recruit screen /path/to/cv.pdf — for Senior Backend Developer
```
