#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS="$ROOT/skills"
DIR="${AGSTACK_USAGE_DIR:-$HOME/.autonomic/agstack/usage}"
LOG="$DIR/usage.tsv"
cmd="${1:-}"

case "$cmd" in
  record)
    task="${2:?usage: skill-usage.sh record <task-id> <skill>}"
    skill="${3:?usage: skill-usage.sh record <task-id> <skill>}"
    file="$SKILLS/$skill/SKILL.md"
    [[ -f "$file" ]] || file="$SKILLS/principles/${skill#principles/}/SKILL.md"
    [[ -f "$file" ]] || { echo "unknown skill: $skill" >&2; exit 2; }
    words="$(wc -w < "$file" | tr -d ' ')"
    mkdir -p "$DIR"
    printf '%s\t%s\t%s\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$task" "$skill" "$words" >> "$LOG"
    ;;
  report)
    if [[ ! -s "$LOG" ]]; then
      echo "no usage recorded at $LOG"
      exit 0
    fi
    awk -F'\t' '
      { loads[$3]++; words[$3] += $4; tasks[$3, $2] = 1 }
      END {
        for (skill in loads) {
          n = 0
          for (key in tasks) { split(key, p, SUBSEP); if (p[1] == skill) n++ }
          printf "%-44s loads=%-4d tasks=%-4d words_loaded=%d\n", skill, loads[skill], n, words[skill]
        }
      }' "$LOG" | sort -t= -k4 -rn
    ;;
  *)
    echo "usage: skill-usage.sh record <task-id> <skill> | report" >&2
    exit 2
    ;;
esac
