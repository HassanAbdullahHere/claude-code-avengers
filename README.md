# claude-code-avengers

> Multi-agent code review, right inside Claude Code.

Run `/assemble` and four specialist agents review your code in parallel — each from a different angle — then deliver a single consolidated verdict.

---

## Agents

| Agent | Specialty |
|-------|-----------|
| **shield** | Correctness — catches logic errors, broken edge cases, and violated contracts |
| **hawk** | Security — flags injection risks, insecure defaults, and trust boundary issues |
| **stark** | Design — challenges over-engineering, bad abstractions, and unnecessary complexity |
| **parker** | Readability — spots confusing names, missing context, and undocumented surprises |

---

## Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- Git (for default diff-based reviews)

---

## Installation

**Global** — available in every project on your machine:

```bash
git clone https://github.com/HassanAbdullahHere/claude-code-avengers.git
cd claude-code-avengers
bash install.sh --global
```

**Per-project** — scoped to one repo:

```bash
git clone https://github.com/HassanAbdullahHere/claude-code-avengers.git
cd your-project
bash /path/to/claude-code-avengers/install.sh
```

---

## Usage

```bash
/assemble                # review your latest uncommitted changes
/assemble src/foo.ts     # review a specific file
/assemble --full         # review the entire codebase
```

> **Note:** `--full` prints a warning before running as it may consume significant tokens.

---

## Output

You get a structured report with:

- A findings section from each agent (bullets only, no fluff)
- A final **VERDICT** with an overall severity rating and the top actions to take

---

## Contributing

Issues and PRs welcome. Keep agent prompts lean — token efficiency is a core design principle.
