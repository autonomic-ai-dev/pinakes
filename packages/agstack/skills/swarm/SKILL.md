---
name: swarm
description: "Split independent work into parallel workers, then merge their results into one report. Use for coverage sweeps, race checks, or exploring many candidates at once. Skip when the parts depend on each other or the work is small."
---

# Swarm

Run independent parts in parallel and return one report. Use it only when the parts do not depend on each other.

## Steps

1. **Partition.** Split the work into parts with no shared writes. Each part names its inputs, its output path, and its success check.
2. **Fan out.** Give each worker one part and the same instructions. Where the host lacks parallel workers, run the parts one after another and say so.
3. **Keep writes apart.** Each worker writes only to its own output path. Nothing writes to the shared working tree.
4. **Drain and check.** Wait for every worker. A part with no output or a failed check is reported as failed, not skipped.
5. **Merge into one report.** One table: part, result, evidence path, and any conflict between parts.

## Skip when

- Each part needs the previous part's result.
- There are fewer than three parts. A single worker is faster.

## Sign you skipped this

Two workers edited the same file, or a failed part was dropped from the report.
