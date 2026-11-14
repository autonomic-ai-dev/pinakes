#!/usr/bin/env bash
set -u

HERE="$(cd "$(dirname "$0")" && pwd)"
for rep in 1 2; do
  for task in bugfix-clamp feature-slugify refactor-report feature-words fix-config-port boundary-safe-join; do
    for cond in none pstack agstack-prev agstack-now; do
      bash "$HERE/run.sh" "$task" "$cond" "$rep" || echo "FAILED $task $cond $rep"
    done
  done
done
echo "pilot complete"
