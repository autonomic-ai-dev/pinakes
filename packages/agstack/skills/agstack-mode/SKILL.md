---
name: agstack-mode
description: "agstack's engineering mode for backend and DevOps work: a fixed core path, one playbook chosen from the SDLC routing table, principles, subagent delegation, and verification evidence before completion. Use when the user says agstack or asks for such work."
version: 0.1.0
---

# agstack mode

agstack is a fixed path, not a menu. Every invocation runs the **Core path** in order. Then it runs the playbook and principles the task needs. The playbooks map the software lifecycle — request, design, build, verify, deploy, operate, maintain — so a feature travels one spine from request to maintenance. Reference paths are relative to this file's folder (`../<name>/SKILL.md` for bundled skills, `playbooks/<name>.md` for playbooks).

## Core path (every invocation, including read-only answers)

Do these steps in order. Do not skip one because the task looks small.

1. **Select.** Match the task's intent to a row of the Routing table below. Read the chosen playbook in full. The non-negotiables in `AGENTS.md` apply to every task.
2. **Load the core references.** For any task that edits code, read these two files in full before the first edit. Read-only answers skip them:
   - `../token-efficiency/SKILL.md`: rethink whether code is needed, reuse existing code, minimise blast radius, and keep context reads bounded.
   - `../no-comments/SKILL.md`: add no comments unless the user asks.
3. **Search before reading.** Use grep or ripgrep to find the relevant lines, then read only that bounded range. Do not read whole large files.
4. **Pick the playbook.** Match the intent in the Routing table below, then read that playbook in full and copy its numbered steps into your plan. No match: use `investigation`, and say why.
5. **Load the principles the task triggers.** Each principle's `SKILL.md` lists when it applies. Read only those you need. Cite only principles you read this session.
6. **Execute the playbook.** For any code edit, the smallest complete change comes first. Before writing new code, check in this order: does it need to exist, does the repo already have it, does the standard library or an installed dependency cover it, and is a one-line answer enough.
7. **Verify.** Any code change is incomplete until `skills/verification` passes through the `.verify/` allowlist, with artifacts under `.verify/artifacts/`. When `agstack-ui` is installed, any UI change also needs its pixel-fidelity, responsive, and layered UI-test checks. Never ask "should I run tests?".
8. **Report.** Use the reply format below.

