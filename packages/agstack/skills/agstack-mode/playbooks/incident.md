# Playbook: Incident (`incident`)

> **Trigger & Intent:** A live production or CI failure: crash loops, alerts, error spikes, hung services, or a reported outage that needs mitigation first and understanding second.
> **Deliverable:** A mitigated system, an evidence bundle in `.verify/artifacts/incident-<ts>/`, and a handoff note naming the confirmed or candidate root cause.

---

## 1. Session Anchor & TodoList Contract

Before touching anything, emit the Session Anchor and copy these 6 steps verbatim into your active plan:

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/incident.md` / `skills/verification/SKILL.md`)
```

- [ ] Step 1: Establish blast radius — what is down, since when, for whom
- [ ] Step 2: Freeze an evidence bundle (logs, recent deploys, config diff) before any change
- [ ] Step 3: Mitigate by the fastest reversible lever (rollback, feature flag, restart, scale)
- [ ] Step 4: Confirm mitigation with a live probe, not a log glance
- [ ] Step 5: Isolate root cause on the preserved evidence, not on the mutated system
- [ ] Step 6: Write the incident note and hand off to `postmortem` or `bug-fix`

---

## 2. Core Invariants

1. **Mitigate before diagnose:** Restore service with the fastest reversible lever. Root-cause analysis happens on preserved evidence after the bleeding stops.
2. **Evidence first, mutation second:** Capture logs, `git log` of recent deploys, config state, and process state into `.verify/artifacts/incident-<ts>/` before restarting or rolling back anything. A restarted system destroys its own evidence.
3. **Reversible levers only:** During an active incident use rollback, flags, restarts, and scaling. Never ship an unverified code fix as the mitigation — that is a second incident waiting.
4. **One change at a time:** Apply one mitigation lever, probe, then decide. Two simultaneous changes make the recovery unexplainable.
5. **State assumptions aloud:** Distinguish "confirmed by evidence" from "candidate hypothesis" in every status line. Do not let a guess harden into the postmortem's root cause.

---

## 3. Checklist Steps

1. **Blast radius:** Read the alert/error text literally. Identify the failing surface (endpoint, job, region), the start time, and whether impact is total or partial. Check `git log --since` against deploy times — a failure that started at a deploy is a suspect, not a coincidence.
2. **Freeze evidence:** Copy the relevant log window, current config, process/container state, and the recent-deploy diff into `.verify/artifacts/incident-<ts>/`. Evidence collection is read-only.
3. **Mitigate:** Pick the fastest reversible lever: roll back the suspect deploy, flip the flag, restart the wedged process, or scale the exhausted resource. Apply exactly one.
4. **Probe to confirm:** Re-run the failing operation end-to-end (the real health check, the real request). "Process is up" is not "service is healthy."
5. **Root cause on evidence:** With service restored, work the preserved bundle: correlate the first failure timestamp with deploys/config changes, follow the stack trace to the code path, and form the minimal repro.
6. **Hand off:** Write `.verify/artifacts/incident-<ts>/NOTE.md`: timeline, impact, mitigation applied, root cause (confirmed/candidate), follow-ups. Long-term fix goes through `bug-fix` with its regression test; the writeup continues in `postmortem`.

---

## 4. Evidence Record & Reply Standard

```markdown
### Incident Evidence Record
- Impact: [surface, start time, total/partial]
- Evidence Bundle: [.verify/artifacts/incident-<ts>/]
- Mitigation: [lever used] → confirmed by [probe, exit/output]
- Root Cause: [confirmed one-line cause | candidate hypotheses ranked]
- Follow-ups: [bug-fix task, monitoring gap, rollback-path gap]
```
