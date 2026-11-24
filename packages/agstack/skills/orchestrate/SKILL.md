---
name: orchestrate
description: "Decompose a large task into a tree of parallel subagent workers, subplanners, and verifiers that converge through structured handoffs. Use for /orchestrate <goal> or work too large for one agent."
disable-model-invocation: true
version: 1.0.0
status: candidate
---

# Orchestrate

`/orchestrate <goal>` fans a large task out across a planner tree. Workers don't talk to each other; they talk up through structured handoffs written to git and disk. The planner writes `plan.json`, spawns subagents, reads handoffs, and decides what comes next. Long-running agent loops drift; a JSON state file keeps its footing.

## The executor

Orchestrate names the protocol, not the spawn engine. Spawn each task with the best mechanism the host offers, in this order:

1. **thesmos** when the run must survive restarts: model each task as a workflow node and let the DAG engine own retry, gates, and resume.
2. **Background subagents** (`swarm` mechanics) for same-session fan-out: workers as isolated subagent tasks, `worker.md` as their kickoff contract.
3. **Remote/cloud agents** when the host provides them (Cursor cloud agents, Devin sessions): each task gets its own clone and branch.

Whichever engine runs, the contracts below do not change: `plan.json`, `state.json`, `handoffs/*.md`, and the prompt contract in `references/spawning.md`.

## Core principles

1. **Planners own scopes and publish tasks. They do no coding.** Writing `plan.json`, reading handoffs, and deciding what's next are planner work. Editing files, merging, and fixing conflicts inline are not. If a planner feels the urge to code, it publishes a task for a worker instead.
2. **Planners don't know who picks up their tasks.** The executor routes each task to an agent. The planner's mental model stays at the task level.
3. **Workers are isolated.** One task, one workspace, no channel to any other agent. One handoff when done.
4. **Subplanners are recursive planners.** A planner publishes a "subplan this slice" task; the subplanner fully owns that slice and hands back an aggregated handoff.
5. **Continuous motion via handoffs.** A planner that thought it was done can receive a late handoff and replan. No "finished" state until the planner decides to stop publishing.
6. **Propagation, not synchronization.** No cross-talk between siblings. No shared state between levels. Each level sees only its children's handoffs.

## Node types

| Node           | Runs the loop? | Scope                            | Output                                  |
| -------------- | -------------- | -------------------------------- | --------------------------------------- |
| Planner        | yes            | Entire user goal                 | User-facing message + optional PR       |
| Subplanner     | yes            | One slice of parent's scope      | Handoff to parent                       |
| Worker         | no             | One concrete task                | Handoff to spawning planner             |
| Verifier       | no             | One target's acceptance criteria | Verdict handoff to spawning planner     |
| Git            | n/a            | Shared medium                    | Branches (code) + handoffs/ (meaning)   |

## Roles

**Dispatcher.** One-shot: take the user's goal, launch the root planner, return its handle, stop. Pass the goal through verbatim — don't expand it; the planner reads this skill and decides its own decomposition.

**Planner (root or sub).** Spawned with "You are the root planner for:" or "You are a subplanner for:" — or the user chose to run the loop locally. You own a scope, publish tasks, read handoffs, decide what's next. Read `references/planner.md` in full.

**Worker.** Spawned for one task. Read `skills/agstack-mode/worker.md` contract first.

## Workspace

Each planner owns `<workspace>` (default `.orchestrate/<rootSlug>/`):

- `plan.json` — task graph, repo, branches. Schema: `schemas/plan.schema.json`.
- `state.json` — task status, agent ids, branch names. Schema: `schemas/state.schema.json`.
- `handoffs/*.md` — worker and verifier output, verbatim.
- `attention.log` — operator-visible failures and decisions.

## References

- `references/planner.md` — planning rules, failure recovery, replanning.
- `references/spawning.md` — branch naming, dependencies, and the prompt contract every spawned agent gets.
- `references/handoffs.md` — the only channel between nodes: format, reading order, failure handoffs, retry policy.
