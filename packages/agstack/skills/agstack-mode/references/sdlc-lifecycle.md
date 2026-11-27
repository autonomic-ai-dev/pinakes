# SDLC Lifecycle — the spine and its handoffs

The playbook catalog is one pipeline, not a menu. Each playbook consumes an artifact and produces one; its deliverable names the next playbook. Follow the edge — that is how a task travels from request to maintenance instead of stopping after one phase.

```
Request → Design → Build → Verify → Deploy → Operate → Maintain
```

## Request — what is actually being asked

| Playbook | Consumes | Produces | Hands to |
|---|---|---|---|
| `context-and-intent` | docs, ADRs, git history, feature maps | `.verify/context/<task>.md` packet | any playbook below; workers via `context.packet` |
| `investigation` | a symptom or question without a fix request | proven cause or answer | `bug-fix`, or `incident` if the cause is live |
| `multi-phase-plan` | a request too big for one pass | ordered phase list | `feature`/`refactoring` per phase |
| `autonomous-run` | a milestone-level goal | a self-driving run loop | whichever playbook each phase routes to |
| `coordinator` | a batch of payloads/issues | deduplicated `plan.json` + context packets | workers via `orchestrate` executors |

## Design — decide before building

| Playbook | Consumes | Produces | Hands to |
|---|---|---|---|
| `design-and-architecture` | intent, packet | domain model + interface decision | `feature`; `prototype` if a fork is unsettled |
| `prototype` | an unsettled design or perf fork | measured decision, disposed code | `feature` with the answer |

## Build — change the system

| Playbook | Consumes | Produces | Hands to |
|---|---|---|---|
| `feature` | intent + design | working slice + tests | `test-suite-generation` on gaps → `code-review` |
| `bug-fix` | reproduction, cause | root-cause fix + regression test | `code-review` → `pull-request` |
| `refactoring` | passing baseline | smaller diff, proven invariance | `code-review` |
| `database-migration` | schema need | up + tested rollback | `code-review` → `pull-request` |
| `test-suite-generation` | changed code | unit + functional coverage | `code-review` |
| `technical-writing` | knowledge to transfer | docs, runbooks, ADRs | `pull-request` |
| `authoring-a-skill` | a repeated procedure | a candidate skill | `eval` for promotion |
| `playbook-authoring` | a bench failure or scope gap | a candidate playbook or doctrine fix | `eval` for promotion |

## Verify — prove it before it ships

| Playbook | Consumes | Produces | Hands to |
|---|---|---|---|
| `code-review` | a diff | findings or a clean pass | `bug-fix` on defects; `pull-request` when clean |
| `security-and-jailbreak-defense` | a diff or surface | findings or a clean pass | `bug-fix` on defects; `pull-request` when clean |
| `eval` | a candidate skill | gate verdict + rep evidence | promotion, or revision of the skill |

## Deploy — get it to production safely

| Playbook | Consumes | Produces | Hands to |
|---|---|---|---|
| `pull-request` | verified diff | reviewable PR with evidence | `babysit` |
| `babysit` | an open PR | merged, deployed, watched | done; `incident` or `bug-fix` on failure |
| `shipping` | a release decision | cut release, notes, tag | `devops-pipeline` |
| `devops-pipeline` | something to deploy | pipeline run, rollback path | Operate watch |
| `infrastructure-orchestration` | infra change | applied infra, drift check | Operate watch |

## Operate — keep it healthy

| Playbook | Consumes | Produces | Hands to |
|---|---|---|---|
| `incident` | a live failure | mitigation + frozen evidence bundle | `bug-fix` for the repair, `postmortem` for the record |
| `perf-issue` | slowness | profiled fix vs a budget | `code-review`; `hillclimb` for iterative work |
| `hillclimb` | a metric to move | measured steps, kept wins | `pull-request` |
| `runtime-forensics` | a crashed or hung process | diagnosed failure | `bug-fix`; `incident` if user-facing |
| `trace-forensics` | confusing behavior across calls | diagnosed path | `bug-fix` |

## Maintain — learn, clean up, continue

| Playbook | Consumes | Produces | Hands to |
|---|---|---|---|
| `postmortem` | an incident bundle | blameless writeup + action items | action items become new intake (`feature`/`bug-fix`) |
| `pause-safely` | work mid-flight | resumable state | `session-pickup` |
| `session-pickup` | a paused or handed-off task | resumed context | whichever playbook the task routes to |
| `worktree-cleanup` | finished work | clean tree, no orphans | done |
| `gardening` | a foot-gun catalog entry (`.verify/footguns.md`) | small capped fix PRs + a run record | `pull-request` per finding |

## The handoff rule

A playbook is complete when its deliverable exists — and the deliverable names the next playbook. Ending early (fix merged but deploy unwatched, incident mitigated but no postmortem, review findings with no fix task) is a truncated pipeline. If the next phase is genuinely out of scope, say so and name the artifact you are leaving for it.
