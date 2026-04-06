# Chrome Browser Integration — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Chrome browser integration to ArkaOS — installer opt-in, reusable browser pattern, browser-awareness in 5 departments, and 3 new browser-only commands.

**Architecture:** Pure skill-level integration. No Python/JS code. All changes are markdown skill files, one shell script edit, and 3 new skill files.

**Tech Stack:** Markdown (SKILL.md), Bash (install.sh)

---

### Task 1: Add Browser Integration Pattern to main /arka skill

**Files:**
- Modify: `~/.claude/skills/arka/SKILL.md` (append after line 141)

- [ ] **Step 1: Add the Browser Integration Pattern section**

Append the following to the end of `~/.claude/skills/arka/SKILL.md`:

```markdown

## Browser Integration Pattern

Claude Code can control Chrome for live testing, design verification, and web automation.
Activated via `claude --chrome` or `/chrome` command. Not a traditional MCP — it's a built-in Claude Code feature.

### Browser Availability Check

When a workflow includes `[BROWSER]` steps:

1. **Check availability**: Attempt to use a browser tool (e.g., `browser_navigate`).
   If browser tools are not loaded, the tool call will fail.

2. **If available**: Execute all `[BROWSER]` steps normally as part of the workflow.

3. **If NOT available**: Skip all `[BROWSER]` steps and show:

   ```
   ⚠ Browser not available — [N] browser steps were skipped.
   Enable with: claude --chrome or /chrome
   Skipped: [list of what was skipped]
   ```

   Then continue with remaining non-browser steps.

4. **Browser-only commands** (`/dev demo-gif`, `/ecom browse-competitor`, `/strat extract-data`):
   Show the same warning and suggest alternatives where applicable (e.g., WebFetch for partial extraction).

### Convention

All browser steps in department workflows are prefixed with `[BROWSER]` so agents can identify and skip them when browser is unavailable.
```

- [ ] **Step 2: Verify the section was appended**

```bash
tail -10 ~/.claude/skills/arka/SKILL.md
```

Expected: Shows the `### Convention` subsection at the end.

- [ ] **Step 3: Commit**

This file is outside the git repo. No git commit needed.

---

### Task 2: Add Chrome opt-in prompt to installer

**Files:**
- Modify: `/Users/andreagroferreira/AIProjects/arka-os/install.sh` (insert after profile save, around line 272)

- [ ] **Step 1: Read the installer to find exact insertion point**

Read `install.sh` around lines 260-280 to find the "Profile saved" message and the next section heading.

- [ ] **Step 2: Insert Chrome prompt block**

After the profile save confirmation and before the next section, insert:

```bash
# ━━━ Browser Integration (Optional) ━━━
echo ""
echo "━━━ Browser Integration (Optional) ━━━"
echo ""
echo "Claude Code can control Chrome for live testing, design verification,"
echo "and web automation. Requires: Google Chrome + Claude in Chrome extension."
echo ""
printf "Enable browser integration? (y/n): "
read -r ENABLE_CHROME

if [ "$ENABLE_CHROME" = "y" ] || [ "$ENABLE_CHROME" = "Y" ]; then
    # Record preference in profile
    if [ -f "$HOME/.arkaos/profile.json" ]; then
        # Add chrome field to existing profile using python
        python3 -c "
import json
with open('$HOME/.arkaos/profile.json', 'r') as f:
    profile = json.load(f)
profile['chrome'] = True
with open('$HOME/.arkaos/profile.json', 'w') as f:
    json.dump(profile, f, indent=2)
" 2>/dev/null
    fi

    echo ""
    echo "✓ Browser integration enabled."
    echo ""
    echo "Next steps:"
    echo "  1. Install the Claude in Chrome extension:"
    echo "     → https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn"
    echo "  2. Restart Chrome after installing"
    echo "  3. Use 'claude --chrome' or run /chrome to activate browser tools"
    echo ""
else
    echo "✓ Skipped browser integration. Enable later with /chrome."
fi
```

- [ ] **Step 3: Verify syntax**

```bash
bash -n /Users/andreagroferreira/AIProjects/arka-os/install.sh
```

Expected: No syntax errors.

