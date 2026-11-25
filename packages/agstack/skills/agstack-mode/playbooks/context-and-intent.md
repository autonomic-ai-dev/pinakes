# Playbook: Context & Intent

Use this playbook at the beginning of any complex task to understand the existing system, design docs, git history, and true user/problem intent before touching any code.

---

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: read `../token-efficiency/SKILL.md` and `../no-comments/SKILL.md`, call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

## Process Steps

### Step 1: Interrogate Existing Documentation & History
- Read `docs/`, `rfcs/`, `adr/`, and architectural guides in the repository.
- Search git commit logs (`git log -S "<symbol>" --oneline`) and previous PR descriptions to understand why existing code was structured this way.
- Extract historical constraints and design rationale so they become active requirements, not blind obstacles.

### Step 2: Uncover the Problem Intent
- Distinguish the **surface request** from the **underlying problem**:
  - What is the user or caller actually trying to achieve?
  - What observable pain or limitation triggered this request?
  - Can the problem be solved with a simpler structural change rather than adding layers?

### Step 3: Map Codebase Touchpoints
- Identify the exact modules, router files, models, and tests that intersect the feature or bug.
- Build an evidence table mapping each touchpoint to clickable file links (`[file.ts](file:///path/to/file.ts#L10-L20)`).

### Step 4: Record Findings in a Mental Model
- State the intent, existing patterns, and constraints in 2-3 clear sentences before proceeding to design or code.
- When the findings will drive delegated or multi-step work, write them to `.verify/context/<task>.md`: intent, touchpoints with file links, the feature maps covering the area (`../scripts/maps_for.sh`), invariants to preserve, acceptance checks, and explicit non-goals. Orchestrated tasks consume it via `context.packet`; workers read it instead of repeating this pass.
- If there is an unresolved ambiguity, formulate an empirical test or check to settle it autonomously (`principle-never-block-on-human`).
