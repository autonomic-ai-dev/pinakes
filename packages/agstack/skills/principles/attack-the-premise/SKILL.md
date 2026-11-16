---
name: principle-attack-the-premise
description: "Apply when two or more fixes that share one assumption have failed the same check. Write the assumption down and test it directly before writing another fix that depends on it."
---

# Attack the Premise

When two or more fixes that rest on the same assumption have failed the same check, suspect the assumption, not the fixes.

## Why

Each failed fix is evidence against the belief it assumed. A third fix on the same belief spends effort where the evidence already points elsewhere.

## Steps

1. **Write the premise down.** It is the one sentence that every failed fix assumed.
2. **Test it before the next fix.** Find an observation that would come out differently if the premise were false, and make that observation. Look at how the failures are distributed, not only how large they are.
3. **Follow the result.** If it contradicts the premise, look for what the failures share that the premise did not predict. If it confirms the premise, ask the next "why" (see `principle-fix-root-causes`); the earlier fixes may have treated a consequence.
4. **Remove the condition rather than compensating for it.** If one part always lands on the losing side, change what puts it there. A cleanup step that runs on every pass leaves the cause in place.

## Skip when

- The first fix has not failed yet, or the failures do not share an assumption.

## Sign you skipped this

A fourth fix is being written on the same belief, and no one has checked the belief.
