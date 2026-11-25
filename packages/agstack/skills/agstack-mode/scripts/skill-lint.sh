#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
SKILLS="$(cd "${1:-$ROOT/skills}" && pwd)"
RELROOT="$(cd "$SKILLS/.." && pwd)"
WORD_BUDGET=800
DESCRIPTION_LIMIT=400
ERRORS=0
WARNINGS=0
unversioned=0

fail() {
  echo "ERROR [$1]: $2" >&2
  ERRORS=$((ERRORS + 1))
}

warn() {
  echo "WARN  [$1]: $2"
  WARNINGS=$((WARNINGS + 1))
}

field() {
  awk -v key="$2" '
    NR == 1 && $0 != "---" { exit }
    NR > 1 && $0 == "---" { exit }
    index($0, key ":") == 1 {
      value = substr($0, length(key) + 2)
      gsub(/^[ "]+|[ "]+$/, "", value)
      print value
      exit
    }' "$1"
}

while IFS= read -r file; do
  rel="${file#"$RELROOT"/}"
  dir="$(basename "$(dirname "$file")")"

  if [[ "$(head -n 1 "$file")" != "---" ]]; then
    fail "$rel" "missing frontmatter opening '---'"
    continue
  fi

  name="$(field "$file" name)"
  description="$(field "$file" description)"

  expected="$dir"
  if [[ "$file" == "$SKILLS/principles/"* ]]; then
    expected="principle-$dir"
  fi

  if [[ -z "$name" ]]; then
    fail "$rel" "frontmatter has no name"
  elif [[ "$name" != "$expected" ]]; then
    fail "$rel" "name '$name' should be '$expected'"
  fi

  if [[ -z "$description" ]]; then
    fail "$rel" "frontmatter has no description"
  else
    desc_len="$(printf '%s' "$description" | wc -c | tr -d ' ')"
    if (( desc_len > DESCRIPTION_LIMIT )); then
      warn "$rel" "description is $desc_len characters; limit is $DESCRIPTION_LIMIT"
    fi
  fi

  version="$(field "$file" version)"
  status="$(field "$file" status)"
  if [ -z "$version" ]; then
    unversioned=$((unversioned + 1))
  elif ! printf '%s' "$version" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    fail "$rel" "version '$version' is not MAJOR.MINOR.PATCH"
  fi
  if [ -n "$status" ]; then
    case "$status" in
      active|candidate|deprecated) ;;
      *) fail "$rel" "status '$status' must be active, candidate, or deprecated" ;;
    esac
  fi
  if [ "$status" = "deprecated" ]; then
    removal="$(field "$file" removal)"
    printf '%s' "$removal" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' || fail "$rel" "deprecated skill needs removal: YYYY-MM-DD"
  fi

  words="$(wc -w < "$file" | tr -d ' ')"
  if (( words > WORD_BUDGET )); then
    warn "$rel" "$words words; budget is $WORD_BUDGET"
  fi
done < <(find "$SKILLS" -name SKILL.md | sort)

if (( unversioned > 0 )); then
  warn "skills" "$unversioned skill(s) have no version field; add version: 1.0.0 when next edited"
fi

legacy="$(grep -rlE 'agent-brain|agent-spine|agent_brain|thesmos|tekmor|route_task' "$SKILLS" 2>/dev/null | sort || true)"
if [[ -n "$legacy" ]]; then
  count="$(printf '%s\n' "$legacy" | wc -l | tr -d ' ')"
  warn "skills" "$count file(s) reference agent-brain, agent-spine, thesmos, or tekmor tools; remove when decoupling"
fi

echo "skill-lint: $ERRORS error(s), $WARNINGS warning(s)"
if (( ERRORS > 0 )); then
  exit 1
fi