- [ ] **Step 4: Commit**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os
git add install.sh
git commit -m "feat: add Chrome browser integration opt-in to installer"
```

---

### Task 3: Add browser-awareness to /dev department skills

**Files:**
- Modify: `departments/dev/skills/code-review/SKILL.md`
- Modify: `departments/dev/skills/tdd-cycle/SKILL.md`
- Modify: `departments/dev/skills/security-audit/SKILL.md`

- [ ] **Step 1: Append browser section to code-review skill**

Append to the end of `departments/dev/skills/code-review/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Open the application in the browser and verify UI changes visually
- [BROWSER] Check browser console for JavaScript errors or warnings
- [BROWSER] If CSS/layout changes: compare before/after visually
```

- [ ] **Step 2: Append browser section to tdd-cycle skill**

Append to the end of `departments/dev/skills/tdd-cycle/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] After tests pass, if web app: open localhost in browser and verify the feature works visually
- [BROWSER] Check console for runtime errors that tests might not catch
```

- [ ] **Step 3: Insert browser section in security-audit skill**

In `departments/dev/skills/security-audit/SKILL.md`, insert before the `## References` section (around line 68):

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Navigate to the application and test input fields for XSS (script injection)
- [BROWSER] Verify HTTPS is enforced (check URL bar and certificate)
- [BROWSER] Open console and check for CSP (Content Security Policy) headers
- [BROWSER] Test authentication flows: login, logout, session expiry
```

- [ ] **Step 4: Commit**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os
git add departments/dev/skills/code-review/SKILL.md departments/dev/skills/tdd-cycle/SKILL.md departments/dev/skills/security-audit/SKILL.md
git commit -m "feat: add browser-awareness to /dev department skills"
```

---

### Task 4: Add browser-awareness to /ecom department skills

**Files:**
- Modify: `departments/ecom/skills/store-audit/SKILL.md`
- Modify: `departments/ecom/skills/analytics/SKILL.md`

- [ ] **Step 1: Append browser section to store-audit skill**

Append to the end of `departments/ecom/skills/store-audit/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Open store URL and test the full checkout flow: browse → add to cart → checkout → payment → confirmation
- [BROWSER] Test mobile responsiveness at different viewport sizes (375px, 768px, 1024px)
- [BROWSER] Capture screenshots of homepage, product page, cart, and checkout for the audit report
- [BROWSER] Check page load performance via console timing (Performance API)
- [BROWSER] Verify search functionality works correctly
- [BROWSER] Test navigation menu and footer links
```

- [ ] **Step 2: Append browser section to analytics skill**

Append to the end of `departments/ecom/skills/analytics/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Open the store and verify GA4 tracking fires on page load (check Network tab for collect requests)
- [BROWSER] Test conversion tracking: complete a purchase flow and verify events fire
- [BROWSER] Check Meta Pixel fires correctly (search for fbq in console)
- [BROWSER] Verify Google Tag Manager container loads
```

- [ ] **Step 3: Commit**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os
git add departments/ecom/skills/store-audit/SKILL.md departments/ecom/skills/analytics/SKILL.md
git commit -m "feat: add browser-awareness to /ecom department skills"
```

---

### Task 5: Add browser-awareness to /brand department skills

**Files:**
- Modify: `departments/brand/skills/identity-system/SKILL.md`
- Modify: `departments/brand/skills/ux-audit/SKILL.md`

- [ ] **Step 1: Append browser section to identity-system skill**

Append to the end of `departments/brand/skills/identity-system/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Open the website/app and verify brand elements match the identity system (colors, typography, spacing)
- [BROWSER] Compare generated assets side-by-side with the live site
- [BROWSER] Check favicon, og:image, and meta branding elements
```

- [ ] **Step 2: Append browser section to ux-audit skill**

Append to the end of `departments/brand/skills/ux-audit/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Navigate the site following primary user flows (onboarding, core action, checkout)
- [BROWSER] Test accessibility: tab navigation, focus indicators, color contrast
- [BROWSER] Capture screenshots of key screens for the UX audit report
- [BROWSER] Check responsive design at mobile, tablet, and desktop breakpoints
- [BROWSER] Verify loading states, error states, and empty states render correctly
```

- [ ] **Step 3: Commit**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os
git add departments/brand/skills/identity-system/SKILL.md departments/brand/skills/ux-audit/SKILL.md
git commit -m "feat: add browser-awareness to /brand department skills"
```

---

### Task 6: Add browser-awareness to /ops department skills

**Files:**
- Modify: `departments/ops/skills/workflow-automate/SKILL.md`
- Modify: `departments/ops/skills/dashboard-build/SKILL.md`

- [ ] **Step 1: Append browser section to workflow-automate skill**

Append to the end of `departments/ops/skills/workflow-automate/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Open the relevant web tools (Gmail, Google Calendar, ClickUp, N8N) to verify automation results
- [BROWSER] Test the automated workflow end-to-end by triggering it and watching the result in the browser
- [BROWSER] Verify notifications and emails arrive correctly
```

- [ ] **Step 2: Append browser section to dashboard-build skill**

Append to the end of `departments/ops/skills/dashboard-build/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Open the dashboard in browser and verify all widgets render correctly
- [BROWSER] Check that data loads and updates in real-time (if WebSocket)
- [BROWSER] Test responsive layout at different screen sizes
- [BROWSER] Verify charts, tables, and graphs display correct data
```

