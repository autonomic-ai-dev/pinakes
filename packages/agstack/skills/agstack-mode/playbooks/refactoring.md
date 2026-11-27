# Playbook: Refactoring

Use this playbook whenever you are restructuring, modernizing, or cleaning up existing code without altering its external behavior.

---

> **Question budget: 1** — at most one user-facing question, and only after stating what was tried, why the repo or an experiment cannot answer it, and the default you will take if unanswered. `never-block-on-human` applies inside the budget.


Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: apply the core disciplines (`../token-efficiency/SKILL.md`, `../no-comments/SKILL.md` — read the full file only when its boundary is unclear), call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

## Process Steps

### Step 1: Baseline Verification (Pre-flight Gate)
- Run the existing test suite and verification harness before modifying any file:
  ```bash
  sh .verify/run.sh all
  ```
- If the baseline is red or flaky, STOP. You cannot refactor broken code. Fix or isolate the baseline failure first.

### Step 2: Subtract Before You Add
- Ground in `principle-subtract-before-you-add` and `principle-laziness-protocol`.
- Identify and eliminate dead code, unused helper functions, obsolete wrappers, and redundant abstractions.
- Settle deletions in a separate step or commit before introducing new structure.

### Step 3: Structural Refactoring
- Collapse one-caller intermediate functions and unnecessary proxy layers.
- Move mutable state toward immutability (`principle-immutability-first`).
- Tighten type definitions and make illegal states unrepresentable (`principle-foundational-thinking`).
- Keep files small, focused (< 400 lines typical, 800 lines absolute maximum).

### Step 4: Prove Invariance
- Run the full test suite again.
- External observable behavior, status codes, response shapes, and side effects must be identical.
- NEVER weaken an assertion to accommodate a refactoring change.

### Step 5: Final Review & Diff Hygiene
- Inspect git diff: verify zero unintended changes, no stray comments, no lingering debug logs.
- Run `no-comments` and `unslop`.
