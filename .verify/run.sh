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
  python3 packages/agstack/skills/workflow-engine/scripts/run-workflow.py validate "$workflow" >/dev/null
done

echo "==> Linting agstack skills"
bash packages/agstack/skills/agstack-mode/scripts/skill-lint.sh

echo "==> Linting agstack-ui skills"
bash packages/agstack/skills/agstack-mode/scripts/skill-lint.sh packages/agstack-ui/skills
echo "==> Linting agstack-founder skills"
bash packages/agstack/skills/agstack-mode/scripts/skill-lint.sh packages/agstack-founder/skills

for map in .verify/features/*.md; do
  echo "==> Checking feature map: $map"
  sh packages/agstack/skills/feature-map/scripts/map_check.sh "$map"
done

echo "==> [pinakes] Verification passed cleanly (exit 0)."
