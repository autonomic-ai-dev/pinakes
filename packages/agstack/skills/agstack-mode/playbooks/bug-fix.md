# Playbook: Bug Fix (`bug-fix`)

> **Trigger & Intent:** Fixing a defect, crash, error, panic, unexpected behavior, or regression in backend code.
> **Deliverable:** A minimal root-cause fix paired with a failing-then-passing runtime regression test in `.verify/` and verified with `.verify/run.sh`.

---

> **Question budget: 1** — at most one user-facing question, and only after stating what was tried, why the repo or an experiment cannot answer it, and the default you will take if unanswered. `never-block-on-human` applies inside the budget.


## 1. Session Anchor & TodoList Contract

Before modifying code, emit the Session Anchor and copy these 7 steps verbatim into your active plan:

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: apply the core disciplines (`../token-efficiency/SKILL.md`, `../no-comments/SKILL.md` — read the full file only when its boundary is unclear), call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/bug-fix.md` / `skills/verification/SKILL.md`)
```

- [ ] Step 1: Reproduce with runtime evidence (failing test harness in `.verify/` -> exit non-zero)
- [ ] Step 2: Root cause analysis (attack the premise; identify broken assumption)
- [ ] Step 3: Implement minimal root-cause fix (immutability, zero comments, no band-aids)
- [ ] Step 4: Verify regression test now passes (exit 0)
- [ ] Step 5: Execute default post-dev verification via `agstack` `verification` skill (`.verify/run.sh`)
- [ ] Step 6: Code hygiene audit and deliver evidence record
- [ ] Step 7: Execute the handoff — when the fix ships this session, read `playbooks/code-review.md` then `playbooks/pull-request.md` and follow them. If delivery is out of scope, say so and name the artifact left for those playbooks. Before handing off, write the resumable bundle at `.verify/artifacts/bug-fix/bundle.md`: decisions made, files changed, evidence paths, and what the next phase needs to know.

---

## 2. Core Invariants

1. **Reproduction Before Fix:** Never touch production code before having a runtime reproduction that fails with exit code != 0. Belt-and-suspenders that "might help" does not ship.
2. **Verification Root Separation:** Reproduction tests and temporary fixtures MUST output strictly under `.verify/`. Input reference fixtures under `verify/` are strictly read-only.
3. **Attack Root Causes:** Never paper over symptoms with defensive `if (x == null)` checks or workaround hacks.
4. **Default Post-Dev Verification:** Running `.verify/run.sh` is mandatory. Never ask the user if tests should be run.

---

## 3. Process Steps

### Step 1: Reproduce with Runtime Evidence (Mandatory)
- Write a minimal failing test case under `.verify/` that triggers the exact failure.
- Run the reproduction and observe the failing exit code and concrete error output.

### Step 2: Root Cause Analysis (Attack the Premise)
- Trace the defect to its fundamental root cause.
- Ask: What flawed assumption or broken contract allowed this state to occur?

### Step 3: Implement Minimal, Focused Fix
- Make the smallest change that completely resolves the root cause.
- Avoid incidental changes, reformatting unrelated code, or adding speculative features.

### Step 4: Regression Test Proof
- Verify that your test fails on the unfixed baseline and passes with the fix.

### Step 5: Verification Suite Run
- Run the feature's verification suite through the allowlist:
  ```bash
  sh .verify/run.sh <feature>
  ```
- Verify that both unit tests and functional contracts pass cleanly. Proof logs go to `.verify/artifacts/`.

### Step 6: Code Hygiene & Evidence Record
- Run `../scripts/check-added-comments.sh` and `../scripts/check-verify-separation.sh`.
- Deliver the final evidence record.

### Step 7: Closing Audit
- Before reporting, reopen the task list created at hydration and confirm every item is complete. An unchecked item is unfinished work, not a summary detail — the task is incomplete until every hydrated item is checked off or explicitly waived with a named reason.

---

## 4. Evidence Record & Reply Standard

```markdown
### Bug Fix Evidence Record
- Root Cause: [Specific mechanism resolved]
- Reproduction Test: [.verify/... (Failed -> Passed)]
- Verification Suite: `.verify/run.sh` (Exit Code 0)
- Proof Artifact: `.verify/artifacts/test.log`
```