- [ ] **Step 3: Commit**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os
git add departments/ops/skills/workflow-automate/SKILL.md departments/ops/skills/dashboard-build/SKILL.md
git commit -m "feat: add browser-awareness to /ops department skills"
```

---

### Task 7: Add browser-awareness to /strat department skills

**Files:**
- Modify: `departments/strategy/skills/five-forces/SKILL.md`
- Modify: `departments/strategy/skills/position/SKILL.md`

- [ ] **Step 1: Insert browser section in five-forces skill**

In `departments/strategy/skills/five-forces/SKILL.md`, insert before the final `## Output` section (around line 72):

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Navigate to competitor websites and extract real-time pricing data
- [BROWSER] Capture screenshots of competitor product pages, pricing pages, and feature comparisons
- [BROWSER] Check competitor positioning statements and messaging from their homepage
- [BROWSER] Extract supplier/partner information from competitor sites when available
```

- [ ] **Step 2: Append browser section to position skill**

Append to the end of `departments/strategy/skills/position/SKILL.md`:

```markdown

## Browser Steps

Follow the [Browser Integration Pattern](/arka) for availability checking.

- [BROWSER] Visit competitor websites and extract their positioning: taglines, hero copy, value propositions
- [BROWSER] Capture visual identity elements: color schemes, typography, imagery style
- [BROWSER] Check social proof: testimonials, client logos, case studies
- [BROWSER] Compare pricing pages side-by-side
```

- [ ] **Step 3: Commit**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os
git add departments/strategy/skills/five-forces/SKILL.md departments/strategy/skills/position/SKILL.md
git commit -m "feat: add browser-awareness to /strat department skills"
```

---

### Task 8: Create 3 new browser-only command skills

**Files:**
- Create: `departments/dev/skills/demo-gif/SKILL.md`
- Create: `departments/ecom/skills/browse-competitor/SKILL.md`
- Create: `departments/strategy/skills/extract-data/SKILL.md`

- [ ] **Step 1: Create demo-gif skill**

Create `departments/dev/skills/demo-gif/SKILL.md`:

```markdown
---
name: demo-gif
description: >
  Record a GIF demo of a user flow in the browser. Navigates to a URL,
  executes described interactions, and saves the recording as a GIF file.
  Requires browser integration (claude --chrome or /chrome).
allowed-tools: browser_navigate, browser_click, browser_type, browser_screenshot, browser_record_gif, Bash, Write, Read
---

# Demo GIF Recording — /dev demo-gif

> **Paulo** (Tech Lead) · Requires: Browser integration (`/chrome`)

## Command

```
/dev demo-gif <url> <flow-description>
```

## What It Does

Records a GIF of a user flow in the browser for demos, documentation, or bug reports.

## Workflow

1. **Check browser availability** — follow [Browser Integration Pattern](/arka)
2. **Navigate** to the provided URL
3. **Execute the flow** step by step as described:
   - Parse the flow description into discrete actions (click, type, navigate, scroll)
   - Execute each action with a brief pause between steps for visual clarity
4. **Record** the session as a GIF
5. **Save** the GIF to the current directory with a descriptive filename
6. **Report** file path, file size, and duration

## Example

```
/dev demo-gif http://localhost:3000 "login with test@example.com, navigate to dashboard, create a new project, fill in the name 'My Project', click save"
```

## Fallback (No Browser)

```
⚠ Browser required for demo recording. Enable with: claude --chrome or /chrome
```

## Output

GIF file saved to current working directory: `demo-<timestamp>.gif`
```

- [ ] **Step 2: Create browse-competitor skill**

Create `departments/ecom/skills/browse-competitor/SKILL.md`:

```markdown
---
name: browse-competitor
description: >
  Navigate a competitor's e-commerce site and extract structured intelligence:
  product categories, price ranges, promotions, layout patterns, and screenshots.
  Requires browser integration (claude --chrome or /chrome).
allowed-tools: browser_navigate, browser_click, browser_type, browser_screenshot, browser_get_text, Bash, Write, Read
---

# Browse Competitor — /ecom browse-competitor

> **Ricardo** (E-Commerce Lead) · Requires: Browser integration (`/chrome`)

## Command

```
/ecom browse-competitor <url>
```

## What It Does

Navigates a competitor's e-commerce site and extracts structured competitive intelligence.

## Workflow

1. **Check browser availability** — follow [Browser Integration Pattern](/arka)
2. **Navigate** to the competitor homepage
3. **Extract** structured data:
   - Product categories and subcategories
   - Price ranges (min, max, average per category)
   - Current promotions and discounts
   - Layout patterns (grid, list, hero sections)
   - Navigation structure
   - Payment methods offered
   - Shipping information
4. **Capture screenshots** of:
   - Homepage
   - A product listing page
   - A product detail page
   - Cart page (if accessible)
   - Footer (payment/shipping badges)
5. **Generate report** in Obsidian with screenshots and structured findings

## Fallback (No Browser)

```
⚠ Browser not available. Using WebFetch for partial extraction.
For full competitor analysis with screenshots, enable: /chrome
```

Falls back to WebFetch/WebSearch for basic HTML extraction (no JS rendering, no screenshots, no interaction).

## Output

Obsidian report: `Projects/<ecosystem>/Strategy/Competitors/<domain>.md`
```

