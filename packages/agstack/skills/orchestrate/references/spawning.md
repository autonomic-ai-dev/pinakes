# Spawning tasks

Contract between `plan.json` entries and the agents the executor spawns.

## Branch naming

Each task's agent owns its working branch. `state.json` starts with a deterministic placeholder (`orch/<rootSlug>/<task-name>`) so pre-spawn state is readable, then records the real branch after handoff. Kebab-case task names are required so names still feed filesystem paths and prompt text without escaping.

No auto-managed integration branch. Branches live independently until a merge task consolidates them (see `handoffs.md` → "Merges are tasks").

Do not ask workers to create or rename branches to match the placeholder. If a downstream task needs an upstream task's code, depend on that upstream task so the executor waits for its handoff and uses the recorded actual branch.

## Starting refs and dependencies

| Field | Controls | Default | Pair with |
|-------|----------|---------|-----------|
| `startingRef` | Which branch the agent starts from | `plan.baseBranch` | `dependsOn` when depending on another task's work |
| `dependsOn` | When the task is allowed to spawn | `[]` | The executor records the upstream branch after handoff |

`startingRef` without `dependsOn` gives a point-in-time snapshot: whatever commits exist on that branch at spawn time, which may be nothing. Pair them unless you really mean "start from the current tip, even if empty".

Verifiers default `startingRef` to their target's branch and auto-include the target in `dependsOn`; the planner doesn't need to wire either explicitly.

Any task can set `verify`: a Markdown-formatted plan (setup, automated, manual, gotchas). Workers see it as a target spec; verifiers inherit the target's `verify` as their recipe.

## Spawn design decisions

- **PRs are opt-in per task.** `openPR` (default false) instructs a worker to open a PR against `plan.prBase ?? plan.baseBranch` after pushing. Subplanners and verifiers never open PRs; they hand off to their parent. Task-driven PRs give the planner a specific guarantee: this task ships as its own pull request.
- **PR base vs. worker starting ref.** `plan.baseBranch` is the starting ref for workers that don't specify their own. `plan.prBase` is where `openPR` workers aim their PRs. Split them when workers should inherit planner-side setup but open PRs against `main`; leave `prBase` unset when worker PRs stack on the planner's branch.
- **No shared integration branch.** Each task is its own island until a merge task consolidates them. An auto-managed integration branch would smuggle planner-level coding decisions into infrastructure, violating Core Principle #1.

## Task prompt contract

Every spawned agent's prompt is rendered from `scopedGoal`, `pathsAllowed`, `pathsForbidden`, `acceptance`, `startingRef`, `type`, and `openPR`. Fix the plan entry if the prompt doesn't match your intent. Every spawned prompt tells the agent:

- It is isolated. No communication with other agents.
- Commit to its own branch and push. No branch renames, merges, or rebases. Open a PR only if the task sets `openPR: true` (workers only).
- Its final message is the handoff in the structure from `handoffs.md`. That is the only thing the planner reads.
- Workers read `skills/agstack-mode/worker.md` first: the operator's bar, no asking the human, evidence in handoff.

Subplanner prompts name the orchestrate skill so the protocol loads when the agent boots.

Workers cannot ask clarifying questions mid-run. Under-specified `scopedGoal` produces silent drift. Write each task as if you'll never get another chance to steer it.

Do not rely on shared environment variables for data multiple agents must share — sandboxes may redact them. Use the planner-authored artifact pattern instead: commit a file to the base branch and reference it by path in `scopedGoal`. Never paste credentials into `scopedGoal`; it is sent to the model provider and may end up in git history when state sync is on.

## Tracking & recovery

After each spawn the executor persists the agent id, run id, and parent agent id to `state.json`, so a restarted run can re-attach and read lineage from disk. A row with partial identity on restart is marked `error` with an explanatory note. Rename and respawn, or prune.

After every handoff the executor reconciles dependent verifiers' `startingRef` from the handoff body's `## Branch` line — the body is authoritative. Any verifier whose `verifies` points at the just-handed-off task and whose `startingRef` is still the `orch/<rootSlug>/<task>` placeholder is updated to the real branch. Planner-authored `startingRef` overrides win.

## Lineage

Each `state.tasks[]` row's `parentAgentId` is the spawning planner's agent id from `plan.selfAgentId` at spawn, so a scoped kill can walk parent links downward. If the planner never set `selfAgentId`, that subtree is skipped for a scoped kill.
