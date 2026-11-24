# agstack guide

agstack is an engineering operating layer for AI coding agents: a policy file (`AGENTS.md`), playbooks for every SDLC phase, a fleet of skills and principles, a verification harness contract (`.verify/`), and an eval gate that measures skill changes before they ship.

## Install

Install the `agstack` package from the pinakes registry into your agent host (Claude Code, Cursor, Copilot, OpenCode, Codex, Antigravity). The package ships manifests for each host under its plugin directories; your host's plugin loader picks up `AGENTS.md` and the `skills/` tree. `packages/agstack-ui` is a separate package — install it only for frontend work.

## Mental model

1. **Routing:** `skills/agstack-mode` is the spine. It maps intent to exactly one playbook along the SDLC: Request → Design → Build → Verify → Deploy → Operate → Maintain.
2. **Playbooks are contracts:** when a playbook matches, the agent copies its numbered steps into the plan verbatim before editing. This is enforced in evals by `scripts/playbook-check.sh`.
3. **Verification is the completion condition:** changes are incomplete until `.verify/run.sh` (or the repo's allowlisted equivalent) runs and the evidence lands in `.verify/artifacts/`.
4. **Trust is measured:** skill changes promote through `eval/run.sh` + `eval/gate.sh` — ≥5 reps, pass-rate ≥ baseline, no extra test edits, ≤120% of baseline turns. See `TRUST.md`.

## First verified feature

1. Point the agent at a repo with a test suite (or a `.verify/run.sh`).
2. Ask for a small feature. `agstack-mode` routes to `playbooks/feature.md`.
3. Watch the contract execute: context → domain model → contract & steps → TDD → `.verify/` evidence record.
4. Expect an evidence record at the end: commands run, exit codes, artifact paths, gates not run.

## First orchestrated run

For work too large for one context:

- `skills/orchestrate` decomposes into `plan.json` → worker leaves (with `worker.md` kickoff contract) → verifier gate → handoffs.
- `skills/swarm` races equivalent attempts and keeps the best verified result.
- `agents/agstack-agent` and `agents/comment-sicko` are the host subagent definitions the orchestrator spawns.

## Playbook map (abridged)

| Moment | Playbook |
|---|---|
| New feature | `feature` |
| Broken behavior | `bug-fix` |
| Schema change | `database-migration` |
| Adversarial review | `code-review` |
| PR to green | `babysit` (uses `watch-pr`) |
| Landing a stack | `shipping` |
| Live outage | `incident` |
| After an incident | `postmortem` |
| Slowness | `perf-issue` |
| Continuing paused work | `session-pickup` |

Full table: `skills/agstack-mode/SKILL.md`.
