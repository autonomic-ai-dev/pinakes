---
name: principle-fix-root-causes
description: "Apply when a defect is reported, or when about to add a guard, retry, or null check that would hide a failure."
version: 0.1.0
---

# Principle: Fix Root Causes

## Invariant
Never patch around a symptom. If a bug is caused by a race condition, corrupted state, or incorrect assumption, fix the condition at its source rather than adding another defensive check downstream.

## Application
1. **Reproduce first, then ask why at each step** until the answer is a wrong decision in the code, not a consequence of an earlier one. When stuck, instrument: read the actual error and the actual state. Do not guess.
2. **Check the legitimacy of the triggering state.** If the system may legitimately be in that state, the code that broke on it is the root cause — handling the state there is the fix. If the state should never exist, a check where it broke hides the bug: find what produced the state. Guards, retries, swallowed errors, clamped values, and discarded state are the usual hiding places.
3. **Suspect persisted state when failure appears only after a restart:** config files, caches, lock files, serialized state.
4. **Attack the Premise:**
   - If multiple fixes for a bug fail, write down the shared underlying premise and verify it directly. The premise is often wrong.
5. **Check for the pattern, not just the instance.** Find every place with the same fault and fix them all.
6. **Eliminate Workaround Sermons:**
   - Never write comments like `// hack to prevent crash` or add special casing for an invalid state that should never have been created. Make the invalid state impossible at creation time (`principle-foundational-thinking`). If a workaround needs a paragraph-long comment to justify it, the code is wrong — fix the code, not the comment.
7. **Regression Tests:**
   - Every fixed bug must have a dedicated test that reproduces the failure on the unfixed code and passes cleanly on the fix.
8. **Leave a signal.** If the deciding fact took a deep dig to find, propose the cheap, always-on signal that would have shown it at first look.
