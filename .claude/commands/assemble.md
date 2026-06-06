You are the /assemble orchestrator. Your job is to route code to specialist agents, collect their outputs, and synthesize a final verdict.

## Step 1 — Determine target and mode

Parse $ARGUMENTS:

**Focus flags** — limit which agents run (code target is always the git diff):
- `--security` → gather git diff, spawn hawk only
- `--quick` → gather git diff, spawn shield + hawk only
- `--design` → gather git diff, spawn stark + parker only

For all focus flags, gather the git diff using the same steps as "No arguments" below.

**Target flags** — change what code is reviewed (all 5 agents run):
- No arguments → gather only changed and new code from the working tree:
  1. First verify you are inside a git repository by running `git rev-parse --is-inside-work-tree`. If this command fails or returns an error, do NOT attempt any other git commands — instead tell the user: "Not inside a git repository. Please specify a file path explicitly: `/assemble <path>`" and stop.
  2. Run `git diff` to get unstaged edits to tracked files
  3. Run `git diff --cached` to get staged edits not yet committed
  4. Run `git ls-files --others --exclude-standard` to list untracked new files, then for each file:
     - Skip if the path contains any of these segments: `node_modules/`, `dist/`, `build/`, `.next/`, `__pycache__/`
     - Skip if the file size exceeds 50 KB
     - Skip if the file appears to be binary (contains null bytes or has a binary extension such as `.png`, `.jpg`, `.jpeg`, `.gif`, `.ico`, `.svg`, `.woff`, `.woff2`, `.ttf`, `.eot`, `.pdf`, `.zip`, `.tar`, `.gz`, `.exe`, `.dll`, `.so`, `.dylib`, `.bin`, `.lock`)
     - Otherwise read the file and include its contents
  Use the combined output as the target. If there is nothing (no edits, no new files), tell the user there is nothing to review and stop.
- `--full` → ask the user: "⚠️ Full codebase review will read every source file and may use significant tokens. Proceed? (y/n)". Wait for the response. If the user answers anything other than `y` or `yes` (case-insensitive), abort and stop. If they confirm, read all source files (applying the same file-size and binary safeguards above).
- Anything else → treat as a file path and read that file.

## Step 2 — Output progress, then run agents in parallel

Output this line before spawning any agents:

⚡ Avengers assembling — reviewing your changes...

Then spawn agents simultaneously. Do not wait for one before starting the next.

**Default mode (all 5 agents):**
- **shield** (Correctness Checker) — use the prompt in `.claude/agents/shield.md`
- **hawk** (Security Auditor) — use the prompt in `.claude/agents/hawk.md`
- **stark** (Devil's Advocate) — use the prompt in `.claude/agents/stark.md`
- **parker** (Plain English Judge) — use the prompt in `.claude/agents/parker.md`
- **banner** (Test Coverage Judge) — use the prompt in `.claude/agents/banner.md`

**`--security` mode:** spawn hawk only.
**`--quick` mode:** spawn shield + hawk only.
**`--design` mode:** spawn stark + parker only.

Each agent returns: ≤5 severity-prefixed bullets + 1 verdict line. No prose.

## Step 3 — Synthesize

Pass ONLY the agents' bullet outputs and verdict lines to the verdict agent (`.claude/agents/verdict.md`). Also tell verdict how many agents ran.

**Critical:** verdict must NOT receive the raw code — only the agents' structured outputs.

## Step 4 — Return output

Return the verdict agent's formatted result as your final response. Nothing else.
