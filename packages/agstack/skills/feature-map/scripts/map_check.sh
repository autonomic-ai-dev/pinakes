#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "usage: map_check.sh <feature-map.md>" >&2
  exit 2
fi

MAP="$1"
ERRORS=0
H2_FILE="$(mktemp)"
CMD_FILE="$(mktemp)"
BODY_FILE="$(mktemp)"
trap 'rm -f "$H2_FILE" "$CMD_FILE" "$BODY_FILE"' EXIT

fail() {
  echo "FAIL $MAP: $1" >&2
  ERRORS=$((ERRORS + 1))
}

if head -n 1 "$MAP" | grep -q '^---$'; then
  awk 'NR==1 && /^---$/ {infm=1; next} infm && /^---$/ {infm=0; next} infm {next} !found && NF==0 {next} {found=1; print}' "$MAP" > "$BODY_FILE"
else
  cp "$MAP" "$BODY_FILE"
fi

if ! head -n 1 "$BODY_FILE" | grep -q '^# '; then
  fail "first line must be an H1 title"
fi

grep '^## ' "$BODY_FILE" | grep -v '^## Code$' > "$H2_FILE" || true
set -- "## Sub-features" "## How to get to it (user POV)" "## Verification Suites (Targeted Test Commands)" "## Gotchas"
position=1
while IFS= read -r heading; do
  if [ "$position" -gt 4 ]; then
    fail "unexpected H2 after the four contract sections: $heading"
  else
    eval "wanted=\${$position}"
    [ "$heading" = "$wanted" ] || fail "H2 #$position is '$heading', expected '$wanted'"
  fi
  position=$((position + 1))
done < "$H2_FILE"
found=$((position - 1))
[ "$found" -eq 4 ] || fail "expected 4 contract H2 sections (plus optional Code), found $found"

grep -o '`sh [^`]*`' "$MAP" | sort -u > "$CMD_FILE" || true
while IFS= read -r command; do
  script="$(printf '%s' "$command" | tr -d '`' | awk '{ print $2 }')"
  [ -e "$script" ] || fail "command $command refers to missing file $script"
done < "$CMD_FILE"

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi
echo "OK $MAP"
