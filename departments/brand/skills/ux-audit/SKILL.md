---
name: brand/ux-audit
description: >
  UX heuristic audit: evaluate interface against Nielsen's 10 heuristics.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# Ux Audit — `/brand ux-audit <url>`

> **Agent:** Sofia D. (UX Designer) | **Framework:** Nielsen 10 Heuristics + Laws of UX

## What It Does

UX heuristic audit: evaluate interface against Nielsen's 10 heuristics.

## Output

Heuristic audit report with severity ratings and fix recommendations

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Navigate the site following primary user flows (onboarding, core action, checkout)
- [BROWSER] Test accessibility: tab navigation, focus indicators, color contrast
- [BROWSER] Capture screenshots of key screens for the UX audit report
- [BROWSER] Check responsive design at mobile, tablet, and desktop breakpoints
- [BROWSER] Verify loading states, error states, and empty states render correctly
