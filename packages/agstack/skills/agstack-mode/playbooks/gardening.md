# Playbook: Gardening (`gardening`)

> **Trigger & Intent:** A scheduled or requested sweep for a known defect class — foot-guns, anti-patterns, hygiene debt — producing small reviewable fixes rather than features.
> **Deliverable:** At most N small PRs (default 3), one finding each; a run record under `.verify/artifacts/gardening/<class>/`; the foot-gun catalog `.verify/footguns.md` updated with the run's outcome.

---

> **Question budget: 0** — no user-facing questions. Resolve every fork empirically; when evidence is genuinely absent, take the safer default and record the assumption in the evidence record.

---

## 1. Session Anchor & TodoList Contract

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: apply the core disciplines (`../token-efficiency/SKILL.md`, `../no-comments/SKILL.md` — read the full file only when its boundary is unclear), call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan instead of hydrating is a protocol breach, not compliance.

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/gardening.md` / `skills/verification/SKILL.md`)
```

- [ ] Step 1: Load the foot-gun catalog `.verify/footguns.md` and pick the sweep class named by the trigger — or the highest-yield `status: active` entry when unspecified
- [ ] Step 2: Detection fork — if the pattern is expressible as a lint or CI rule, write the rule and stop; sweeps exist for semantic patterns linting cannot express
- [ ] Step 3: Sweep the bounded surface the catalog entry names; collect candidate findings with file:line evidence
- [ ] Step 4: Fix at most N findings (the catalog entry's cap, default 3) — route each through its owning playbook (`bug-fix`/`refactoring`), root-cause fix plus regression test, never a bulk fix-everything diff
- [ ] Step 5: Ship each finding as its own PR via `pull-request`; the owning feature's `risk:` tier decides the merge bar
- [ ] Step 6: Record the run in `.verify/artifacts/gardening/<class>/run.md`: findings, fixes applied, PRs opened, findings deferred
- [ ] Step 7: Update the catalog — recompute merge-rate; a class under 50% merged over its last 5 runs is marked `status: retired` and not re-run

---

## 2. Core Invariants

1. **Lint before agents:** a foot-gun expressible as a rule becomes a rule. Spending agent runs on grep-able patterns is the failure the catalog exists to prevent.
2. **Caps are contracts:** the PR cap is never exceeded; unfixed findings stay in the run record for the next sweep.
3. **One finding per PR:** bulk sweeps produce unreviewable diffs. Small PRs are the product; volume is not.
4. **Merge-rate is the metric:** a sweep nobody merges is token noise — retire it by rule, not by feel.

---

## 3. Foot-gun catalog format

`.verify/footguns.md` is the registry that decides which sweeps are free (CI rules) and which cost agent runs:

```markdown
- `react-key-missing`: elements rendered in loops without stable keys
  - Detection: agent sweep (semantic; needs component context) — or `lint: react/jsx-key` when expressible
  - Fix recipe: derive the key from a stable entity id; regression: render test asserting key stability
  - PR cap: 3; merge-rate: 4/5 last runs; status: active
```
