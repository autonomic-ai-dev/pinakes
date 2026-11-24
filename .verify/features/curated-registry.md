# curated-registry

Summary: pinakes is the central index of curated skill packages, DAG workflows, and developer utilities for the Autonomic stack.

## Sub-features

- `registry-index`: Lists every package and its source in one file.
  - Intent: Give every client one canonical place to find a package.
  - Behaviour: `registry.json` maps each alias (for example `agstack`) to a local `path` or a `git_url` and `git_ref`. Packages marked `default` bootstrap a fresh install.
  - Outcome: Resolving the `agstack` alias through this index returns its source. Not verified in this pass.
- `agstack-package`: Ships the agstack engineering process as an installable package.
  - Intent: Give every agent the same verification and process standards.
  - Behaviour: `packages/agstack/` holds the backend/DevOps SDLC playbooks, principles, subagent orchestration (`orchestrate`, `swarm`, `agents/`), the context-packet seam (`context` in plan.schema.json, `.verify/context/`, `scripts/maps_for.sh`), and the strict-verification layout. `packages/agstack-ui/` carries the UI skills and `packages/agstack-founder/` carries entrepreneurship/executive-review skills as separate optional installs; routing to an absent package prompts for installation.
  - Outcome: Installed agents read the same process files. Not verified in this pass.
- `dag-workflows`: Defines the bugfix, feature, stacked-PR, release-notes, and MCP health workflows as YAML DAGs.
  - Intent: Let agents run the same multi-step process with or without agent-spine.
  - Behaviour: The files in `workflows/` run under `thesmos run workflows/<name>.yaml` or `scripts/run-workflow.sh run workflows/<name>.yaml` (no Spine). The standalone runner executes a single linear chain; `validate` rejects cycles and fan-out.
  - Outcome: `.verify/run.sh` validates every workflow's structure. Verified via workflow validation in `.verify/run.sh`.
- `utility-catalog`: Lists the developer utilities.
  - Behaviour: `utilities/utilities.json`.
- `eval-harness`: A/B-rigs skills against fixture tasks before promotion.
  - Behaviour: `packages/agstack/eval/tasks/` holds fixture+hidden-check tasks including backend-realistic ones (`incident-from-logs`, `migration-rollback`, `concurrency-race`, `flaky-test`, `perf-regression`). `eval/run.sh` runs `claude -p` under four conditions; `eval/gate.sh` promotes only measured improvements.
  - Outcome: Hidden checks verified by construction; gated runs recorded in `.verify/artifacts/eval/results.tsv`.
- `incident-lifecycle`: Operate/Maintain playbooks for outage mitigation and blameless writeups.
  - Behaviour: `playbooks/incident.md` (mitigate → freeze evidence → probe → hand off) and `playbooks/postmortem.md` (timeline → proven root cause → causal chain → action items), routed from `agstack-mode`.
- `watch-pr`: Typed GitHub PR/stack watcher tool inside `skills/watch-pr/` (bun + `gh`), wired into the `babysit` playbook.
- `self-verification`: `.verify/verify.toml` allowlists `sh .verify/run.sh` so `tekmor verify` can issue receipts on pinakes itself.

## Code

- `registry.json`
- `workflows.json`
- `packages/`
- `workflows/`
- `scripts/`
- `utilities/`

## How to get to it (user POV)

- Read `registry.json` to find a package's source.

## Verification Suites (Targeted Test Commands)

- `sh .verify/run.sh`: jq-validates root manifests, structurally validates every `workflows/*.yaml`, and lints agstack and agstack-ui skills.
- `tekmor verify`: receipts via `.verify/verify.toml`.

## Gotchas

- A client that caches this repository sees a change only after it re-reads the cache.
- A package entry needs either `path` or `git_url`. An entry with neither has no source to install.
- The workflows need agent-spine to run as a DAG. Without it, an agent runs the steps itself or uses `scripts/run-workflow.sh`.
