#!/usr/bin/env bash
set -euo pipefail

[ $# -ge 1 ] || { echo "usage: $0 <path-or-symbol> [more...]  — lists .verify/features/*.md mentioning each term" >&2; exit 2; }
features_dir=".verify/features"
[ -d "$features_dir" ] || exit 0

for term in "$@"; do
  grep -l -- "$term" "$features_dir"/*.md 2>/dev/null || true
done | sort -u