# Design: Chrome Browser Integration for ArkaOS

**Date:** 2026-04-06
**Status:** Approved
**Approach:** Skill-Level Integration (Approach A)

## Summary

Add Chrome browser integration to ArkaOS so department agents can interact with web pages, test applications, verify designs, and extract data. Chrome is a built-in Claude Code feature (`--chrome` flag), not a traditional MCP. ArkaOS adds: installer opt-in prompt, reusable browser check pattern, browser-awareness in 5 priority departments, and 3 new browser-only commands.

## Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Installer | Opt-in interactive prompt | Not all environments have Chrome; keep as opt-in |
| Commands | Hybrid — existing gain browser-awareness + 3 new browser-only | Existing workflows benefit without friction; new commands for browser-exclusive actions |
| Fallback | Informative — skip browser steps with warning | User knows what was skipped and how to enable |
| Scope | Top 5 departments | `/dev`, `/ecom`, `/brand`, `/ops`, `/strat` — highest impact |
| Architecture | Skill-level only | Chrome is managed by Claude Code; ArkaOS tells agents when/how to use browser |

## 1. Installer Chrome Prompt

**File:** `install.sh`

After existing interactive prompts (API keys, Knowledge Base, Python deps), add:

```
━━━ Browser Integration (Optional) ━━━

Claude Code can control Chrome for live testing, design verification,
and web automation. Requires: Google Chrome + Claude in Chrome extension.

Enable browser integration? (y/n): _
```

**If yes:**
1. Write Chrome enabled flag to `~/.arkaos/profile.json` (add `"chrome": true`)
2. Show instructions:
   ```
   Install the Claude in Chrome extension:
   → https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn
   Then restart Chrome. Use 'claude --chrome' or run /chrome to activate.
   ```

**If no:** Skip. Browser-aware workflows show informative fallback.

**Note:** ArkaOS does NOT force `--chrome` as default in Claude Code settings — that's the user's choice via `/chrome` → "Enabled by default". The installer only records the preference and shows setup instructions.

## 2. Browser Integration Pattern

**File:** `~/.claude/skills/arka/SKILL.md` — new section

Reusable pattern that all browser-aware department skills reference:

```markdown
## Browser Integration Pattern

When a workflow includes browser steps:

1. **Check availability**: Attempt to use a browser tool (browser_navigate).
   If browser tools are not available, the tool call will fail.

2. **If available**: Execute browser steps normally as part of the workflow.

3. **If NOT available**: Skip all browser steps and show:

   "⚠ Browser not available — [N] browser steps were skipped.
    Enable with: claude --chrome or /chrome
    Skipped: [list of what was skipped]"

   Then continue with remaining non-browser steps.

4. **Browser-only commands** (demo-gif, browse-competitor, extract-data):
   Show the same warning and suggest alternatives where applicable.
   Do NOT block or refuse — just inform clearly.

All browser steps in department workflows are marked with [BROWSER] prefix
so agents can identify them easily.
```

## 3. Department Browser-Awareness — Existing Commands

### `/dev` — Development (3 skills affected)

**`departments/dev/skills/code-review/SKILL.md`**
- After code analysis, add: `[BROWSER] Open app in browser, verify UI changes visually, check console for errors`

**`departments/dev/skills/tdd-cycle/SKILL.md`**
- After tests pass, add: `[BROWSER] If web app, open localhost and verify the feature works visually`

**`departments/dev/skills/security-audit/SKILL.md`**
- Add: `[BROWSER] Navigate to app, test for XSS via input fields, check HTTPS, verify CSP headers in console`

### `/ecom` — E-Commerce (2 skills affected)

**`departments/ecom/skills/store-audit/SKILL.md`**
- Add browser steps to audit workflow:
  - `[BROWSER] Open store URL, test full checkout flow (add to cart → payment → confirmation)`
  - `[BROWSER] Check mobile responsiveness by testing at different viewport sizes`
  - `[BROWSER] Capture screenshots of key pages for the audit report`
  - `[BROWSER] Check page load performance via console timing`

**`departments/ecom/skills/analytics/SKILL.md`**
- Add: `[BROWSER] Open store, verify tracking pixels fire correctly in console (GA4, Meta Pixel)`

### `/brand` — Brand & Design (2 skills affected)

**`departments/brand/skills/identity-system/SKILL.md`**
- After generating assets, add: `[BROWSER] Open generated assets/site in browser for visual verification against brand guidelines`

**`departments/brand/skills/ux-audit/SKILL.md`**
- Add: `[BROWSER] Navigate site, test user flows, check accessibility, capture screenshots for audit report`

### `/ops` — Operations (2 skills affected)

**`departments/ops/skills/workflow-automate/SKILL.md`**
- Add: `[BROWSER] Open relevant web tools (Gmail, Calendar, ClickUp) to verify automation results`

