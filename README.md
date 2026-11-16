# Pinakes

Pinakes is the registry of curated skill packages, workflows, and developer utilities for the Autonomic AI agent stack.

## Standardized Layout

```text
agent-registry/
├── registry.json                    # Canonical registry index
├── README.md                        # Documentation & CLI reference
├── packages/                        # Standardized curated packages
│   └── agstack/                     # agstack (Abhiuday Gupta Stack) — Universal full-SDLC engineering operating system
├── workflows/                       # DAG workflows (run with thesmos)
│   ├── bugfix.yaml                  # @bugfix — Failing repro -> root cause -> minimal fix -> verify -> review
│   ├── feature.yaml                 # @feature — Intent -> model domain -> 4-H2 contract -> implement -> Hurl suites -> gate
│   ├── stacked-pr.yaml              # @stacked-pr — Atomic chunking -> verification -> rich PR description -> approval
│   ├── release-notes.yaml           # @release-notes — Diff collection -> Diátaxis notes -> review -> publish
│   └── mcp-health-check.yaml        # @mcp-health-check — doctor check -> skill search probe -> routing verify
├── scripts/                         # Zero-dependency utilities
│   └── run-workflow.sh              # Standalone DAG workflow engine (zero-thesmos execution)
└── utilities/                       # CLI utility catalog
    └── utilities.json
```

## Workflow Execution (Dual Mode)

Workflows are designed to run in two modes:
1. **With thesmos:** `thesmos run workflows/<name>.yaml`, or the MCP tool `spine_submit_workflow` (the MCP tool names keep their `spine_` prefix).
2. **Without thesmos (Autonomous Agent Self-Orchestration):** Any agent directly executes the DAG using the `workflow-engine` skill, or runs the zero-dependency portable runner:
   ```bash
   ./scripts/run-workflow.sh run workflows/bugfix.yaml
   ```

