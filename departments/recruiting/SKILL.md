---
name: arka-recruit
description: >
  Full-cycle recruiting department. 4-agent team covering job briefs, sourcing strategy,
  CV screening, candidate ranking, interview preparation, offer planning, pipeline reporting,
  and candidate database management. GDPR/RGPD compliant. Frameworks: Topgrading, Structured
  Assessment, STAR Method, Culture Add.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Recruiting Department — ArkaOS v2

> **Squad Lead:** Lucia (Recruiting Director) | **Escalation:** Sofia (COO, Tier 0)
> **Agents:** 4 | **Workflows:** Enterprise (6-phase), Focused (4-phase), Specialist (2-phase)

## Commands

| Command | Description | Workflow Tier |
|---------|-------------|---------------|
| `/recruit brief <role>` | Generate structured job description | Focused |
| `/recruit source <role>` | Design sourcing strategy with outreach templates | Focused |
| `/recruit scorecard <role>` | Build weighted evaluation scorecard | Specialist |
| `/recruit screen <cv>` | Analyse CV against job description/scorecard | Focused |
| `/recruit rank <position>` | Rank candidates for a position | Specialist |
| `/recruit batch <position>` | Screen multiple CVs in sequence | Focused |
| `/recruit interview <role>` | Generate interview guide with STAR questions | Focused |
| `/recruit debrief <candidate>` | Post-interview debrief template | Specialist |
| `/recruit offer <candidate>` | Plan job offer with sell strategy | Focused |
| `/recruit report` | Pipeline report with funnel metrics | Specialist |
| `/recruit add <candidate>` | Add/update candidate in database | Specialist |
| `/recruit search <query>` | Search candidate database | Specialist |
| `/recruit do <description>` | Smart routing to the right recruit command | Orchestrator |
| `/recruit gdpr <action>` | GDPR compliance (consent, cleanup, delete, audit) | Specialist |

## Squad

| Agent | Role | Tier | DISC |
|-------|------|------|------|
| **Lucia** | Recruiting Director — Orchestrate, strategy, compliance | 1 | D+I |
| **Renato** | Talent Sourcer — Job descriptions, sourcing, outreach | 2 | I+S |
| **Mariana** | Screening Analyst — CV analysis, scoring, candidate DB | 2 | C+S |
| **Tiago** | Interview Coach — Interview guides, rubrics, debrief | 2 | S+I |

## Enterprise Workflow (6 Phases)

For combined brief + screen flows:

```
Phase 0: BRIEF → Renato creates job description + Lucia reviews
  Gate: User approval

Phase 1: SCORECARD → Mariana builds evaluation criteria
  Gate: Auto

Phase 2: SCREENING → Mariana analyses CVs against scorecard
  Gate: Auto

Phase 3: INTERVIEW PREP → Tiago builds interview guide
  Gate: Auto

Phase 4: QUALITY GATE → Marta dispatches Eduardo (copy) + Francisca (tech)
  Gate: APPROVED required from all three

Phase 5: DELIVERY → Lucia presents results + saves to vault
  Gate: Auto
```

## Focused Workflow (4 Phases)

For `/recruit brief`, `/recruit source`, `/recruit screen`, `/recruit batch`, `/recruit interview`, `/recruit offer`:

```
Phase 0: EXECUTE → Relevant specialist performs the task
Phase 1: REVIEW → Lucia validates output
Phase 2: QUALITY GATE → Marta reviews
Phase 3: DELIVERY → Save to vault
```

## Specialist Workflow (2 Phases)

For `/recruit scorecard`, `/recruit rank`, `/recruit debrief`, `/recruit report`, `/recruit add`, `/recruit search`, `/recruit gdpr`:

```
Phase 0: EXECUTE → Specialist agent performs the task
Phase 1: REPORT → Results saved to vault
```

## Data Architecture (Obsidian Vault)

```
{vault}/Recruiting/
├── Recruiting MOC.md
├── Positions/
│   └── {YYYY-MM-DD}-{role-slug}.md
├── Candidates/
│   └── {YYYY-MM-DD}-{name-slug}.md
├── Interviews/
│   └── {YYYY-MM-DD}-{candidate}-{role}.md
└── Reports/
    └── {YYYY-MM-DD}-pipeline-report.md
```

## GDPR/RGPD Compliance (Built-in)

- Retention dates on all candidate records (default: 12 months)
- Consent tracking in frontmatter
- Right to erasure via `/recruit gdpr delete`
- Automated cleanup via `/recruit gdpr cleanup`
- AI processes and structures data, humans always decide (Art. 22)

## Frameworks Applied

| Framework | Author | Applied In |
|-----------|--------|-----------|
| Topgrading | Bradford Smart | Job briefs, offer planning |
| Structured Assessment | Schmidt & Hunter | Scorecard design, evaluation |
| Competency-Based Screening | Various | CV screening |
| STAR Method | DDI | Interview question design |
| Structured Interviewing | Google re:Work | Interview process |
| Culture Add Assessment | Atlassian | Culture fit (add, not fit) |
| Inbound Recruiting | HubSpot adaptation | Sourcing strategy |
| Talent Acquisition Maturity Model | Josh Bersin | Pipeline metrics |