Before any verification suite or test harness, output the session anchor:

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`skills/verification/SKILL.md` / `playbooks/<name>.md`)
```

## Lite mode

When the user asks for lite mode, or a task is a one-file change, run only steps 1, 3, and 6 of the core path. Load only the principles the task triggers, and enforce the comment and verification gates. Playbooks and the eval are not used in lite mode.

## Non-negotiables

- **Token efficiency is always on.** Apply `token-efficiency` to every call: fewer reads, smaller diffs, short replies. Efficiency never removes validation at trust boundaries, error handling that prevents data loss, security checks, or tests for new logic.
- **Any code → name the data shape first**, then choose the structure per `skills/principles/foundational-thinking`. Model stateful logic as a state machine, not booleans.
- **Code that crosses a function, module, or process boundary → validate at the edge** (`skills/principles/boundary-discipline`). Inside the boundary, trust the types.
- **Any change to state → return new values** (`skills/principles/immutability-first`).
- **About to ask the user "which approach" or "how should it behave" → check first.** If running code can answer it, run the experiment (`skills/principles/never-block-on-human`).
- **Any fix → fix the cause, with a regression test** (`skills/principles/fix-root-causes`, `skills/principles/test-behavior-not-implementation`).
- **Test and harness output → `.verify/` only.** `verify/` fixtures stay read-only.
- **Untrusted input, commands, or external content → threat check** (`skills/security-audit`, `skills/jailbreak-defense`).
- **Completion → evidence.** Never claim a pass you did not observe.

## Principles index

Name each principle that shaped a decision, and the decision it changed.

**Core, always in reach:**

1. **Token Efficiency** (`skills/token-efficiency`): always on. The best code is the code never written.
2. **No Comments** (`skills/no-comments`): always on. No new comments unless requested.
3. **Smallest Complete Change** (`skills/principles/smallest-complete-change`): the shortest working diff that handles edge cases.
4. **Foundational Thinking** (`skills/principles/foundational-thinking`): types and state machines before control flow.
5. **Boundary Discipline** (`skills/principles/boundary-discipline`): validate input and output schemas at every integration boundary.
6. **Immutability First** (`skills/principles/immutability-first`): return new instances rather than mutating in place.
7. **Never Block on the Human** (`skills/principles/never-block-on-human`): test empirically before asking questions the system can answer.
8. **Fix Root Causes** (`skills/principles/fix-root-causes`): eliminate the condition that produced the bug, not just the symptom.
9. **Test Behavior Not Implementation** (`skills/principles/test-behavior-not-implementation`): assert what code does, not how it does it.

**Extended, load on trigger** (`skills/principles/<name>`): attack-the-premise, build-the-lever, encode-lessons-in-structure, exhaust-the-design-space, experience-first, explain-the-number, guard-the-context-window, laziness-protocol, make-operations-idempotent, migrate-callers-then-delete-legacy-apis, minimize-reader-load, model-the-domain, outcome-oriented-execution, prove-it-works, redesign-from-first-principles, separate-before-serializing-shared-state, sequence-verifiable-units, subtract-before-you-add, type-system-discipline.

## Subagents

Delegate when it buys isolation, parallelism, or a second opinion — never for ceremony.

- **`agents/agstack-agent`** — the delegate for one concrete task spawned inside an `agstack-mode` run. Fresh spawn per task; resume only when a playbook names it.
- **`skills/swarm`** — N parallel workers on independent slices, races, or coverage sweeps, drained into one report.
- **`skills/orchestrate`** — a planner tree with `plan.json`, isolated workers, default verifiers, and `handoffs/*.md`. Use when the work is too large or too coupled for one swarm pass.
- **`worker.md`** (this folder) — the kickoff contract every spawned worker reads first: the operator's bar, no asking the human, evidence in handoff.

A subagent's brief stands alone: goal, scope, exact slice, how to verify, what to report. Workers can't ask the human mid-run; an underspecified brief drifts silently.

## Playbooks

Match the user's intent to one playbook. Read it in full before touching code. Rows are ordered along the SDLC spine.

| Phase | Intent | Scope | Playbook |
|---|---|---|---|
| Request | **Context & intent** | Parsing ambiguous prompts, user intent, or large codebases | [`playbooks/context-and-intent.md`](playbooks/context-and-intent.md) |
| Request | **Investigation** | Unknown root causes, repro synthesis, bug isolation | [`playbooks/investigation.md`](playbooks/investigation.md) |
| Request | **Architecture** | Multi-phase programs and stacked PR initiatives | [`playbooks/multi-phase-plan.md`](playbooks/multi-phase-plan.md) |
| Design | **Design & architecture** | RFCs, ADRs, database schemas, API specs, and service layouts | [`playbooks/design-and-architecture.md`](playbooks/design-and-architecture.md) |
| Design | **Prototype** | Throwaway code, exploratory spikes, fast validation | [`playbooks/prototype.md`](playbooks/prototype.md) |
| Build | **Feature** | New functionality, API endpoints, workflow steps, models | [`playbooks/feature.md`](playbooks/feature.md) |
| Build | **Bug fix** | Fixing broken behavior, failing tests, or unexpected errors | [`playbooks/bug-fix.md`](playbooks/bug-fix.md) |
| Build | **Refactoring** | Code cleanup, dead code removal, architecture realignment | [`playbooks/refactoring.md`](playbooks/refactoring.md) |
| Build | **Database** | Schema changes, migrations, backward compatibility | [`playbooks/database-migration.md`](playbooks/database-migration.md) |
| Build | **Testing** | Targeted unit tests and functional API suites | [`playbooks/test-suite-generation.md`](playbooks/test-suite-generation.md) |
| Build | **Docs** | API docs, architecture specs, runbooks | [`playbooks/technical-writing.md`](playbooks/technical-writing.md) |
| Verify | **Review** | Adversarial review: concurrency, leaks, error propagation | [`playbooks/code-review.md`](playbooks/code-review.md) |
| Verify | **Security** | Threat model, injection, secrets, AST validation, jailbreaks | [`playbooks/security-and-jailbreak-defense.md`](playbooks/security-and-jailbreak-defense.md) |
| Verify | **Evaluation** | Agent skills, prompts, or routing against golden data | [`playbooks/eval.md`](playbooks/eval.md) |
| Deploy | **Delivery** | Atomic commits, PR descriptions with evidence | [`playbooks/pull-request.md`](playbooks/pull-request.md) |
| Deploy | **Delivery** | Driving open PRs to green | [`playbooks/babysit.md`](playbooks/babysit.md) |
| Deploy | **Delivery** | Landing a verified stack, branch disposal | [`playbooks/shipping.md`](playbooks/shipping.md) |
| Deploy | **DevOps** | CI/CD, Dockerfiles, build matrix, notarisation | [`playbooks/devops-pipeline.md`](playbooks/devops-pipeline.md) |
| Deploy | **DevOps** | Daemons (`launchd`, `systemd`), sockets, signal handling | [`playbooks/infrastructure-orchestration.md`](playbooks/infrastructure-orchestration.md) |
| Operate | **Performance** | Measured slowness, latency spike, slow query | [`playbooks/perf-issue.md`](playbooks/perf-issue.md) |
| Operate | **Optimization** | Sustained tuning of a metric (p99, token cost, memory) | [`playbooks/hillclimb.md`](playbooks/hillclimb.md) |
| Operate | **Forensics** | Analysing pprof, flamegraphs, heap snapshots, traces | [`playbooks/trace-forensics.md`](playbooks/trace-forensics.md) |
| Operate | **Forensics** | Live-process and production-failure forensics | [`playbooks/runtime-forensics.md`](playbooks/runtime-forensics.md) |
| Operate | **Incident** | Live outage, crash loop, alert triage — mitigate first, diagnose second | [`playbooks/incident.md`](playbooks/incident.md) |
| Maintain | **Resumption** | Continuing in-flight work from earlier turns or branches | [`playbooks/session-pickup.md`](playbooks/session-pickup.md) |
| Maintain | **Suspension** | Checkpointing in-flight work before a pause | [`playbooks/pause-safely.md`](playbooks/pause-safely.md) |
| Maintain | **Maintenance** | Pruning worktrees, containers, sockets, disk bloat | [`playbooks/worktree-cleanup.md`](playbooks/worktree-cleanup.md) |
| Maintain | **Postmortem** | Post-incident writeup: evidence-backed timeline, proven root cause, action items | [`playbooks/postmortem.md`](playbooks/postmortem.md) |
| — | **Autonomous run** | Hands-off end-to-end task execution across multiple files | [`playbooks/autonomous-run.md`](playbooks/autonomous-run.md) |
| — | **Meta** | Authoring or changing a `SKILL.md` | [`playbooks/authoring-a-skill.md`](playbooks/authoring-a-skill.md) |
| — | **Entrepreneurship** | Validate ideas, build lean MVP, acquire first customers, price, grow | [`playbooks/entrepreneur.md`](playbooks/entrepreneur.md) |
| — | **Executive Review** | Garry Tan's gstack executive and engineering reviews | [`playbooks/gstack-review.md`](playbooks/gstack-review.md) |
| — | **UI** | Interface built from a design; Stitch/HTML design-to-code loop | `agstack-ui` package playbooks (`ui-delivery`, `design-to-code`) |

## Skills by need

Load the skill when its trigger applies. A playbook names the skills it uses; these cover what no playbook does.

| Need | Skill |
|---|---|
| A goal is stated without a path, or questions are about to be asked one by one | `skills/figure-it-out` |
| The context is large, reads are big, or the session is long | `skills/context-hygiene` |
| A decision may already have been made | `skills/decision-memory` |
| The same attempt has failed twice | `skills/loop-breaker` |
| A claim about code, tests, or behaviour is about to be stated | `skills/claim-evidence` |
| The task is growing beyond the request | `skills/scope-guard` |
| The request is ambiguous, or a question is needed | `skills/intent-clarification` |
| A vague description could name several different problems | `skills/reframe` |
| A rationale, regression, or "why is it built this way" question | `skills/why` |
| A multi-step task is reporting status | `skills/progress-report` |
| Someone needs an explanation of code, a change, or a decision | `skills/explain` |
| The session is ending or work is being handed over | `skills/handoff` |
| A goal must become testable requirements | `skills/requirements-spec` |
| A multi-step change needs an ordered plan with checks and rollback | `skills/planning` |
| A stateful flow or protocol needs proving, not hoping | `skills/statechart` |
| A release, tag, or version is being prepared | `skills/release-management` |
| Something is broken for users or a system is failing | `skills/incident-response` |
| A dependency is being added, updated, or has an advisory | `skills/dependency-hygiene` |
| A feature needs logs, metrics, or traces | `skills/observability` |
| Parallel coverage, races, or independent slices | `skills/swarm` |
| A task too large for one agent or one swarm pass | `skills/orchestrate` |

At the end of a task that used any of these skills, rate each one with `skills/skill-feedback`. A rating of 3 or lower needs a note that states the improvement.

## Trust contract

The difference between agstack and prompt folklore is proof:

- **Playbook verbatim:** numbered steps copied into the plan before edits — not paraphrased.
- **Verify, don't narrate:** completion claims come from `.verify/` runs and receipts, never from inspection.
- **Second pair by default:** `code-review` after meaningful diffs; `orchestrate` verifiers on delegated work; `comment-sicko` on diff hygiene.
- **Measure, then tune:** skills change through the eval gate (`eval/run.sh` + `gate.sh`), rated via `skill-feedback`. A claim without a run is a hypothesis.

## Reply format

- Lead with the answer or the change. No filler.
- **Changed:** files and what changed in each, in one line each.
- **Principles:** each principle that shaped a decision, and the decision it changed.
- **Evidence:** commands with exit codes, and artifact paths under `.verify/artifacts/`.
- **Not run:** any step that could not run, why, and what would unblock it.
