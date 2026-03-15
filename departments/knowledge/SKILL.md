---
name: kb
description: >
  Dynamic knowledge base powered by Obsidian. Async background processing: queues YouTube
  downloads, transcribes with Whisper (local or API), and pauses for interactive analysis.
  Runs 5 parallel analysis agents (Frameworks, Strategy, Voice & Style, Principles, Topics)
  to build expert personas. Learns from articles and URLs. Creates searchable persona profiles,
  topic cross-references, and source catalogs. Generates content in any learned persona's voice
  and style. All output organized in Obsidian vault with MOC pages.
  Use when user says "kb", "learn", "persona", "knowledge", "youtube", "transcribe", "article",
  "research", "analyze", "source", "topic", "search knowledge", "write as", "queue", "process",
  "capabilities", or wants to learn from any content source or use a persona's expertise.
---

# Knowledge Base — ARKA OS Department

Dynamic knowledge acquisition and management system. Learn from YouTube videos, articles, books, and any content source. Build expert personas and a searchable knowledge base.

**ALL output goes to the Obsidian vault.**

**Background processing:** Downloads and transcriptions run as background jobs. Queue 100 URLs and keep working. Process results interactively when ready.

## Obsidian Configuration

- **Vault:** `{{OBSIDIAN_VAULT}}`
- **Config:** Read `knowledge/obsidian-config.json` for full path/convention details
- **MCP:** Use Obsidian MCP when available, fallback to direct file Write
- **Conventions:** YAML frontmatter, wikilinks `[[]]`, MOC references, kebab-case tags

## Commands

| Command | Description |
|---------|-------------|
| `/kb learn <url> [url2 ...] [--persona "Name"]` | Queue download + transcription (async, non-blocking) |
| `/kb learn-text <file/url> --persona "Name"` | Learn from text/article content (synchronous) |
| `/kb queue` | Show all queued/running/ready jobs |
| `/kb status [job-id]` | Detailed status of a specific job |
| `/kb process <job-id>` | Analyze a ready transcription (interactive choices) |
| `/kb process --all` | Process all ready jobs |
| `/kb capabilities` | Show available tools and API keys |
| `/kb cleanup [--older-than 90d]` | Remove old media files |
| `/kb persona <name>` | View/manage a persona profile |
| `/kb personas` | List all personas and their stats |
| `/kb search <query>` | Search knowledge base by topic |
| `/kb write --persona "Name" --type <type>` | Generate content using a persona's style |
| `/kb topics` | List all knowledge topics |
| `/kb update <persona> <youtube-url>` | Add more content to existing persona |

## Scripts Location

All KB scripts are in the `scripts/` subdirectory of this skill:
- `scripts/kb-check-capabilities.sh` — System capability probe
- `scripts/kb-queue.sh` — Queue dispatcher
- `scripts/kb-worker.sh` — Background worker
- `scripts/kb-status.sh` — Status checker
- `scripts/kb-cleanup.sh` — Media cleanup

The scripts directory path can be resolved relative to this SKILL.md file's installed location. When installed, scripts are at `~/.claude/skills/arka-knowledge/scripts/`.

## /kb capabilities

Check what tools and API keys are available for KB processing.

**Steps:**
1. Run `bash <scripts-dir>/kb-check-capabilities.sh`
2. Read `~/.arka-os/capabilities.json`
3. Display the results to the user in a formatted table

Shows: binary availability (whisper, yt-dlp, ffmpeg, jq, python3), API keys (OpenAI, Gemini, OpenRouter), and the selected transcription method.

## /kb learn <url> [url2 ...] [--persona "Name"]

**This command is NON-BLOCKING.** It queues jobs and returns immediately.

### Step 1: Check Capabilities
```bash
bash <scripts-dir>/kb-check-capabilities.sh
```
Read `~/.arka-os/capabilities.json`. If `yt-dlp` is not available, tell the user to install it and stop. If no transcription method is available, warn the user (download-only mode).

### Step 2: Queue Each URL
For each URL provided, run:
```bash
bash <scripts-dir>/kb-queue.sh "<url>" --persona "<Name>"
```
This returns a job ID (8 chars) immediately. The download + transcription runs in the background.

### Step 3: Display Summary
Show the user what was queued:
```
═══ ARKA KB — Jobs Queued ═══
  Job a1b2c3d4 → <url1>
  Job e5f6g7h8 → <url2>
  ...
Transcription: <method>
Media: ~/.arka-os/media/<date>/

Run /kb queue to check progress.
Run /kb process <job-id> when jobs are ready.
═════════════════════════════
```

**IMPORTANT:** Do NOT wait for downloads to complete. Return to the user immediately after queuing.

## /kb queue

Show all jobs and their current status.

**Steps:**
1. Run `bash <scripts-dir>/kb-status.sh`
2. Or read `~/.arka-os/kb-jobs.json` directly and format as a table
3. Show: job ID, status, title, transcription method
4. Status colors: queued (yellow), downloading/transcribing (blue), ready (green), completed (green), failed (red)

