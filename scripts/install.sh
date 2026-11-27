#!/bin/sh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MODE=copy
[ "${1:-}" = "--link" ] && { MODE=link; shift; }
PKGS="${*:-agstack}"

TARGETS="$HOME/.agents/skills"
[ -d "$HOME/.config/devin/skills" ] && TARGETS="$TARGETS $HOME/.config/devin/skills"

for pkg in $PKGS; do
  src="$ROOT/packages/$pkg"
  [ -d "$src" ] || { echo "unknown package: $pkg" >&2; exit 2; }
done

if [ "$MODE" = copy ]; then
  cd "$HOME"
  for pkg in $PKGS; do
    npx skills add "$ROOT/packages/$pkg"
  done
  exit 0
fi

for pkg in $PKGS; do
  src="$ROOT/packages/$pkg"
  for target_root in $TARGETS; do
    [ -d "$target_root" ] || continue
    for skill_dir in "$src/skills"/*/; do
      name="$(basename "$skill_dir")"
      dest="$target_root/$name"
      [ -L "$dest" ] && rm -f "$dest"
      [ -e "$dest" ] && mv "$dest" "$dest.bak"
      ln -s "$src/skills/$name" "$dest"
      echo "linked $target_root/$name -> $src/skills/$name"
    done
  done
done
