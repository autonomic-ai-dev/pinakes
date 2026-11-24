# Planner

Operating manual for root and subplanners. Dispatchers read the SKILL.md dispatcher role; workers read `skills/agstack-mode/worker.md`.

Root and subplanners behave the same way. The root reports to the user; a subplanner reports to its parent.

## Source of truth

Git and disk are the substrate.

- `plan.json` carries the task graph, repo URL, and branch choices. Validate against `schemas/plan.schema.json`.
- `state.json` carries task status, agent ids, and branch names. Validate against `schemas/state.schema.json`.
- `handoffs/*.md` carries worker and verifier output, verbatim.
- `attention.log` carries operator-visible failures and decisions.

## Phase 1: publish tasks

Write `plan.json` at `<workspace>`; the default workspace is `.orchestrate/<rootSlug>/`.

```json
{
  "$schema": "<path-to-orchestrate>/schemas/plan.schema.json",
  "goal": "<verbatim user goal>",
  "summary": "ship the invoice retry worker end to end",
  "rootSlug": "invoice-retry",
  "baseBranch": "main",
  "repoUrl": "https://github.com/example-org/example-repo",
  "tasks": [
    {
      "name": "retry-consumer",
      "type": "worker",
      "scopedGoal": "Add the invoice retry consumer reading from the retry queue.",
      "pathsAllowed": ["services/billing/src/consumer/**"],
      "acceptance": ["Consumer processes a queued retry end to end"]
    }
  ]
}
```

`summary` is a one-line orientation for the human; `goal` stays as the agent-facing full text.

Planning rules:

- **Merges are tasks.** Publish a worker whose `scopedGoal` says which branches to merge, conflict intent, and verification. Never merge inline.
- Prefer a worker unless you can name the decomposition a subplanner would do.
- One worker can carry a lot. Subagents have long runtime budgets: multi-file slices, multi-step refactors, full repro/fix/test cycles all fit in a single spawn. Each spawn costs coordination overhead. Default to fewer, broader workers; reach for finer granularity only when a slice is genuinely independent or has real contention risk.
- **Default to verifiers.** Use `type: "verifier"` and `verifies: "<target-task-name>"`. A verifier replays its target's acceptance criteria against the real artifact — that is the trust loop, not a self-report.
- Use `verify` for the concrete check recipe. Workers read it as target behavior; verifiers inherit it from their target.
- **Prepare context, not just spec.** Before publishing a task, run `scripts/maps_for.sh <path-prefix>...` (or `grep -l` over `.verify/features/*.md`) to find the feature maps covering `pathsAllowed`. Put them in `context.featureMaps`, lift each map's Gotchas into `context.invariants`, and prefer the map's Verification Suites for `verify`/`acceptance` over re-authored checks. Put interfaces and upstream artifacts in `context.readFirst`.
- **A packet beats a paste.** When the context-and-intent pass produced `.verify/context/<task>.md`, reference it via `context.packet` instead of re-pasting it into `prompt`.
- **Verifiers check map freshness.** When a target's `pathsAllowed` overlap a feature map, the verifier's findings include whether the map still matches the code. A stale map becomes a follow-up task, not a silent gap.
- Add `measurements[]` for quantitative claims. The executor reruns each command on the worker's branch after handoff and flags drift.
- Keep fan-in small. If a task needs many upstream handoffs, publish an aggregation worker first.
- Minimize path overlap. List forbidden paths when sibling ownership matters.
- Put task specs in `plan.tasks[]`. Put shared artifacts in git and reference them by path — workers cannot see each other's workspaces.

## Phase 2: drive the workspace

Spawn pending tasks whose dependencies are satisfied, collect handoffs, update `state.json`, repeat until no progress is possible. `state.json` is the source of truth — a row with partial identity (an agent id but no run id, or a placeholder branch after handoff) is an `error` row: rename and respawn, or prune.

When the engine is `swarm`-style subagents, each spawn is one background subagent whose brief is the task's `scopedGoal` plus the prompt contract in `references/spawning.md`. When the engine is thesmos, tasks map to workflow nodes and the DAG owns waiting and retries.

## Failure recovery

The executor handles mechanical liveness (spawn retries, reattach on restart). The planner handles meaning.

- A `blocked` handoff or a failure handoff is a planner decision: respawn, split, clarify, or drop.
- Downstream tasks stay `pending` when an upstream fails. Fix the upstream and rerun, or kill abandoned downstream work.
- Subplanner respawn clones from its own branch after the first attempt so committed child state and handoffs survive.
- `maxAttempts` caps automatic spawning. Bump it in the task definition only when another attempt is intentional.
- Retry policy by failure mode lives in `references/handoffs.md`. After 2 retries on the same task, prefer abandon over a 3rd attempt without specific evidence the next will succeed.

### Andon

Andon pauses new spawns across the tree. Any planner may write `state.andon.reason` when continued spawning would produce garbage — bad upstream output, broken acceptance, unrecoverable auth or infra. Children read `state.json` (synced via git) before spawning. A task's own snag belongs in its handoff, not Andon. Clear it by recording what changed.

## Finding agents

Read `state.json` for lineage, status, and agent ids — never display titles. `syncStateToGit` on the root plan defaults on so observers can read `state.json` and handoffs from git; set it to `false` when those artifacts should stay local.
