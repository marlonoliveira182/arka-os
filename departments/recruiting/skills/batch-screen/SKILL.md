---
name: recruit/batch-screen
description: >
  Screen multiple CVs in sequence for the same position. Runs cv-screen
  logic for each, adds to database, produces summary.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Batch Screen — `/recruit batch <position>`

> **Agent:** Mariana Alves (Screening Analyst) | **Framework:** Competency-Based Screening

## What It Does

Processes multiple CVs for the same position in a single session. For each CV: runs the `cv-screen` analysis, adds the candidate to the database, and produces a summary table at the end.

## Input

- Position reference
- Multiple CVs (pasted sequentially, file paths, or directory)

## Output

Per candidate:
- Individual screening report (same as `cv-screen`)
- Auto-added to candidate database

Summary:
1. **Results Table** — all candidates ranked by score
2. **Advance List** — candidates scoring 60+
3. **Reject List** — candidates below threshold
4. **Pipeline Update** — position candidate count updated

## Usage

```
/recruit batch "Senior Backend Developer"
> [paste CV 1]
> [paste CV 2]
> [paste CV 3]
```
