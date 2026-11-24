# Handoffs

Handoffs are the only way information moves between nodes. Workers produce one; planners read them and decide. No shared branch, no status API, no cross-sibling chatter. That uniformity is what keeps the tree in motion without global coordination.

The executor instructs every spawned agent to end with a structured final message (status, branch, summary, notes, follow-ups) and saves it verbatim to `<workspace>/handoffs/<task-name>.md` with a traceability header. Don't enrich or sanitize; the planner needs the worker's words unfiltered.

## Measurements (worker handoff)

Workers self-report under `## Measurements`. When a task declares `measurements[]`, the executor re-runs each command on the worker's branch and flags numeric drift >10% or unit mismatches to `attention.log`; the worker still hands off and the planner decides whether to respawn. Authoring details in `references/planner.md` → `measurements[]`.

## Reading handoffs

For each new `handoffs/*.md`:

1. **Status** other than `success`: decide whether to retry, repair, or clarify via a follow-up task.
2. **Branch**: note it; reference it if another task needs to build on it.
3. **What I did**: treat as fact, but skim for claims that don't match your expectations.
4. **Notes / concerns / deviations / findings / thoughts / feedback**: the richest section. Each bullet may become a new task. Worker feedback about scoping or task clarity is especially valuable: it tells you whether your plan's prompts are pulling their weight.
5. **Suggested follow-ups**: candidate tasks. Accept, reject, or consolidate.

`Status: blocked` is a single task's dead end; the planner retries, repairs, or clarifies and the tree keeps moving. Use Andon instead (see `references/planner.md` → Failure recovery) only when continued spawning across the tree would waste effort.

## Synthetic failure handoffs

When a worker dies without writing its own handoff (budget cap, OOM, tool error, network drop), the executor writes `handoffs/<task>-failure.md` so the planner sees a postmortem instead of silence.

```markdown
# <name> — failure handoff
Status: error (agent terminated without writing a handoff)
Failure mode: cap-hit | oom | network-drop | tool-error | unknown
Agent: <id>
Started: <iso>
Terminated: <iso>
Duration: <ms>
Last activity: <iso> — <status text>
Last tool call: <name, or (unknown)>
Branch: <branch>
Error: <truncated error text>
## Suggested next steps
- <one bullet per option, planner picks>
```

Classifier heuristics:

- `cap-hit` when duration is near the agent's limit and the run is terminal-error
- `oom` when output or error contains `out of memory` / `OOMKilled` / `exit code 137`
- `network-drop` when the error matches `fetch failed` / `ETIMEDOUT` / `ECONN` / `socket` / `dns` / `disconnect`
- `tool-error` when the error mentions a failed tool invocation
- `unknown` otherwise

Default retry strategy by mode:

- `cap-hit` / `oom`: retry with smaller scope
- `network-drop`: retry as-is (treat as transient)
- `tool-error`: retry with a different `model`
- `unknown`: retry as-is once, then abandon

After 2 retries on the same task, prefer abandon (drop from `plan.json`, replan around it) over a 3rd attempt unless you have specific evidence the next retry will succeed.

## Finished-without-handoff sidecar

When a run ends finished but the body has no `## Status` heading, the executor writes `handoffs/<task>-finished-no-handoff.md` alongside the raw `<task>.md`. Treat the raw body as the worker's intent; retry if it looks recoverable, abandon if not.

## Upstream handoffs in downstream prompts

Workers live on sibling branches and **cannot read each other's branches at runtime**. If a downstream task depends on an upstream task's output, the planner must relay it: paste each upstream handoff body (or the needed excerpt) into the downstream prompt at spawn time. The executor does this for `dependsOn` entries automatically when it can; otherwise the planner does it by hand.
