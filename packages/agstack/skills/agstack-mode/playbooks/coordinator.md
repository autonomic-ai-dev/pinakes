# Playbook: Coordinator (`coordinator`)

> **Trigger & Intent:** A batch of work arrives together — issue bursts, webhook payloads, a triage queue, or several reports describing the same symptom — and must be deduplicated and fanned out across workers.
> **Deliverable:** A deduplicated `plan.json` (orchestrate schema) with a `.verify/context/` packet per task, a recorded topology decision under hard caps, and dispatched workers — plus a topology audit under `.verify/artifacts/coordinator/`.

---

> **Question budget: 0** — no user-facing questions. Resolve every fork empirically; when evidence is genuinely absent, take the safer default and record the assumption in the evidence record.

---

## 1. Session Anchor & TodoList Contract

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: apply the core disciplines (`../token-efficiency/SKILL.md`, `../no-comments/SKILL.md` — read the full file only when its boundary is unclear), call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan instead of hydrating is a protocol breach, not compliance.

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/coordinator.md` / `skills/orchestrate/SKILL.md`)
```

- [ ] Step 1: Collect and normalize the payloads — each becomes `{source, kind, title, body, refs}`; an unparseable payload is parked with a reason, never silently dropped
- [ ] Step 2: Cluster and deduplicate — same root cause or same blast radius merges into one task; record the merge rationale per cluster
- [ ] Step 3: Compile `plan.json` per `skills/orchestrate/schemas/plan.schema.json` — tasks, dependency edges, and a `.verify/context/<task>.md` packet per task (via `context-and-intent` when the task is ambiguous)
- [ ] Step 4: Decide topology — parallel fan-out only across disjoint surfaces; a sequential chain when tasks share files or state; worker cap (default 5) and per-run spend cap are hard limits
- [ ] Step 5: Dispatch via the best executor (`thesmos` DAG, background subagents, or remote/cloud agents, per `skills/orchestrate`); each worker brief carries its playbook path, its context packet, and the previous phase's `bundle.md` when chained
- [ ] Step 6: Audit — write `.verify/artifacts/coordinator/topology.md`: payload→task mapping, cluster rationale, caps, executor choice
- [ ] Step 7: Closing audit — every payload maps to a task or a parked reason; every published task has a context packet. An unmapped payload is unfinished work.

---

## 2. Core Invariants

1. **Deduplicate before dispatch:** N payloads become M ≤ N tasks. Parallel work that duplicates another worker's effort is waste with extra steps.
2. **Caps are hard limits:** worker count and spend cap are never exceeded; an over-cap backlog stays queued and is reported, never silently expanded.
3. **Every task traces to a payload:** no hallucinated work — a task without a source payload is deleted, not kept just in case.
4. **Planners coordinate, workers execute:** this playbook produces `plan.json`; it does not fix, edit, or merge anything itself. Implementation work is published as tasks.
5. **Topology is recorded:** an unlogged fan-out decision is an unauditable one.
