# Curated registry

## What it does

agent-registry is the central index of curated packages, workflows, and utilities. Clients read it to find packages and run workflows.

## How it works

1. **Index.** `registry.json` maps each alias to a package source. Each entry has a `path` into this repository or a `git_url` with a `git_ref`.
2. **Read.** A client clones or pulls this repository and resolves an alias through the index. Packages marked `default` bootstrap a new install.
4. **Workflows.** Each file in `workflows/` is a DAG. An agent runs it with agent-spine, or with `scripts/run-workflow.sh` when Spine is not running.

## Where the code is

- `registry.json` and `workflows.json` are the indexes.
- `packages/agstack/` is the agstack package.
- `workflows/` holds the bugfix, feature, stacked-PR, release-notes, and MCP health workflows.
- `scripts/run-workflow.sh` is the zero-dependency runner.
- `utilities/utilities.json` is the utility catalog.

## How to use it

- `./scripts/run-workflow.sh run workflows/bugfix.yaml` to run a workflow without Spine.

## How it is verified

- No verification suite is defined for this repository in this pass.

## Known limits

- A client sees a change only after it re-reads the repository.
- Only the `agstack` package is shipped under `packages/`. Other aliases in `registry.json` point to external git sources that this repository does not contain.

## Related

- Feature map: `.verify/features/curated-registry.md`
