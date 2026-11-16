#!/bin/sh
set -eu

PKG="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$PKG/AGENTS.md"
MODE="${1:-write}"
DRIFT=0

body() {
  awk 'BEGIN { d = 0 } d >= 2 { print } /^---$/ { d++ }' "$1"
}

header() {
  if [ "$(head -n 1 "$1")" = "---" ]; then
    awk 'BEGIN { d = 0 } d < 2 { print } /^---$/ { d++ }' "$1"
  fi
}

TARGETS="platforms/claude/CLAUDE.md
platforms/github/copilot-instructions.md
platforms/gemini/rules/agstack.md
platforms/cursor/rules/agstack.mdc
platforms/antigravity/rules/agstack.md
antigravity/AGENTS.md
opencode/AGENTS.md"

for target in $TARGETS; do
  file="$PKG/$target"
  generated="$(mktemp)"
  {
    header "$file"
    body "$SRC"
  } > "$generated"
  case "$MODE" in
    check)
      if cmp -s "$generated" "$file"; then
        echo "in sync $target"
      else
        echo "DRIFT $target differs from AGENTS.md" >&2
        DRIFT=$((DRIFT + 1))
      fi
      rm -f "$generated"
      ;;
    write)
      mv "$generated" "$file"
      echo "synced $target"
      ;;
    *)
      echo "usage: sync-host-policy.sh [write|check]" >&2
      rm -f "$generated"
      exit 2
      ;;
  esac
done

if [ "$DRIFT" -gt 0 ]; then
  exit 1
fi
