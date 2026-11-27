# Playbook: Pull Request & Delivery

Use this playbook whenever you are preparing, chunking, and opening a ready pull request for review.

---

> **Question budget: 1** — at most one user-facing question, and only after stating what was tried, why the repo or an experiment cannot answer it, and the default you will take if unanswered. `never-block-on-human` applies inside the budget.


Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: apply the core disciplines (`../token-efficiency/SKILL.md`, `../no-comments/SKILL.md` — read the full file only when its boundary is unclear), call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

## Process Steps

### Step 1: Working Tree Audit & Diff Hygiene
- Inspect git status and full diff against `master`:
  ```bash
  git status
  git diff master
  ```
- Verify zero unintentional changes, no stray debug logs, no commented-out code, and no newly introduced narration comments (`../scripts/check-added-comments.sh`).
- Confirm all touched files are necessary. Squeeze out unnecessary lines (`skills/token-efficiency/`).

### Step 2: Atomic Chunked Commits
- Group related changes into logical atomic commits rather than one massive commit.
- Use Conventional Commits (`feat(scope): ...`, `test(scope): ...`, etc.).
- Ensure every commit builds cleanly and passes focused tests.

### Step 3: Run Full Allowlisted Quality Gates
- Execute the complete verification harness:
  ```bash
  sh .verify/run.sh all
  ```
- Capture exit codes, logs, and coverage reports into `.verify/artifacts/<RUN_ID>/`.

### Step 4: Author Rich Pull Request Description
- Author the PR description following `skills/pull-request/SKILL.md`:
  - **Summary & Problem Intent:** What was built and why.
  - **High-Level Design (HLD):** Architecture diagram (Mermaid chart).
  - **Low-Level Design (LLD):** Data contracts, interface signatures, error models, and rollback plan.
  - **Commit Log:** Atomic chunk progression.
  - **Blast Radius:** Callers verified, downstream impact.
  - **Security & Injection Defense:** Zero secrets committed, dependency audit clean, delimiter boundaries and prompt injection defenses verified.
  - **Evidence Record:** Table with commands, exit codes, and coverage metrics.

### Step 5: Final Sanity Check
- Verify the PR branch is rebased cleanly onto the latest `master`.
- Present the final PR title and body to the user or push to origin.

### Step 6: Handoff
- The PR is open, not done — read `playbooks/babysit.md` — hydrate its checklist into the task list, then follow it to drive the PR to green. If the session ends before merge, name the PR state left for babysitting.

### Step 7: Closing Audit
- Before reporting, reopen the task list created at hydration and confirm every item is complete. An unchecked item is unfinished work, not a summary detail — the task is incomplete until every hydrated item is checked off or explicitly waived with a named reason.
