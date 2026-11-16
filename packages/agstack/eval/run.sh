#!/usr/bin/env bash
set -eu

HERE="$(cd "$(dirname "$0")" && pwd)"
PKG="$(cd "$HERE/.." && pwd)"
REG="$(cd "$PKG/../.." && pwd)"
PSTACK="${PSTACK_DIR:-/Volumes/Seagate/developer/personal/autonomic-ai-dev/plugins/pstack}"
TASK="${1:?usage: run.sh <task> <condition: none|pstack|agstack-prev|agstack-now> <rep>}"
COND="${2:?condition required}"
REP="${3:?rep required}"
TASKDIR="$HERE/tasks/$TASK"
OUT="$REG/.verify/artifacts/eval/$TASK/$COND-$REP"
RESULTS="$REG/.verify/artifacts/eval/results.tsv"
PREV_REV="${AGSTACK_PREV_REV:-2d1cbf6}"

[ -d "$TASKDIR/fixture" ] || { echo "unknown task: $TASK" >&2; exit 2; }

rm -rf "$OUT"
mkdir -p "$OUT"
cp -R "$TASKDIR/fixture/." "$OUT/"
cd "$OUT"
git init -q
git add -A
git -c user.email=eval@local -c user.name=eval commit -q -m base

mkdir -p .claude
case "$COND" in
  none)
    ;;
  pstack)
    cp -R "$PSTACK/skills" .claude/skills
    ;;
  agstack-prev)
    git -C "$REG" archive "$PREV_REV" packages/agstack/skills | tar -x -C "$OUT/.claude" --strip-components=2
    git -C "$REG" archive "$PREV_REV" packages/agstack/AGENTS.md | tar -x -C "$OUT" --strip-components=2
    mv AGENTS.md CLAUDE.md
    ;;
  agstack-now)
    git -C "$REG" archive HEAD packages/agstack/skills | tar -x -C "$OUT/.claude" --strip-components=2
    git -C "$REG" archive HEAD packages/agstack/AGENTS.md | tar -x -C "$OUT" --strip-components=2
    mv AGENTS.md CLAUDE.md
    ;;
  *)
    echo "unknown condition: $COND" >&2
    exit 2
    ;;
esac

printf '.claude/\nCLAUDE.md\nAGENTS.md\n' >> .git/info/exclude

PROMPT="$(cat "$TASKDIR/prompt.md")"
set +e
claude -p "$PROMPT" \
  --setting-sources project \
  --permission-mode acceptEdits \
  --allowedTools "Read" "Edit" "Write" "Grep" "Glob" "Bash(sh:*)" "Bash(bash:*)" "Bash(git:*)" "Bash(ls:*)" "Bash(cat:*)" "Bash(grep:*)" "Bash(printf:*)" "Bash(echo:*)" "Bash(find:*)" "Bash(mkdir:*)" "Bash(cp:*)" "Bash(awk:*)" "Bash(sed:*)" "Bash(od:*)" "Bash(mktemp:*)" "Bash(cd:*)" "Bash(head:*)" "Bash(tail:*)" "Bash(wc:*)" "Bash(tr:*)" "Bash(sort:*)" "Bash(diff:*)" "Bash(touch:*)" "Bash(test:*)" "Bash(.:*)" \
  --output-format json \
  --max-budget-usd 1.50 \
  --no-session-persistence > claude.json 2> claude.err
AGENT_EXIT=$?
set -e

COST="$(jq -r '.total_cost_usd // 0' claude.json)"
TURNS="$(jq -r '.num_turns // 0' claude.json)"
ERR="$(jq -r '.is_error' claude.json)"
DENIALS="$(jq -r '.permission_denials | length' claude.json)"

git add -A
ADDED_COMMENTS="$(git diff --cached HEAD -- lib bin | grep -c '^+[[:space:]]*#' || true)"
TESTS_CHANGED="$(git diff --cached --name-only HEAD -- test | wc -l | tr -d ' ')"

cp "$TASKDIR/hidden.sh" .grade_hidden.sh
set +e
sh .grade_hidden.sh > grade.out 2>&1
HIDDEN_EXIT=$?
set -e
rm -f .grade_hidden.sh

mkdir -p "$(dirname "$RESULTS")"
printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
  "$TASK" "$COND" "$REP" "$HIDDEN_EXIT" "$ADDED_COMMENTS" "$TESTS_CHANGED" "$TURNS" "$COST" "$ERR" "$DENIALS" "$AGENT_EXIT" \
  >> "$RESULTS"
echo "$TASK $COND $REP hidden=$HIDDEN_EXIT comments=$ADDED_COMMENTS tests_changed=$TESTS_CHANGED turns=$TURNS cost=$COST denials=$DENIALS"
