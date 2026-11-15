---
name: feature-map
description: "Create, maintain, and verify a repository's feature map in .verify/: behaviour contracts linked to unit and functional test suites, with step-level verification, coverage checks, and an evidence record. Use for any repository that keeps a .verify/ harness, or that needs one."
---

# Feature map

A feature map is the repository's maintained inventory of behaviour. It links what users and operators can do to the tests that prove it. Its reader is any coding agent or contributor who has not seen the codebase before, reading the file in the middle of a task.

A good map answers three questions for that reader:

1. Which behaviours exist, and how to reach each one.
2. Which exact test commands prove a change to a behaviour.
3. Which traps, gaps, and stale expectations apply before anyone edits the code.

## Load the reference you need

| Task | Load |
|---|---|
| Write or review a feature contract | `references/contract-format.md` |
| Discover the surfaces, write the index, or apply the authoring rules | `references/authoring-rules.md` |
| Set up `.verify/`, run the quality gates, or record a review | `references/layout-and-gates.md` |
| Check the map's structure and that every `sh` command it names exists | `scripts/map_check.sh` |
| Check that every test entry is covered by exactly one step (HTTP suites) | `scripts/feature_coverage.sh` |
| Keep a map current after code changes (upkeep) | the Upkeep section below |
| Check a JaCoCo coverage floor | `scripts/coverage_gate.sh` |
| Run the ordered gates and write the evidence record | `scripts/gate_report.sh` |

## Core invariants

- Every feature contract has exactly four `H2` sections, in order: Sub-features, How to get to it, Verification Suites, Gotchas.
- Every step gives its request, its reason, its expected result with values, and its impact.
- Every functional test entry is covered by exactly one step.
- Calendar-dependent and environment-dependent values come from a recorded live query. Values not confirmed live are marked `[UNCONFIRMED]`.
- Commands contain no angle-bracket placeholders.
- Failing tests are fixed, not weakened. A gap or a failure is recorded in Gotchas.
- Every verification command is run through the allowlist in `.verify/verify.toml`.

## Upkeep

A map goes stale as soon as the code changes. Run this after any change to a feature's code, and at least once a day when the repository changes often:

1. Run `sh scripts/map_check.sh <map>` for each contract. Fix every FAIL before anything else.
2. For each sub-feature, read the code it names and confirm the behaviour and outcome still hold. Fix the lines that no longer match.
3. For each CLI or HTTP entry point, run it once with a literal value and confirm the documented result.
4. Add a sub-feature for any new user-visible behaviour, and remove one whose code is gone.
5. Record what changed in Gotchas, with the date and the evidence.
