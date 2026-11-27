# Playbook: Playbook & Skill Maintenance (`playbook-authoring`)

> **Trigger & Intent:** Creating, fixing, or repairing an SDLC playbook (`playbooks/*.md`) or an agent skill (`skills/*/SKILL.md`) — including repairing doctrine measured as failing in the eval bench.
> **Deliverable:** A lean, executable playbook or skill whose checklist is verbatim-copyable, whose handoffs name files, and whose claims are bench-measured where a harness exists.

---

> **Question budget: 1** — at most one user-facing question, and only after stating what was tried, why the repo or an experiment cannot answer it, and the default you will take if unanswered. `never-block-on-human` applies inside the budget.


## 1. Session Anchor & TodoList Contract

Before modifying doctrine files, emit the Session Anchor and copy these 7 steps verbatim into your active plan:

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: apply the core disciplines (`../token-efficiency/SKILL.md`, `../no-comments/SKILL.md` — read the full file only when its boundary is unclear), call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/playbook-authoring.md` / `skills/verification/SKILL.md`)
```

- [ ] Step 1: Reproduce or cite the measured failure the change answers (bench rep, gate verdict, or spec line)
- [ ] Step 2: Put the instruction inside the artifact agents execute — the numbered checklist — not only in surrounding prose
- [ ] Step 3: Write executable handoff lines that name the next file and require hydrating its checklist
- [ ] Step 4: Keep the ritual preamble and copy-contract boilerplate identical to sibling playbooks
- [ ] Step 5: Hold the word budget (`skill-lint.sh`); move long teaching content to `references/`
- [ ] Step 6: Update routing — the playbook must appear in `agstack-mode`'s table and the lifecycle map if it hands off
- [ ] Step 7: Closing audit — reopen the hydrated task list and confirm every item is complete before reporting

---

## 2. Core Invariants

1. **The checklist is the execution surface.** Measured on the bench: agents execute numbered checklist items and ignore surrounding prose. An instruction that lives only in `SKILL.md` prose, a policy file, or an invariant paragraph is an instruction that does not fire. If it must happen, make it a numbered step.
2. **Name the tool concretely.** "Copy steps into your plan" is narrated and skipped; "call `TaskCreate`/`TodoWrite`" fires. Abstract references to host capabilities get rationalized away.
3. **Breach-declaration wording beats advisory wording.** "Reading the refs after the first edit is a protocol breach" outperforms "please read the refs first." State the failure mode the step prevents.
4. **Every instruction is a token cost.** Playbooks are read on every routed task. Teaching prose, lifecycle position, and trap lists must earn their tokens — prefer one-line pointers into `references/` over duplicated explanations across files.
5. **Bench over intuition.** A doctrine change that cannot be measured is a guess. Where a bench exists (`eval.md`), change → rep → gate is the loop; prose-only confidence is not evidence.

---

## 3. Checklist Steps

### Step 1: Ground the Change in Evidence
- Name what the edit answers: a failing spec line (`steps.sh`), a gate HOLD, a rep transcript where the agent did X instead of Y, or a declared scope gap.
- Do not change doctrine to fix a failure that was actually a broken grader — audit the measurement first. (Bench history: `git apply` context drift, missing tools in `allowedTools`, regex blind spots, oracle-overlapping demerits each masqueraded as agent failure.)

### Step 2: Edit the Executable Surface
- Make the fix a numbered checklist step in the playbook, or an executable line in the skill's core path.
- If a step is skipped at a lifecycle point, move it earlier — adherence decays with task length; front-load gates.

### Step 3: Handoffs Name Files and Hydrate
- A handoff is "read `playbooks/X.md` — hydrate its checklist into the task list, then follow it." "Hand off to X" written in a note is not a handoff.
- Chained checklists must enter the same task list so the closing audit can see them.

### Step 4: Match Sibling Shape
- Keep the frontmatter blockquote (Trigger & Intent / Deliverable), the ritual preamble paragraph, the Session Anchor block, and the `- [ ] Step N:` / `### Step N:` format of sibling playbooks.

### Step 5: Budget the Words
- Run `sh ../scripts/skill-lint.sh`. Skills sit under a word budget; playbooks stay terse — long teaching content goes to `references/` and is linked, not inlined.

### Step 6: Wire Routing
- Add the row to `agstack-mode`'s playbook table. If the playbook hands off, add its edge to `references/sdlc-lifecycle.md`. An unrouted playbook does not exist to agents.

### Step 7: Measure It
- If a bench exists for this doctrine: run a rep on the task family the change targets, read `grade.out`, and check `steps.sh` — do not declare the fix working from the diff alone. Hand off to `playbooks/eval.md` — hydrate its checklist into the task list, then follow it for the full gate.

---

## 4. Traps

- **Narrated compliance.** Agents write "I copied the steps into my plan" without calling the tool. Checklist steps must name the tool call.
- **Checker blindness.** Before fixing doctrine for a failing spec line, verify the checker can see the behavior at all (`..` paths, tool-name mismatches, permission denials have each produced phantom failures).
- **Grader-doctrine conflicts.** A grader that contradicts agstack's own rules (e.g. demanding artifacts outside `.verify/`) punishes correct agents — fix the grader, not the agent.
- **Spec anchor drift.** In chains, "playbook before first edit" anchors are phase-relative: the second playbook is correctly read *after* phase-one edits. Anchor `before`/`after` to the phase the playbook owns.

---

## 5. Evidence Record & Reply Standard

```markdown
### Playbook Maintenance Evidence Record
- Playbook/Skill: [name]
- Evidence: [rep / spec line / gate verdict motivating the change]
- Checklist Steps Changed: [n]
- Routing: [agstack-mode row added / lifecycle edge added]
- Lint: `skill-lint.sh` (exit code)
- Bench: [rep result / steps.sh delta, or "no harness — prose-only change"]
```