- [ ] **Step 3: Create extract-data skill**

Create `departments/strategy/skills/extract-data/SKILL.md`:

```markdown
---
name: extract-data
description: >
  Navigate a web page and extract structured data: tables, lists, prices,
  product listings. Supports CSV, markdown, and JSON output formats.
  Requires browser integration (claude --chrome or /chrome).
allowed-tools: browser_navigate, browser_click, browser_get_text, browser_screenshot, Bash, Write, Read
---

# Extract Data — /strat extract-data

> **Tomas** (Strategy Lead) · Requires: Browser integration (`/chrome`)

## Command

```
/strat extract-data <url> [format]
```

Formats: `csv` (default), `markdown`, `json`

## What It Does

Navigates a web page and extracts structured data (tables, lists, prices, repeated patterns) into a clean format.

## Workflow

1. **Check browser availability** — follow [Browser Integration Pattern](/arka)
2. **Navigate** to the URL (handles JS-rendered content, pagination, infinite scroll)
3. **Identify structured data** on the page:
   - HTML tables
   - Repeated list patterns (product cards, directory entries)
   - Price/value data
   - Tabular data rendered via JavaScript
4. **Extract** data into structured format
5. **Handle pagination** if detected (ask user: "Found pagination — extract all pages?")
6. **Output** in requested format:
   - CSV: saved to `extracted-<domain>-<timestamp>.csv`
   - Markdown: displayed inline as table
   - JSON: saved to `extracted-<domain>-<timestamp>.json`

## Fallback (No Browser)

```
⚠ Browser not available. Using WebFetch for basic extraction.
For interactive pages (JS-rendered, pagination), enable: /chrome
```

Falls back to WebFetch for static HTML extraction only.

## Output

File saved to current directory or displayed inline (markdown format).
```

- [ ] **Step 4: Commit all 3 new skills**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os
git add departments/dev/skills/demo-gif/SKILL.md departments/ecom/skills/browse-competitor/SKILL.md departments/strategy/skills/extract-data/SKILL.md
git commit -m "feat: add 3 browser-only commands (demo-gif, browse-competitor, extract-data)"
```

---

### Task 9: Final verification and combined commit

- [ ] **Step 1: Verify all files exist and have browser content**

```bash
echo "=== New skills ===" && ls -la departments/dev/skills/demo-gif/SKILL.md departments/ecom/skills/browse-competitor/SKILL.md departments/strategy/skills/extract-data/SKILL.md && echo "" && echo "=== Browser sections in modified skills ===" && for f in departments/dev/skills/code-review/SKILL.md departments/dev/skills/tdd-cycle/SKILL.md departments/dev/skills/security-audit/SKILL.md departments/ecom/skills/store-audit/SKILL.md departments/ecom/skills/analytics/SKILL.md departments/brand/skills/identity-system/SKILL.md departments/brand/skills/ux-audit/SKILL.md departments/ops/skills/workflow-automate/SKILL.md departments/ops/skills/dashboard-build/SKILL.md departments/strategy/skills/five-forces/SKILL.md departments/strategy/skills/position/SKILL.md; do echo "  $f: $(grep -c BROWSER $f) [BROWSER] steps"; done && echo "" && echo "=== Installer Chrome prompt ===" && grep -c "Browser Integration" /Users/andreagroferreira/AIProjects/arka-os/install.sh && echo "" && echo "=== Arka skill browser pattern ===" && grep -c "Browser Integration Pattern" ~/.claude/skills/arka/SKILL.md
```

Expected:
- 3 new skill files exist
- Each modified skill has at least 2 `[BROWSER]` steps
- Installer has "Browser Integration" section
- Arka skill has "Browser Integration Pattern"

- [ ] **Step 2: Verify git status is clean**

```bash
cd /Users/andreagroferreira/AIProjects/arka-os && git status
```

Expected: `nothing to commit, working tree clean`

- [ ] **Step 3: Verify git log shows all commits**

```bash
git log --oneline -6
```

Expected: Shows commits for installer, /dev, /ecom, /brand, /ops, /strat, and new browser-only skills.
