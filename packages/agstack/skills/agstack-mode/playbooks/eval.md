# Playbook: Evaluation (`eval`)

> **Trigger & Intent:** Evaluating, benchmarking, or regression-testing an agent skill, playbook, system prompt instruction, or routing heuristic against a task corpus — including running the agstack-bench harness before promoting doctrine.
> **Deliverable:** A quantitative comparison of baseline vs candidate performance across reps, with per-spec-line adherence, demerits, and a gate verdict.

---

> **Question budget: 1** — at most one user-facing question, and only after stating what was tried, why the repo or an experiment cannot answer it, and the default you will take if unanswered. `never-block-on-human` applies inside the budget.


## 1. Session Anchor & TodoList Contract

Before modifying skills or prompts, emit the Session Anchor and copy these 7 steps verbatim into your active plan:

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: read `../token-efficiency/SKILL.md` and `../no-comments/SKILL.md`, call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/eval.md` / `skills/verification/SKILL.md`)
```

- [ ] Step 1: Pick the task set and rep count (N >= 5 for a promotable result; the golden corpus is read-only)
- [ ] Step 2: Run baseline reps on the `none` condition, then candidate reps on `agstack`
- [ ] Step 3: Read `grade.out` per rep and `steps.sh` for per-spec-line adherence — distinguish agent failure from grader failure before scoring
- [ ] Step 4: For each failure, audit the checker before the agent: apply-context, tool allowlist, path regex, demerit semantics
- [ ] Step 5: Run `gate.sh` for the promotion verdict; a HOLD names the blocking criterion
- [ ] Step 6: Record verdicts in `results.tsv` and feed observed failure modes back into the playbook's Traps
- [ ] Step 7: Closing audit — reopen the hydrated task list and confirm every item is complete before reporting

---

## 2. Core Invariants

1. **Golden corpus immutability.** Task fixtures, `hidden.sh` graders, and `meta.toml` are read-only during measurement. A fixture change is a new corpus version, not an edit.
2. **The grader owns the tests.** `hidden.sh` restores patch-target paths to `HEAD` (or deletes paths the patch creates) before applying its test patch — agent test edits must never corrupt grading context.
3. **Objective scoring only.** Binary pass/fail assertions, regex matches, and diff-derived demerits — never prose judgments of "looks correct."
4. **Audit the measurement first.** A spec line that no run can pass measures an impossible condition (a tool the host doesn't expose, a path form the regex can't match). Check the detector before changing the doctrine.
5. **Baseline is mandatory.** A candidate score without a `none` baseline on the same tasks is an assertion, not a result.

---

## 3. Checklist Steps

### Step 1: Assemble the Task Set
- Authored tasks live in `tasks/`; mined real-repo tasks come from `generators/discover.sh` + `generators/revert.sh` (skip merges, bound diff size — whole-PR diffs produce ungradeable tasks).
- Verify each generated task end-to-end once: buggy fixture fails hidden, `oracle.patch` source half passes it.

### Step 2: Run the Reps
- `sh eval/run.sh <task-id> <none|agstack> <rep>` — task ids for generated tasks drop the `generated/` prefix.
- `allowedTools` must cover the task's test-runner binaries (`python3`, `pytest`, `node`, `bun`, ...). A denied reproduction step deadlocks any playbook that requires evidence-before-edit.
- Harness scripts run under POSIX `sh` — no process substitution, no bashisms.

### Step 3: Score with the Right Anchors
- `hidden.sh` = outcome (suite passes, artifacts exist). `playbook-check.sh` = protocol (plan hydrated, playbook read, refs read before first edit).
- Chain tasks need phase-aware anchors: the second playbook is correctly read *after* phase-one edits — use `after` semantics there.
- Demerits: added comments in source, and test-file deletions that do NOT match `oracle.patch`'s own deletions. Pure test additions and oracle-matching deletions are correct behavior, not demerits.

### Step 4: Classify Failures
- Read `grade.out` and `claude.jsonl` on failures. Permission denials (`permission_denials` count), tool-name mismatches, and `..`-relative reads each masqueraded as agent failures in bench history.
- An agent that reasons correctly but places an artifact where doctrine (not the grader) says it belongs is a grader bug — widen the grader to doctrine-consistent locations.

### Step 5: Gate the Verdict
- `sh eval/gate.sh <baseline> <candidate> <task|all>` — PROMOTE requires N ≥ 5, pass rate ≥ baseline, demerits ≤ baseline, mean turns ≤ 120% of baseline. A HOLD names which criterion blocked.

### Step 6: Feed Traps Back
- Every repeated failure mode becomes a `## Traps` entry in the owning playbook, citing the rep that produced it. The bench writes the traps; do not invent them.

### Step 7: Aggregate
- `eval/steps.sh` gives per-spec-line pass rates across all streams; use it to rank the next doctrine defect.

---

## 4. Evidence Record & Reply Standard

```markdown
### Evaluation Scorecard
- Corpus: [task set, N reps/condition]
- Baseline: [hidden x/N, demerits n, mean turns t]
- Candidate: [hidden x/N, protocol x/N, demerits n, mean turns t]
- Grader fixes applied during scoring: [list, or none]
- Gate: [PROMOTE / HOLD — criterion]
- Traps appended: [playbook: trap]
```