## /kb status [job-id]

Show detailed status of a specific job.

**Steps:**
1. Run `bash <scripts-dir>/kb-status.sh <job-id>`
2. Or read the job from `~/.arka-os/kb-jobs.json` and display all fields
3. If `--json` flag: output raw JSON

## /kb process <job-id>

Analyze a ready transcription. This is the INTERACTIVE step that requires Claude Code's LLM.

### Step 1: Validate Job
Read `~/.arka-os/kb-jobs.json`. Find job by ID. Verify status is `ready`. If not ready, show current status and suggest waiting.

### Step 2: Read Transcript
Read `<job-output-dir>/audio.txt` for the transcription.
Read `<job-output-dir>/metadata.json` for video title, duration, etc.

### Step 3: Ask User What To Do

Present these choices using AskUserQuestion:

1. **Full analysis** — Run all 5 agents, create/update persona + source + topics + MOC pages
2. **Create/update persona only** — Just the persona profile
3. **Extract frameworks only** — Identify and catalog frameworks/methodologies
4. **Save transcript to Obsidian only** — Just save the raw transcript as a Source page
5. **Custom analysis** — Ask user what specific analysis they want

### Step 4: Update Job Status
Update `~/.arka-os/kb-jobs.json` — set status to `analyzing`.
Use flock for safe concurrent writes:
```bash
(flock -x 200; jq --arg id "<job-id>" '(.jobs[] | select(.id == $id)).status = "analyzing"' ~/.arka-os/kb-jobs.json > /tmp/kb-tmp.$$.json && mv /tmp/kb-tmp.$$.json ~/.arka-os/kb-jobs.json) 200>~/.arka-os/kb-jobs.lock
```

### Step 5: Execute Analysis

**If "Full analysis" chosen — run 5 parallel agents (same as before):**

Launch these analysis agents simultaneously using the Task tool:

**Agent 1: Frameworks Extractor**
- What frameworks, models, or methodologies does this person teach?
- What step-by-step processes do they describe?
- What acronyms or named concepts do they use?

**Agent 2: Strategy Analyzer**
- What strategies and tactics are discussed?
- What specific advice is given?
- What results/numbers/case studies are mentioned?

**Agent 3: Voice & Style Profiler**
- How does this person speak? (formal/casual, aggressive/calm)
- What phrases do they repeat?
- What's their opening pattern? Closing pattern?
- What metaphors or analogies do they use?

**Agent 4: Principles Extractor**
- What are the core beliefs expressed?
- What do they argue against?
- What philosophy drives their approach?

**Agent 5: Topic Cataloger**
- What topics does this content cover?
- How does it relate to existing topics in the knowledge base?
- What keywords and categories apply?

### Step 6: Write to Obsidian

**Create/Update Persona** — same format as before:

Check if `Personas/<Name>.md` exists in the Obsidian vault.

**If new persona — create using this EXACT format:**

**File:** `Personas/<Name>.md`
```markdown
---
type: persona
name: <Full Name>
expertise:
  - "<primary expertise>"
  - "<secondary expertise>"
date_updated: <YYYY-MM-DD>
tags:
  - "persona"
  - "<expertise-kebab-case>"
---

# <Full Name>

> [One-line description of who they are and what they teach]

## Voice & Style

[From Agent 3 analysis — how they communicate, tone, patterns]

## Core Philosophy

[From Agent 4 analysis — their beliefs and principles]

## Key Frameworks

[From Agent 1 analysis — named frameworks and processes]

### Framework: <Name>
- Step 1: ...
- Step 2: ...

## Strategies & Tactics

[From Agent 2 analysis — actionable advice]

## Notable Quotes

> "Exact quote from content"
> "Another memorable phrase"

## Sources

- [[<YYYY-MM-DD> <Video Title>]]

---
*Part of the [[Personas MOC]]*
```

