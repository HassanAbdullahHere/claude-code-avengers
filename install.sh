#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIR/.claude"

if [[ "${1:-}" == "--global" ]]; then
  DEST="$HOME/.claude"
  LABEL="global ($HOME/.claude)"
else
  DEST="$(pwd)/.claude"
  LABEL="project ($(pwd)/.claude)"
fi

echo "Installing claude-code-avengers → $LABEL"

mkdir -p "$DEST/commands" "$DEST/agents"

cp "$SOURCE/commands/assemble.md" "$DEST/commands/assemble.md"
cp "$SOURCE/agents/"*.md "$DEST/agents/"

echo "Done. Run /assemble in Claude Code to get started."