**`departments/ops/skills/dashboard-build/SKILL.md`**
- Add: `[BROWSER] Open dashboard in browser to verify widgets render correctly and data loads`

### `/strat` — Strategy (2 skills affected)

**`departments/strategy/skills/five-forces/SKILL.md`**
- Add: `[BROWSER] Navigate competitor websites to extract real-time pricing, features, and positioning data`

**`departments/strategy/skills/position/SKILL.md`**
- Add: `[BROWSER] Visit competitor sites and extract positioning statements, messaging, and visual identity`

## 4. New Browser-Only Commands

### `/dev demo-gif`

**File:** `departments/dev/skills/demo-gif/SKILL.md` (new)

```
Command: /dev demo-gif <url> <flow-description>
Requires: Browser integration (/chrome)

Records a GIF of a user flow in the browser.

Workflow:
1. Check browser availability (follow Browser Integration Pattern)
2. Navigate to <url>
3. Execute the described flow step by step
4. Record the session as a GIF
5. Save GIF to current directory
6. Report file path and size

Example:
  /dev demo-gif http://localhost:3000 "login, navigate to dashboard, create a new item"

Fallback (no browser):
  "⚠ Browser required for demo recording. Enable with: claude --chrome or /chrome"
```

### `/ecom browse-competitor`

**File:** `departments/ecom/skills/browse-competitor/SKILL.md` (new)

```
Command: /ecom browse-competitor <url>
Requires: Browser integration (/chrome)

Navigates a competitor's e-commerce site and extracts structured intelligence.

Workflow:
1. Check browser availability (follow Browser Integration Pattern)
2. Navigate to <url>
3. Extract: product categories, price ranges, promotions, layout patterns
4. Capture screenshots of homepage, product page, cart, checkout
5. Generate structured report in Obsidian

Output to: Projects/<ecosystem>/Strategy/Competitors/<domain>.md

Fallback (no browser):
  "⚠ Browser not available. Using WebFetch for partial extraction.
   For full competitor analysis with screenshots, enable: /chrome"
  Then use WebFetch/WebSearch as partial alternative.
```

### `/strat extract-data`

**File:** `departments/strategy/skills/extract-data/SKILL.md` (new)

```
Command: /strat extract-data <url> [format]
Requires: Browser integration (/chrome)

Navigates a web page and extracts structured data (tables, lists, prices).

Workflow:
1. Check browser availability (follow Browser Integration Pattern)
2. Navigate to <url>
3. Identify structured data on the page (tables, lists, repeated patterns)
4. Extract and format as CSV or markdown table
5. Save to file or display inline

Formats: csv (default), markdown, json

Fallback (no browser):
  "⚠ Browser not available. Using WebFetch for basic extraction.
   For interactive pages (JS-rendered, pagination), enable: /chrome"
  Then use WebFetch as partial alternative.
```

## 5. Files to Create/Modify

| File | Action | Description |
|------|--------|-------------|
| `install.sh` | Modify | Add Chrome opt-in prompt after existing prompts |
| `~/.claude/skills/arka/SKILL.md` | Modify | Add "Browser Integration Pattern" section |
| `departments/dev/skills/code-review/SKILL.md` | Modify | Add [BROWSER] visual verification step |
| `departments/dev/skills/tdd-cycle/SKILL.md` | Modify | Add [BROWSER] localhost verification step |
| `departments/dev/skills/security-audit/SKILL.md` | Modify | Add [BROWSER] XSS/HTTPS testing steps |
| `departments/dev/skills/demo-gif/SKILL.md` | Create | New browser-only GIF recording command |
| `departments/ecom/skills/store-audit/SKILL.md` | Modify | Add [BROWSER] checkout flow + screenshots |
| `departments/ecom/skills/analytics/SKILL.md` | Modify | Add [BROWSER] tracking pixel verification |
| `departments/ecom/skills/browse-competitor/SKILL.md` | Create | New browser-only competitor analysis |
| `departments/brand/skills/identity-system/SKILL.md` | Modify | Add [BROWSER] visual verification step |
| `departments/brand/skills/ux-audit/SKILL.md` | Modify | Add [BROWSER] navigation + screenshot steps |
| `departments/ops/skills/workflow-automate/SKILL.md` | Modify | Add [BROWSER] web tool verification |
| `departments/ops/skills/dashboard-build/SKILL.md` | Modify | Add [BROWSER] dashboard render check |
| `departments/strategy/skills/five-forces/SKILL.md` | Modify | Add [BROWSER] competitor data extraction |
| `departments/strategy/skills/position/SKILL.md` | Modify | Add [BROWSER] competitor site analysis |
| `departments/strategy/skills/extract-data/SKILL.md` | Create | New browser-only data extraction |

**Total:** 3 new files, 13 modifications