**If existing persona — UPDATE:**
1. Read the existing persona file
2. MERGE new information (don't replace)
3. Add new frameworks, strategies, quotes
4. Add new source link
5. Update `date_updated` in frontmatter
6. Note contradictions if the person changed their position

**Create Source File:**

**File:** `Sources/Videos/<YYYY-MM-DD> <Video Title>.md`
```markdown
---
type: source
source_type: video
title: "<Video Title>"
url: "<youtube-url>"
persona: "[[<Name>]]"
date_processed: <YYYY-MM-DD>
duration: "<duration>"
tags:
  - "source"
  - "video"
  - "<topic-kebab-case>"
---

# <Video Title>

> Source video for [[<Name>]] persona

## Key Takeaways

[Top 5-10 insights from the video]

## Frameworks Found

[List of frameworks identified — link to persona]

## Full Analysis

[Combined output from all 5 agents]

## Raw Transcript

<details>
<summary>Click to expand full transcript</summary>

[Full transcription text]

</details>

---
*Part of the [[Sources MOC]]*
```

**Catalog by Topic:**

For each topic identified, create or update `Topics/<Topic Name>.md`:
```markdown
---
type: topic
name: <Topic Name>
related_personas:
  - "[[<Name>]]"
date_updated: <YYYY-MM-DD>
tags:
  - "topic"
  - "<topic-kebab-case>"
---

# <Topic Name>

## Perspectives

### [[<Persona Name>]]
[What this persona says about this topic]

---
*Part of the [[Topics MOC]]*
```

**Update MOC Pages:**
- Update `Personas MOC.md` to include the new/updated persona link
- Update `Sources MOC.md` to include the new source link
- Update `Topics MOC.md` with any new topics
- Create these MOC files if they don't exist yet

### Step 7: Update Job Status
Update `~/.arka-os/kb-jobs.json` — set status to `completed`.

### Step 8: Report
```
═══ ARKA KB — Processing Complete ═══
Job:        <job-id>
Persona:    <Name> (new/updated)
Source:     "<Video Title>" (YouTube)
Duration:   <duration>
Vault:      Personas/<Name>.md
Source:     Sources/Videos/<date> <title>.md
New frameworks found: <count>
New strategies found: <count>
Topics tagged: <list>
Media:      <output-dir>
══════════════════════════════════════
```

## /kb process --all

Process all jobs with status `ready`:
1. Read `~/.arka-os/kb-jobs.json`
2. Filter jobs where status is `ready`
3. For each ready job, run the `/kb process <job-id>` workflow
4. Ask the user once what analysis type to use for all jobs (or ask per-job)

## /kb cleanup [--older-than 90d]

Remove old media files for completed jobs.

**Steps:**
1. Run `bash <scripts-dir>/kb-cleanup.sh --older-than <days>`
2. Add `--dry-run` first to show what would be removed
3. Ask user to confirm before actual deletion
4. Report space freed

## /kb learn-text <file/url> --persona "Name"

Same workflow as `/kb process` full analysis but skip download/transcribe.
- If URL: use WebFetch to get content
- If file: read directly
- Source goes to `Sources/Articles/` instead of `Sources/Videos/`
- This is synchronous (no background processing needed — text is already available)

## /kb write --persona "Name" --type <type>

Generate content in a persona's style:

1. Read `Personas/<Name>.md` from the Obsidian vault for voice and style
2. Read any linked source files for frameworks and strategies
3. Generate the requested content type using that persona's approach

Supported types: `landing-page`, `email`, `ad`, `social-post`, `blog`, `pitch`, `script`

When `--personas` (plural) is used with multiple names, **blend** the styles:
- Use the primary persona's voice
- Incorporate frameworks from all specified personas
- Note which elements come from which persona

## /kb search <query>

1. Search across `Personas/`, `Topics/`, `Sources/` in the Obsidian vault using Grep
2. Return results organized by relevance
3. Show which personas have insights on the query
4. Include specific quotes and framework references

## /kb personas

List all personas by reading files in `Personas/` directory of the vault.
Show: name, expertise, number of sources, last updated date.

## /kb topics

List all topics by reading files in `Topics/` directory of the vault.
Show: topic name, related personas, last updated date.

## Job Status Flow

```
queued → downloading → transcribing → ready → analyzing → completed
              ↓              ↓
           failed          failed
```

The `ready` → `analyzing` transition happens when user runs `/kb process <job-id>`. The analysis requires Claude Code's LLM (5 parallel agents), which cannot run in a background bash script.

## Media Storage

```
~/.arka-os/
├── media/                          # Permanent, organized media storage
│   ├── 2026-03-15/                 # Date-based grouping
│   │   ├── a1b2c3d4/              # Job ID directory
│   │   │   ├── metadata.json      # yt-dlp output (title, duration)
│   │   │   ├── audio.wav          # Downloaded audio file
│   │   │   ├── audio.txt          # Transcription output
│   │   │   ├── download.log       # yt-dlp log
│   │   │   ├── transcribe.log     # Whisper log
│   │   │   └── worker.log         # Background process log
├── kb-jobs.json                    # Job state file
├── capabilities.json               # System capabilities
└── .env                            # API keys
```

## Obsidian Output Paths (Summary)

| Content | Vault Path |
|---------|-----------|
| Personas | `Personas/<Name>.md` |
| Video Sources | `Sources/Videos/<date> <title>.md` |
| Article Sources | `Sources/Articles/<date> <title>.md` |
| Topics | `Topics/<Topic Name>.md` |
| Frameworks | `🧠 Knowledge Base/Frameworks/<name>.md` |
| Raw Transcripts | `🧠 Knowledge Base/Raw Transcripts/<name>.txt` |
| MOC Pages | `Personas MOC.md`, `Topics MOC.md`, `Sources MOC.md` |
