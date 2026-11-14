# curated-registry

Summary: agent-registry is the central index of curated skill packages, DAG workflows, and developer utilities for the Autonomic stack.

## Sub-features

- `registry-index`: Lists every package and its source in one file.
  - Intent: Give every client one canonical place to find a package.
  - Behaviour: `registry.json` maps each alias (for example `agstack`) to a local `path` or a `git_url` and `git_ref`. Packages marked `default` bootstrap a fresh install.
  - Outcome: Resolving the `agstack` alias through this index returns its source. Not verified in this pass.
- `agstack-package`: Ships the agstack engineering process as an installable package.
  - Intent: Give every agent the same verification and process standards.
  - Behaviour: `packages/agstack/` holds the playbooks, the verification skill, and the strict-verification layout.
  - Outcome: Installed agents read the same process files. Not verified in this pass.
- `dag-workflows`: Defines the bugfix, feature, stacked-PR, release-notes, and MCP health workflows as YAML DAGs.
  - Intent: Let agents run the same multi-step process with or without agent-spine.
  - Behaviour: The files in `workflows/` run under `agent-spine run workflows/<name>.yaml` or `scripts/run-workflow.sh run workflows/<name>.yaml` (no Spine).
  - Outcome: Each workflow reaches its gate. Not verified in this pass.
- `utility-catalog`: Lists the developer utilities.
  - Behaviour: `utilities/utilities.json`.

## Code

- `registry.json`
- `workflows.json`
- `packages/`
- `workflows/`
- `scripts/`
- `utilities/`

## How to get to it (user POV)

- Read `registry.json` to find a package's source.

## Verification Suites (Targeted Test Commands)

- Not defined in this repository's allowlist for this pass.

## Gotchas

- A client that caches this repository sees a change only after it re-reads the cache.
- A package entry needs either `path` or `git_url`. An entry with neither has no source to install.
- The workflows need agent-spine to run as a DAG. Without it, an agent runs the steps itself or uses `scripts/run-workflow.sh`.
