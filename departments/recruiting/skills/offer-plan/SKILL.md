---
name: recruit/offer-plan
description: >
  Plan a job offer for a candidate. Compensation recommendation, sell strategy,
  counter-offer preparation, and approval checklist.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Offer Plan — `/recruit offer <candidate>`

> **Agent:** Lucia Ferreira (Recruiting Director) | **Framework:** Topgrading (Bradford Smart)

## What It Does

Plans a compelling job offer for a specific candidate. Uses data from the job brief (salary range), screening analysis (candidate profile), and interview debrief to craft a targeted offer strategy.

## Output

1. **Compensation Package**:
   - Base salary recommendation (within job brief range)
   - Positioning rationale (why this number for this candidate)
   - Benefits highlights relevant to this candidate
2. **Sell Strategy**:
   - Top 3 motivators for this candidate (derived from CV/interview)
   - Key selling points to emphasize
   - Concerns to address proactively
3. **Counter-Offer Preparation**:
   - Likely counter-offer scenarios
   - Response strategy for each
   - Walk-away point
4. **Timeline**:
   - Offer call date
   - Decision deadline
   - Start date target
5. **Approval Checklist**:
   - [ ] Budget approved by hiring manager
   - [ ] Compensation within band
   - [ ] Reference checks complete
   - [ ] Offer letter drafted

## Usage

```
/recruit offer "João Silva" — for Senior Backend Developer
/recruit offer "Maria Santos" — include relocation
```
