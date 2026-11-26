# Playbook: Postmortem (`postmortem`)

> **Trigger & Intent:** After an incident is mitigated: producing the blameless timeline, the verified root cause, and the action items that prevent recurrence.
> **Deliverable:** A postmortem document with an evidence-backed timeline, a root cause proven (not asserted), and owned, verifiable action items.

---

## 1. Session Anchor & TodoList Contract

Copy these 6 steps verbatim into your active plan before writing:

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: read `../token-efficiency/SKILL.md` and `../no-comments/SKILL.md`, call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/postmortem.md` / `skills/verification/SKILL.md`)
```

- [ ] Step 1: Rebuild the timeline from the incident evidence bundle (timestamps from logs, not memory)
- [ ] Step 2: Prove the root cause — reproduce it or cite the exact log/code evidence
- [ ] Step 3: Run the causal chain (five-whys) from symptom to the systemic condition
- [ ] Step 4: Derive action items that each remove a link in that chain
- [ ] Step 5: Write the document and file it where the repo keeps runbooks/docs
- [ ] Step 6: Route the action items — each item that is code work this session: read `playbooks/bug-fix.md` or `playbooks/feature.md` — hydrate its checklist into the task list, then follow it. Items deferred get a named owner and artifact.
- [ ] Step 7: Closing audit — before reporting, reopen the hydrated task list and confirm every item is complete. An unchecked item is unfinished work, not a summary detail.

---

## 2. Core Invariants

1. **Blameless, evidence-bound:** Describe what the system and people did, timestamped from artifacts. No "should have known" — every claim cites a log line, commit, or config value.
2. **Root cause is proven:** A root cause is either reproduced, or backed by an exact log/code citation. "Likely" causes are labeled as candidate causes and kept visibly separate.
3. **Symptom ≠ cause:** "DB connection refused" is the symptom. The cause is the condition that made it inevitable (pool leak under retry storm, missing rollback path, unbounded queue).
4. **Action items remove links:** Each action item must break a specific link in the causal chain — detection gap, missing guardrail, untested rollback — not generic "be more careful" items.
5. **Verify the fix exists:** If an action item is "add a regression test" or "add an alert," it is not done until the test/alert exists and its check is allowlisted.

---

## 3. Checklist Steps

1. **Timeline:** From `.verify/artifacts/incident-<ts>/` build the ordered table: first anomaly → detection → mitigation applied → confirmed recovery. Use artifact timestamps; never reconstruct from memory.
2. **Root cause:** Reproduce the failure mode on the preserved evidence (re-run the crashing path, replay the request). If reproduction isn't possible, cite the decisive log lines and code path, and mark confidence explicitly.
3. **Causal chain:** Apply the `why` skill: from the symptom, ask why until each answer is a systemic condition (missing check, absent rollback, undocumented coupling), not a person's mistake.
4. **Action items:** For each link, write one item with an owner-slot, a verification method (test name, alert query, allowlisted command), and a priority. Separate "prevent recurrence" from "detect faster next time."
5. **File it:** Write the postmortem alongside the repo's existing runbooks/docs format. Cross-reference the incident bundle path and the `bug-fix` follow-up.

---

## 4. Evidence Record & Reply Standard

```markdown
### Postmortem Evidence Record
- Incident Bundle: [.verify/artifacts/incident-<ts>/]
- Timeline: [N entries, all timestamped from artifacts]
- Root Cause: [reproduced via <command> | cited at <file:line>, confidence: high/candidate]
- Causal Chain Depth: [N whys to systemic condition]
- Action Items: [N items, each with verification method]
- Document: [path to postmortem]
```
