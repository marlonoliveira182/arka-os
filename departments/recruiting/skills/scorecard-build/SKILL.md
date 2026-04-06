---
name: recruit/scorecard-build
description: >
  Build a weighted evaluation scorecard for a role. Criteria, rubric,
  red flags, and culture fit indicators.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Scorecard Build — `/recruit scorecard <role>`

> **Agent:** Mariana Alves (Screening Analyst) | **Framework:** Structured Assessment (Schmidt & Hunter)

## What It Does

Creates a weighted evaluation scorecard from a job brief. Used as input for `cv-screen`, `candidate-rank`, and `interview-prep`. Ensures consistent, objective evaluation across all candidates.

## Output

1. **Must-Have Criteria** — weighted (total 100%), each with:
   - Criterion name
   - Weight (%)
   - Rating anchors (1-5 scale with concrete descriptions)
   - Evidence guidance (what to look for in CV/interview)
2. **Nice-to-Have Criteria** — bonus points, not weighted
3. **Automatic Red Flags** — conditions that trigger review:
   - Employment gaps > 12 months unexplained
   - Frequent job changes (< 1 year x 3+)
   - Missing core requirement
   - Inconsistencies between dates/roles
4. **Culture Fit Indicators** — based on job brief culture markers
5. **Score Thresholds**:
   - 80-100: Strong match → ADVANCE
   - 60-79: Potential match → ADVANCE WITH RESERVATIONS
   - Below 60: Weak match → REJECT (recommendation only)

## Usage

```
/recruit scorecard "Senior Backend Developer"
/recruit scorecard "Product Manager" — uses existing job brief if found
```
