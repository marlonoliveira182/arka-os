---
name: recruit/pipeline-report
description: >
  Pipeline report across all open positions. Funnel metrics, time-to-hire,
  bottlenecks, and recommendations.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Pipeline Report — `/recruit report`

> **Agent:** Lucia Ferreira (Recruiting Director) | **Framework:** Talent Acquisition Maturity Model (Josh Bersin)

## What It Does

Generates a comprehensive pipeline report by reading all position and candidate files from the Obsidian vault. Provides funnel metrics, identifies bottlenecks, and recommends actions.

## Output

Saved to `Recruiting/Reports/{date}-pipeline-report.md`:

1. **Executive Summary** — key numbers and headlines
2. **Funnel Metrics** per position:
   | Position | Applied | Screened | Interview | Offer | Hired | Rejected | Pool |
3. **Time-to-Hire** — average days per stage, per position
4. **Bottleneck Analysis** — where candidates are stuck longest
5. **Source Effectiveness** — which channels produce the best candidates
6. **Candidate Status Overview** — all active candidates by status
7. **Recommendations** — specific actions to improve the pipeline
8. **GDPR Status** — candidates approaching retention expiry

## Usage

```
/recruit report
/recruit report — last 30 days
```
