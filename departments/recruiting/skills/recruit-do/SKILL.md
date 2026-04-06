---
name: recruit/recruit-do
description: >
  Smart routing for the recruiting department. Maps natural language
  requests to the appropriate /recruit command.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Recruit Do — `/recruit do <description>`

> **Agent:** Lucia Ferreira (Recruiting Director)

## What It Does

Natural language router for the recruiting department. Analyses the user's request and maps it to the most appropriate `/recruit` command.

## Routing Examples

| Natural Language | Routes To |
|-----------------|-----------|
| "I need to hire a backend developer" | `/recruit brief "Backend Developer"` |
| "Analyse this CV" | `/recruit screen` |
| "How are our open positions doing?" | `/recruit report` |
| "Find candidates who know Python" | `/recruit search "python"` |
| "Prepare interview for João" | `/recruit interview` |
| "We want to make an offer" | `/recruit offer` |
| "Screen these 5 CVs" | `/recruit batch` |
| "Check GDPR compliance" | `/recruit gdpr audit` |
| "Where should we post this job?" | `/recruit source` |

## Routing Logic

1. Extract intent keywords from description
2. Match against command registry (keywords + description)
3. Single high-confidence match → announce agent + execute
4. Multiple matches → show top 3, ask user to pick
5. No match → ask for clarification

## Usage

```
/recruit do "I have 3 CVs for the data engineer position"
/recruit do "prepare for tomorrow's interviews"
```
