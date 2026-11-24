#!/bin/sh
set -eu

if [ "$#" -ne 3 ]; then
  echo "usage: gate.sh <baseline-condition> <candidate-condition> <task-or-all>" >&2
  exit 2
fi

BASE="$1"
CAND="$2"
TASK="$3"
RESULTS="$(cd "$(dirname "$0")/../../.." && pwd)/.verify/artifacts/eval/results.tsv"
MIN_REPS=5
TURN_LIMIT_PERCENT=120

if [ ! -s "$RESULTS" ]; then
  echo "HOLD no results at $RESULTS" >&2
  exit 1
fi

summary() {
  awk -F'\t' -v c="$1" -v t="$2" '
    (t == "all" || $1 == t) && $2 == c {
      n++
      if ($4 == 0 && ($12 == "PASS" || $12 == "na" || $12 == "")) pass++
      turns += $7
      if ($6 > 0) edits++
    }
    END {
      if (n == 0) { print "0 0 0 0"; exit }
      printf "%d %d %.2f %d\n", n, pass, turns / n, edits
    }' "$RESULTS"
}

set -- $(summary "$BASE" "$TASK")
BASE_N=$1; BASE_PASS=$2; BASE_TURNS=$3; BASE_EDITS=$4
set -- $(summary "$CAND" "$TASK")
CAND_N=$1; CAND_PASS=$2; CAND_TURNS=$3; CAND_EDITS=$4

if [ "$CAND_N" -lt "$MIN_REPS" ] || [ "$BASE_N" -lt "$MIN_REPS" ]; then
  echo "HOLD fewer than $MIN_REPS runs per condition (baseline $BASE_N, candidate $CAND_N)"
  exit 1
fi

if [ "$CAND_PASS" -lt "$BASE_PASS" ]; then
  echo "HOLD candidate passes $CAND_PASS of $CAND_N, baseline passes $BASE_PASS of $BASE_N"
  exit 1
fi

if [ "$CAND_EDITS" -gt "$BASE_EDITS" ]; then
  echo "HOLD candidate edited test files in $CAND_EDITS runs, baseline in $BASE_EDITS"
  exit 1
fi

LIMIT="$(awk -v b="$BASE_TURNS" -v p="$TURN_LIMIT_PERCENT" 'BEGIN { printf "%.2f", b * p / 100 }')"
if awk -v c="$CAND_TURNS" -v l="$LIMIT" 'BEGIN { exit !(c > l) }'; then
  echo "HOLD candidate mean turns $CAND_TURNS exceed $TURN_LIMIT_PERCENT% of baseline $BASE_TURNS"
  exit 1
fi

echo "PROMOTE $CAND vs $BASE on $TASK: passes $CAND_PASS/$CAND_N vs $BASE_PASS/$BASE_N, turns $CAND_TURNS vs $BASE_TURNS"
