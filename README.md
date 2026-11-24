# Pinakes

Pinakes is the registry of curated skill packages, workflows, and developer utilities for the Autonomic AI agent stack. Named after the catalog of the Library of Alexandria: it indexes the content; the companion tools execute and prove it — **thesmos** runs DAG workflows, **tekmor** verifies and issues receipts.

## Layout

```text
pinakes/
├── registry.json                    # Canonical registry index (local + git packages)
├── workflows.json                   # Workflow catalog (invoke strings)
├── packages/
│   ├── agstack/                     # Backend & DevOps engineering OS: playbooks, skills,
│   │                                #   principles, subagent orchestration, .verify/ contract, eval gate
│   ├── agstack-ui/                  # Optional: UI design, pixel-fidelity, responsive, UI-testing skills
│   └── agstack-founder/             # Optional: entrepreneurship + executive-review skills
├── workflows/                       # DAG workflows (run with thesmos)
│   ├── bugfix.yaml                  # @bugfix — failing repro -> root cause -> minimal fix -> verify -> review
│   ├── feature.yaml                 # @feature — intent -> model domain -> 4-H2 contract -> implement -> gate
│   ├── stacked-pr.yaml              # @stacked-pr — atomic chunking -> verification -> PR description
│   ├── release-notes.yaml           # @release-notes — diff collection -> Diátaxis notes -> publish
│   ├── gstack.yaml                  # @gstack — executive review pipeline
│   ├── minimalist-entrepreneur.yaml # @minimalist-entrepreneur — idea validation pipeline
│   └── mcp-health-check.yaml        # @mcp-health-check — tekmor doctor/verify -> thesmos validate -> report
├── scripts/
│   └── run-workflow.sh              # Standalone linear workflow runner (no thesmos)
├── extensions/
│   └── bench/                       # Host extension (released binary)
├── utilities/
│   └── utilities.json               # Companion tool catalog (tekmor, thesmos)
└── .verify/
    ├── verify.toml                  # Allowlisted checks (tekmor verify)
    └── run.sh                       # Manifest, workflow, and skill-lint gate
```

## Packages

`registry.json` maps each alias to a local `path` or an external `git_url`. Local packages:

| Package | Domain | Default |
|---|---|---|
| `agstack` | Backend & DevOps: SDLC playbooks, principles, orchestration, verification | yes |
| `agstack-ui` | Interface work: Stitch design-to-code, pixel fidelity, UI tests | no |
| `agstack-founder` | Idea validation, MVP scoping, executive reviews | no |

External packages (`matt-skills`, `caveman`, `starter`, `nextjs`, `claude-skills`, `ecc`, `rust`, `official`, `minimalist-entrepreneur`, `gstack`) install from their git sources. Caveman (`caveman.so`) handles token compression — complementary to agstack's `token-efficiency` policy.

## Workflow execution (dual mode)

1. **With thesmos:** `thesmos run workflows/<name>.yaml`, or the MCP tool `spine_submit_workflow`.
2. **Without thesmos:** an agent executes the steps itself via the `workflow-engine` skill, or the zero-dependency portable runner:
   ```bash
   ./scripts/run-workflow.sh run workflows/bugfix.yaml
   ```
   The portable runner validates linear chains — `run-workflow.py validate` rejects cycles and fan-out.

## Self-verification

```bash
sh .verify/run.sh      # jq-validates manifests, validates all workflows, lints all package skills
tekmor verify          # issues a receipt via .verify/verify.toml
```
