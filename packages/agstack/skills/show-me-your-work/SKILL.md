---
name: show-me-your-work
description: "Keep a reviewable decision trail for long or unattended work: one row per decision with what, why, evidence, and result. Use for autonomous or multi-phase runs, or any work a person reviews after stepping away."
version: 0.1.0
---

# Show me your work

Keep one log per run, with one row per decision.

## Format

A TSV file at `.verify/artifacts/trail/<run>.tsv`, with this header:

```
ts	phase	decision	why	evidence	result
```

- **ts:** ISO 8601 time.
- **phase:** the step or workstream.
- **decision:** what was done, in one line.
- **why:** the reason in plain words.
- **evidence:** a pointer such as a commit, `file:line`, or an artifact path. Never prose.
- **result:** the outcome, such as `tests green`, `reverted`, or `INCONCLUSIVE`.

Keep every cell on one line.

## Steps

1. Create the log with the header before the first change.
2. Add a row for each decision that changes the result: a design choice, a rejected option, a failed check, or a revert.
3. Point evidence at the artifact, not at a summary of it.
4. At the end, check that every changed file is covered by a row.

## Skip when

- The work is a single edit that a reviewer can see in one diff.

## Sign you skipped this

A reviewer cannot tell from the log why a change was made, or the log is a narrative with no evidence column.
