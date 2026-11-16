---
name: principle-explain-the-number
description: "Apply before reporting or acting on a measured number: a speedup, regression, latency, throughput, or eval score. Name the decision it changes, find what limits it, and rule out that it measured something other than the work."
---

# Explain the Number

A number is evidence only when you can say what produced it.

## Steps

1. **Name the decision first.** Write the result that would change what you do, and the noise floor: the run-to-run spread. If the spread is larger than the effect, the number cannot decide anything.
2. **Ask why it is not twice as good.** Name the resource or code path that bounds the result: a lock, the disk, the network, the load generator, or a single core. Confirm it with a profile or a system counter from the run. A guess from reading code is not a limiter.
3. **Rule out the other things it could measure.** Check for errors counted as success, skipped or cached work, code that never ran, a side left on default settings, and a change too small to matter end to end.
4. **Keep the evidence with the number.** Record the run count, the spread, and the limiter next to the figure.

## Skip when

- The number is only used to describe a run to yourself and nothing will be decided from it.

## Sign you skipped this

A reported number has no run count, no spread, or no named limiter.
