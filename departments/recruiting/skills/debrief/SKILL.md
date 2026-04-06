---
name: recruit/debrief
description: >
  Post-interview debrief template. Structured feedback form, scorecard ratings,
  culture fit assessment, and go/no-go recommendation.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Debrief — `/recruit debrief <candidate>`

> **Agent:** Tiago Rocha (Interview Coach) | **Framework:** Culture Add Assessment (Atlassian)

## What It Does

Generates a post-interview debrief template for a specific candidate. Designed to capture structured feedback from all interviewers and facilitate a data-driven hiring decision.

## Output

Saved to `Recruiting/Interviews/{date}-{candidate}-debrief.md`:

1. **Candidate Summary** — name, position, interview date, interviewers
2. **Scorecard Ratings** — each criterion rated 1-5 by each interviewer
3. **Behavioral Evidence** — STAR responses noted per criterion
4. **Culture Add Assessment**:
   - What new perspectives does this candidate bring?
   - Team dynamics impact (positive/negative signals)
   - Values alignment evidence
5. **Concerns & Risks** — flagged by any interviewer
6. **Consensus Section**:
   - Individual verdicts per interviewer
   - Overall recommendation: GO / NO-GO / NEEDS DISCUSSION
7. **Next Steps Checklist** — reference check, second round, offer prep

## Usage

```
/recruit debrief "João Silva" — for Senior Backend Developer
/recruit debrief "Maria Santos"
```
