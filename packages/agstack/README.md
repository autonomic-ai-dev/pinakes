# agstack (Abhiuday Gupta Stack)

> If you want to ship reliable software, turn engineering discipline into an unbreakable process.

**`agstack`** is an agent-agnostic engineering operating system for autonomous coding agents (Antigravity CLI, Cursor, Claude Code, OpenCode, Codex, GitHub Copilot). It replaces prompt guessing with structured playbooks, foundational principles, four-part step verification (`.verify/`), and ruthless code hygiene.

---

## 1. Why agstack?

AI agents without a strict process produce slop: commentary that restates obvious code, fragile workarounds, unverified claims, and hallucinated fixes. 

Inspired by [pstack](https://github.com/cursor/plugins/tree/main/pstack), **`agstack`** adapts rigorous software practices into an agentic framework:
- **Full-SDLC Playbooks (`agstack-mode`):** One routing table maps intent to a single playbook along the spine — Request (`context-and-intent`, `investigation`, `multi-phase-plan`), Design (`design-and-architecture`, `prototype`), Build (`feature`, `bug-fix`, `refactoring`, `database-migration`, `test-suite-generation`, `technical-writing`), Verify (`code-review`, `security-and-jailbreak-defense`, `eval`), Deploy (`pull-request`, `babysit`, `shipping`, `devops-pipeline`, `infrastructure-orchestration`), Operate (`perf-issue`, `hillclimb`, `incident`, `trace-forensics`, `runtime-forensics`), Maintain (`postmortem`, `session-pickup`, `pause-safely`, `worktree-cleanup`), plus `autonomous-run`.
- **Subagent orchestration (`orchestrate`, `swarm`):** Planner/worker/verifier trees driven by `plan.json`/`state.json`/handoffs — the engine is host subagents or thesmos. Workers get a prepared context packet (`context.featureMaps`, `context.invariants`, `context.packet` from `.verify/context/<task>.md`) so they verify against curated knowledge instead of re-deriving it.
- **Interrogate Code, Never the User:** Agents discover entry points, ports, and schemas by navigating the codebase.
- **Deep Architecture & Patterns:** Conforming strictly to the repository's existing architecture, ADRs, and caller ergonomics (`architect`).
- **Forensics & Bug Repro:** Diagnosing stack traces, parsing logs, and proving bugs with failing runtime reproductions *before* writing any fix (`forensics`).
- **Blast Radius Analysis:** Proving safety across transitive callers, schema migrations, and event streams with running code (`blast-radius`).
- **Foundational Principles:** Grounding in immutability, boundary validation (Zod/serde), root-cause fixes, and testing observable behavior.
- **Four-Part Verification Harness (`.verify/`):** 4-H2 feature contracts with four-part step records (`Request:`, `Why:`, `Expected:`, `Impact:`), allowlisted commands (`verify.toml`), phased runners (`run.sh`), and generic coverage checks (`checks/feature_coverage.sh`).
- **Code Hygiene (`no-comments`, `unslop`):** Zero AI narration comments, zero commented-out code corpses, and concise, idiomatic code and prose.
- **High-Quality Technical Writing:** Clear, layered technical documentation following the Diátaxis framework, Google developer style, and Simplified Technical English (`technical-writing`).

---

## 2. Directory Layout

```text
agstack/
├── package.json                         # Universal bundle manifest
├── README.md                            # agstack documentation
├── AGENTS.md                            # Universal master engineering policy
├── FEATURE-MAP-FORMAT.md                # 4-H2 and 4-part verification contract spec
│
├── platforms/                           # Multi-agent platform projections
│   ├── claude/CLAUDE.md                 # Claude Code adapter
│   ├── github/copilot-instructions.md   # GitHub Copilot adapter
│   └── cursor/rules/                    # Cursor rules
│       ├── agstack.mdc                  # Core policy
│       ├── feature-map.mdc              # Feature map rules
│       ├── verification.mdc             # Verification rules
│       └── principles.mdc               # Principles reference
│
├── skills/                              # Universal skills (Open Agent Skills Standard)
│   ├── agstack-mode/                    # SDLC playbook orchestrator
│   │   ├── SKILL.md                     #   routing table, subagents section, trust contract
│   │   ├── worker.md                    #   worker kickoff contract (context is authoritative)
│   │   ├── agents/                      #   subagent definitions (agstack-agent, comment-sicko)
│   │   └── playbooks/                   # feature, bug-fix, incident, postmortem, babysit, etc.
│   ├── orchestrate/                     # Planner-tree subagent orchestration
│   │   ├── SKILL.md
│   │   ├── references/                  # planner, spawning, handoffs
│   │   └── schemas/                     # plan.schema.json, state.schema.json
│   ├── swarm/                           # Parallel worker fan-out drained into one report
│   ├── watch-pr/                        # Typed GitHub PR/stack watcher (bun + gh)
│   │   └── scripts/                     # cli.ts, github.ts, policy.ts, tests
│   ├── feature-map/                     # Feature contract authoring & coverage
│   │   ├── SKILL.md
│   │   ├── references/                  # contract-format, authoring-rules, layout-and-gates
│   │   └── scripts/                     # feature_coverage.sh, coverage_gate.sh, gate_report.sh
│   ├── verification/                    # Verification harness runner & allowlist
│   │   ├── SKILL.md
│   │   └── references/                  # allowlist-and-runner, hurl-standards
│   ├── security-audit/                  # Vulnerability scanning, secrets, OWASP, AST validation
│   ├── jailbreak-defense/               # Prompt injection defense, delimiters, tool bounds
│   ├── statechart/                      # TLA+ compiler + corpus rendered as Mermaid statecharts
│   ├── workflow-engine/                 # Autonomous DAG workflow self-orchestrator (zero-Spine)
│   ├── no-comments/                     # Strip AI chatter, preserve documentation integrity
│   ├── unslop/                          # Concise, direct, idiomatic code & prose
│   ├── interrogate/                     # Adversarial pre-completion review
│   └── principles/                      # Core engineering principles
│       ├── foundational-thinking/
│       ├── boundary-discipline/
│       ├── immutability-first/
│       ├── test-behavior-not-implementation/
│       ├── fix-root-causes/
│       └── never-block-on-human/
│
├── eval/                                # Skill-evolution gate: fixture tasks, hidden checks, A/B runs
├── docs/guide/                          # Onboarding guide
├── TRUST.md                             # What the machinery proves; candidate set
├── ENFORCEMENT.md                       # Enforcement classes
├── EVOLUTION.md / CHANGELOG.md          # Skill promotion doctrine + history
│
└── scripts/
    ├── check-added-comments.sh          # Git pre-commit comment linter
    ├── install-git-hook.sh              # Hook installer
    ├── maps_for.sh                      # Feature-map lookup for context packets
    ├── playbook-check.sh                # Eval enforcement: required playbook was read
    ├── run-workflow.py                  # Portable DAG workflow engine
    └── run-workflow.sh                  # Shell wrapper for standalone workflow execution
```

Companion packages (installed separately, prompted for when routed to and absent): `agstack-ui` (interface work), `agstack-founder` (entrepreneurship and executive reviews).

---

## 3. Installation & Usage

### Via the Claude Code marketplace
```bash
claude plugin marketplace add autonomic-ai-dev/pinakes
claude plugin install agstack@pinakes
```

### In Cursor
Pick `agstack-mode`, or activate `platforms/cursor/rules/agstack.mdc` as the Cursor rule. Skills are read from `skills/`, with no separate Cursor copy.

### In Claude Code
`platforms/claude/CLAUDE.md` is the Claude Code copy of `AGENTS.md`. Copy it to `CLAUDE.md` in the project root. Regenerate all host copies from `AGENTS.md` with `sh scripts/sync-host-policy.sh`.

### In Antigravity CLI / OpenCode / Codex
`AGENTS.md` and `skills/` conform to the native Agent Skills specification and are discovered automatically.

---

## 4. Verification Harness (`.verify/`)

When working in a repository with `.verify/`:
1. **Pre-flight Check:** Run `.verify/doctor.sh`.
2. **Execute Targeted Verification:**
   ```bash
   sh .verify/run.sh <feature>
   ```
3. **Verify Coverage:** `checks/feature_coverage.sh` guarantees 1:1 parity between feature contract steps and `.hurl` requests.
4. **Preserve Proof:** Proof artifacts in `.verify/artifacts/` survive teardown.
