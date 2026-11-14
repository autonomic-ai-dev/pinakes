#!/bin/sh
set -eu

PKG="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$PKG/AGENTS.md"

body() {
  awk 'BEGIN { d = 0 } d >= 2 { print } /^---$/ { d++ }' "$1"
}

header() {
  if [ "$(head -n 1 "$1")" = "---" ]; then
    awk 'BEGIN { d = 0 } d < 2 { print } /^---$/ { d++ }' "$1"
  fi
}

for target in \
  platforms/claude/CLAUDE.md \
  platforms/github/copilot-instructions.md \
  platforms/gemini/rules/agstack.md \
  platforms/cursor/rules/agstack.mdc \
  platforms/antigravity/rules/agstack.md \
  antigravity/AGENTS.md \
  opencode/AGENTS.md
do
  file="$PKG/$target"
  tmp="$file.tmp"
  {
    header "$file"
    body "$SRC"
  } > "$tmp"
  mv "$tmp" "$file"
  echo "synced $target"
done
