---
name: principle-sequence-verifiable-units
description: "Apply to multi-step work: sweeps, migrations, runs of similar edits, and how commits or PRs are ordered. Split it into units that each end in a checkable state, verify each before the next, and order delivery so a reviewer can replay it."
version: 0.1.0
---

# Sequence Verifiable Units

Order the work as small units. Each unit ends in a state you can check, and you do not start the next one until the current one passes.

## Why

A break caught in the unit that caused it is cheap to find. A break caught after a batch is buried under later edits. Units that can be replayed in order also let a reviewer watch the change go red, then green.

## Steps

1. **Start from a clean baseline.** Confirm the current state passes before the first edit.
2. **One change per unit.** Make one change, run its check, and continue only when it passes.
3. **Order delivery to prove itself.** For commits or PRs, the failing test comes first, then the fix. Scaffolding comes before the feature. A removal comes before a reshape.
4. **Keep each commit independently green.** A commit that breaks the build until the next commit is two units merged into one.

## Skip when

- The change is one edit in one file with one check.

## Sign you skipped this

A batch of edits was checked once at the end, and the first failure was found far from the edit that caused it.
