---
name: recruit/candidate-rank
description: >
  Rank all candidates for a position from the candidate database.
  Comparative analysis with scores and strengths.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Candidate Rank — `/recruit rank <position>`

> **Agent:** Mariana Alves (Screening Analyst) | **Framework:** Structured Assessment (Schmidt & Hunter)

## What It Does

Reads all candidates for a given position from the vault database and produces a ranked comparison. Highlights top candidates and flags any with reservations.

## Output

1. **Ranking Table** — sorted by score:
   | Rank | Name | Score | Status | Top Strength | Main Concern |
2. **Top 3 Deep Comparison** — side-by-side must-have scores
3. **Candidates with Reservations** — flagged for review
4. **Gaps Analysis** — requirements no candidate fully meets
5. **Recommendation** — who to interview first and why

## Usage

```
/recruit rank "Senior Backend Developer"
/recruit rank "DevOps Engineer"
```
