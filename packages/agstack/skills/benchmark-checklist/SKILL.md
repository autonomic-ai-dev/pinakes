---
name: benchmark-checklist
description: "Vet a performance measurement before reporting or acting on it: the limiter, whether it was tuned, error counts, repeatability, whether it matters end to end, and whether the work happened. Use whenever you run a benchmark or report a speedup or regression."
version: 0.1.0
---

# Benchmark checklist

Answer each question with evidence from a run, not a guess about the code.

## Before you run

- Write the sentence you will ship, for example "export is 30% faster at p50 on the 60k-row set". The questions test that sentence.
- Read the measurement script. Note what it times, counts, and skips.
- Check the machine's load and core count. If something else is busy, interleave the two sides so both see the same noise.

## The questions

1. **Why not double?** Name the limiter: a core, a lock, the disk, the network, or the load generator. Confirm it with a profile from a separate run, because profilers slow the work.
2. **Was it tuned?** Run both sides the way production runs them: the same build type, flags, batch sizes, pool sizes, and data.
3. **Did it break a limit?** Compare throughput with disk and network bandwidth, and the time saved with the time the change took.
4. **Did it error?** Count failures and check that outputs are correct. Fast rejections look like speed.
5. **Does it reproduce?** Run each side at least five times, alternating A and B. Report the median and the range. A gap inside the range is not a result.
6. **Does it matter?** Measure the end-to-end path a user waits on, and report the micro result as a share of it.
7. **Did the work happen?** Confirm the work ran inside the timed region: the request arrived, the rows were written, and the result was used.

## Skip when

- The number is only for your own orientation and no decision depends on it. Say that it is one run.

## Report

The sentence you shipped, the limiter, the run count and range, and the answer to each question that did not hold.
