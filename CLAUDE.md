# claude-code-avengers

Multi-agent code review system delivered as Claude Code slash commands.

## File structure

```
CLAUDE.md                        # this file — contributor context for Claude
README.md                        # user-facing docs
install.sh                       # copies .claude/ to global or per-project destination
.claude/
  commands/
    assemble.md                  # /assemble entry point — routing and orchestration
  agents/
    shield.md                    # Correctness Checker
    hawk.md                      # Security Auditor
    stark.md                     # Devil's Advocate
    parker.md                    # Plain English Judge
    verdict.md                   # Synthesizer — consolidates agent outputs into final verdict
```

## Design rules

These must be respected when modifying any agent or the orchestrator:

- Agent system prompts: hard cap 100 words
- Agent output: ≤5 bullets + 1 verdict line, no prose
- `verdict` receives only agent outputs — never raw code
- Token efficiency is a first-class constraint, not an afterthought

## Adding a new agent

1. Create `.claude/agents/<name>.md` with a focused system prompt (≤100 words)
2. Register it in `assemble.md` under Step 2 alongside the existing agents
3. Update the agents table in `README.md`

## Modifying the output format

Output structure is defined in `.claude/agents/verdict.md`. Change it there only — do not hardcode formatting in `assemble.md`.
