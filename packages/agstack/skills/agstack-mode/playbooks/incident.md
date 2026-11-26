# Playbook: Incident (`incident`)

> **Trigger & Intent:** A live production or CI failure: crash loops, alerts, error spikes, hung services, or a reported outage that needs mitigation first and understanding second.
> **Deliverable:** A mitigated system, an evidence bundle in `.verify/artifacts/incident-<ts>/`, and a handoff note naming the confirmed or candidate root cause.

> **Lifecycle position — Operate.** Receives: an alert, a failing probe, or a user report — sometimes handed off from `babysit` or `investigation`. Hands to: `bug-fix` (the root-cause repair with its regression test) and `postmortem` (the blameless record). Full spine: `references/sdlc-lifecycle.md`.

---

## 1. The Model

An incident is two different jobs that humans learn to separate the hard way: **stop the bleeding** and **find out why it happened**. Doing them in the wrong order is the classic failure — the agent that starts reading code while users are still down, or that restarts the wedged service "to see if it helps" and destroys the only copy of the evidence.

The ordering rule exists because of a property of failures: **mitigation is fast and reversible, diagnosis is slow and mutating.** A rollback, flag flip, restart, or scale-up takes seconds and can be undone. Reading logs, correlating deploys, and tracing code paths takes minutes and usually requires touching the system — every restart, redeploy, or debug command overwrites the state you needed to study. So the craft is: freeze the evidence first (read-only, cheap), apply exactly one reversible lever, prove the fix with a real probe, and only then do the slow diagnosis — on the preserved bundle, where the evidence can't be destroyed by anything you do next.

Two further craft rules live inside that ordering. **Reversible levers only during the incident**: shipping an unverified code fix as the "mitigation" is how one outage becomes two. **One change at a time**: if you apply two levers and the probe goes green, you can never say which one worked — and the postmortem inherits a guess.

---

## 2. Session Anchor & TodoList Contract

Before touching anything, emit the Session Anchor and copy these 6 steps verbatim into your active plan:

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: read `../token-efficiency/SKILL.md` and `../no-comments/SKILL.md`, call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

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
- [ ] Step 6: Write the incident note, then execute the handoff — read `playbooks/bug-fix.md` — hydrate its checklist into the task list, then follow it for the root-cause repair with regression test, then read `playbooks/postmortem.md` for the blameless record. Writing "hand off to X" in the note is not the handoff.
- [ ] Step 7: Closing audit — before reporting, reopen the hydrated task list and confirm every item is complete. An unchecked item is unfinished work, not a summary detail.

---

## 3. Core Invariants

1. **Mitigate before diagnose:** Restore service with the fastest reversible lever. Root-cause analysis happens on preserved evidence after the bleeding stops.
2. **Evidence first, mutation second:** Capture logs, `git log` of recent deploys, config state, and process state into `.verify/artifacts/incident-<ts>/` before restarting or rolling back anything. A restarted system destroys its own evidence.
3. **Reversible levers only:** During an active incident use rollback, flags, restarts, and scaling. Never ship an unverified code fix as the mitigation — that is a second incident waiting.
4. **One change at a time:** Apply one mitigation lever, probe, then decide. Two simultaneous changes make the recovery unexplainable.
5. **State assumptions aloud:** Distinguish "confirmed by evidence" from "candidate hypothesis" in every status line. Do not let a guess harden into the postmortem's root cause.

---

## 4. Checklist Steps

1. **Blast radius:** Read the alert/error text literally. Identify the failing surface (endpoint, job, region), the start time, and whether impact is total or partial. Check `git log --since` against deploy times — a failure that started at a deploy is a suspect, not a coincidence.
2. **Freeze evidence:** Copy the relevant log window, current config, process/container state, and the recent-deploy diff into `.verify/artifacts/incident-<ts>/`. Evidence collection is read-only.
3. **Mitigate:** Pick the fastest reversible lever: roll back the suspect deploy, flip the flag, restart the wedged process, or scale the exhausted resource. Apply exactly one.
4. **Probe to confirm:** Re-run the failing operation end-to-end (the real health check, the real request). "Process is up" is not "service is healthy."
5. **Root cause on evidence:** With service restored, work the preserved bundle: correlate the first failure timestamp with deploys/config changes, follow the stack trace to the code path, and form the minimal repro.
6. **Hand off:** Write `.verify/artifacts/incident-<ts>/NOTE.md`: timeline, impact, mitigation applied, root cause (confirmed/candidate), follow-ups. Long-term fix goes through `bug-fix` with its regression test; the writeup continues in `postmortem`.

---

## 5. Traps

- **Diagnosing first.** The repo is right there and reading code feels productive — meanwhile users are down. Order is not optional.
- **Restarting to see.** "Let's just restart it" before freezing evidence destroys the exact state that would have explained the failure.
- **The confident guess.** "It was probably the deploy" written into the note becomes the official root cause. Mark candidates as candidates until evidence confirms them.
- **Stopping at mitigation.** Service restored is not done — the deliverable is the bundle and the handoff note. A truncated pipeline leaves the fix and the postmortem unwritten.

---

## 6. Evidence Record & Reply Standard

```markdown
### Incident Evidence Record
- Impact: [surface, start time, total/partial]
- Evidence Bundle: [.verify/artifacts/incident-<ts>/]
- Mitigation: [lever used] → confirmed by [probe, exit/output]
- Root Cause: [confirmed one-line cause | candidate hypotheses ranked]
- Follow-ups: [bug-fix task, monitoring gap, rollback-path gap]
```
