# Playbook: Runtime Forensics (`runtime-forensics`)

> **Trigger & Intent:** Diagnosing a live, running backend symptom (e.g. process OOM crash, gradual memory leak, CPU spin, deadlocked worker pool, socket starvation, or FD leak) using active runtime instrumentation.
> **Deliverable:** A proven diagnosis identifying the exact mechanism and root cause before proposing or writing code fixes.

---

> **Question budget: 1** — at most one user-facing question, and only after stating what was tried, why the repo or an experiment cannot answer it, and the default you will take if unanswered. `never-block-on-human` applies inside the budget.


## 1. Session Anchor & TodoList Contract

Before touching code, emit the Session Anchor and copy these 5 steps verbatim into your active plan:

Before anything else — before exploring, before the first Edit/Write or state-changing Bash — complete this ritual: read `../token-efficiency/SKILL.md` and `../no-comments/SKILL.md`, call the task tool (`TaskCreate`/`TodoWrite`), and copy the steps below in as tasks. Narrating a plan or reading the refs after the first edit is a protocol breach, not compliance.

```markdown
> **Session Anchor:**
> - **Target Output Root**: `.verify/` (fixtures in `verify/` remain strictly read-only)
> - **SDLC Orchestrator**: `agstack` (`playbooks/runtime-forensics.md` / `skills/verification/SKILL.md`)
```

- [ ] Step 1: Isolate process and attach non-invasive runtime telemetry (output -> `.verify/artifacts/forensics-env.log`)
- [ ] Step 2: Capture live resource sampling under load (memory heap, thread dump, open FDs)
- [ ] Step 3: Reproduce resource accumulation or lock contention deterministically
- [ ] Step 4: Isolate root allocation / synchronization mechanism
- [ ] Step 5: Deliver proven diagnosis and transition to `bug-fix` playbook

---

## 2. Core Invariants

1. **Diagnosis First, Code Later:** The deliverable of this playbook is a proven diagnosis with telemetry evidence. Do not guess fixes or apply speculative patches while diagnosing.
2. **Deterministic Trigger:** Synthesize the traffic pattern or background workload that forces the condition to manifest.
3. **Safety on Live Daemons:** Use non-destructive probes (`lsof`, `jcmd`, `lldb`, `gdb`, OS metrics, or eBPF). Do not kill processes without recording PIDs.
4. **All Dumps to `.verify/artifacts/`:** Heap snapshots, core dumps, and stack traces must be saved strictly under `.verify/artifacts/`.

---

## 3. Checklist Steps

1. **Environmental Audit:** Record process PID, memory limits (cgroups/ulimit), open file descriptors, and socket states to `.verify/artifacts/forensics-env.log`.
2. **Attach Instrumentation:** Trigger non-invasive diagnostics (e.g. `kill -QUIT <pid>` for thread dumps, heap profiling via jemalloc/tcmalloc, or `tokio-console` for async task starvation).
3. **Controlled Reproduction:** Drive minimal synthetic load against the service until the metric climbs or the deadlock reproduces.
4. **Isolate Leaking Mechanism:** Correlate allocations or blocked lock primitives with specific code paths.
5. **Form Diagnosis:** Document the chain of events: trigger condition $\rightarrow$ blocked primitive $\rightarrow$ resource exhaustion.

---

## 4. Evidence Record & Reply Standard

```markdown
### Runtime Forensics Diagnosis
- Target Process: [Daemon name & PID]
- Symptom Observed: [Memory growth from 120MB to 1.8GB over 5000 requests]
- Telemetry Evidence: `.verify/artifacts/heap-diff.log` (Top allocation: 85% in `OrderEventBuffer::queue`)
- Root Cause Mechanism: [Unbounded channel buffer lack of backpressure during slow consumer disconnects]
- Next Action: Transitioning to `bug-fix` playbook with regression reproduction test.
```
