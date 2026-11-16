---
name: tdd
description: "Fix a bug with a regression test first, when the bug has a clear, cheap test path. Use when asked for TDD, a failing test, or a regression test, or when a focused test would catch the bug. Skip when the test would need heavy setup, mocks of internals, or production state."
---

# Test-first bug fix

Make the broken behavior executable before you change production code. The goal is one focused test that fails before the fix and passes after it.

## Steps

1. **Name the behavior.** Write the intended behavior, the current behavior, and the smallest input that shows the difference.
2. **Find the narrowest test path.** Use the test file closest to the code. Do not create a new harness to hold one test.
3. **Write the test against intended behavior.** It must not mirror the current implementation.
4. **Run it and confirm it fails for the bug.** A test that fails for another reason, or passes, is wrong. Fix the test first.
5. **Make the smallest production change** that satisfies the test.
6. **Rerun the test and the full check.** Both must pass.

## Guardrails

- Do not edit an existing test to match a wrong implementation.
- Do not weaken an assertion unless the expected behavior has genuinely changed, and say why in the report.
- If a practical test does not exist, say so and use the closest executable check instead: a script, a manual reproduction command, or a focused integration check.

## Skip when

- The test path needs infrastructure the fix does not justify.
- The bug is vague, so the reproduction cannot be written down.

## Report

Name the test, the failure it produced before the fix, and the passing run after it.
