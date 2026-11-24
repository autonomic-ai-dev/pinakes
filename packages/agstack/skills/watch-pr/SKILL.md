---
name: watch-pr
description: "Watch a GitHub pull request — or a queued stack of them — until checks, reviews, and mergeability resolve. Use when a PR must be driven to green, when a stacked PR queue must land in order, or with --status-only for a one-shot check table."
disable-model-invocation: true
version: 1.0.0
status: candidate
---

# watch-pr

A typed watcher (`scripts/`, TypeScript, run with bun) that polls a GitHub PR through `gh` until checks and review state resolve. GitHub only. Requires `bun` and an authenticated `gh`.

## Run

```bash
scripts/watch-pr [--owner <o>] [--repo <r>] --pr <number>
scripts/watch-pr --queued-stack --stack-prs <n,...>    # frozen bottom-to-top queue
scripts/watch-pr --pr <n> --status-only                # one status table, exit 0
```

Options: `--interval <s>` (default 60), `--sweep-interval <s>` (300), `--timeout <s>` (0 = none), `--max-query-errors <n>` (5), `--allow-draft` (don't treat draft as a merge gate), `--pretty` (human text; default JSON).

In check mode pass `--status-only`. For a landing stack pass the PR numbers bottom-to-top in `--stack-prs`, and pass the same list on every restart. The watcher reports `COMPLETE` when the ceiling merges; it exits non-zero on a terminal failure.

## Setup

Run `bun install` inside `scripts/` once if `node_modules/` is missing. Tests: `bun test` and `bun run typecheck` inside `scripts/`.
