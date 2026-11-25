# Playbook: Prototype

Use this playbook whenever you need to explore an architectural fork, evaluate competing design options, or test an empirical assumption cheaply before committing to production code.

---

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: read `../token-efficiency/SKILL.md` and `../no-comments/SKILL.md`, call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

## Process Steps

### Step 1: Formulate the Empirical Question
- Name the exact design trade-off or empirical unknown to settle (e.g., latency difference, ergonomic trade-off, API compatibility).
- Define clear evaluation criteria and metrics before building.

### Step 2: Build Isolated, Throwaway Implementations
- Implement the prototype in an isolated branch or scratch directory (e.g., `.scratch/` or separate test file).
- Do not pollute production files or core models with speculative abstractions.
- Keep the implementation strictly minimal — just enough to measure the unknown.

### Step 3: Run the Comparison
- Execute the prototype against concrete test cases or benchmark data.
- Collect quantitative metrics (latency, memory, binary size) or qualitative ergonomics.

### Step 4: Decision & Clean Disposal
- Present the empirical findings clearly with the winning approach.
- Delete the throwaway prototype code.
- Implement the chosen solution cleanly in production following the `feature` playbook.
