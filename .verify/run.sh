#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$DIR/.." && pwd)"

echo "==> [pinakes] Starting verification suite..."
cd "$REPO_ROOT"

for file in *.json; do
  echo "==> Validating JSON: $file"
  jq -e . "$file" >/dev/null
done

for workflow in workflows/*.yaml; do
  echo "==> Validating workflow: $workflow"
  python3 packages/agstack/scripts/run-workflow.py validate "$workflow" >/dev/null
done

echo "==> Linting agstack skills"
bash packages/agstack/scripts/skill-lint.sh

echo "==> Linting agstack-ui skills"
bash packages/agstack/scripts/skill-lint.sh packages/agstack-ui/skills

echo "==> [pinakes] Verification passed cleanly (exit 0)."
