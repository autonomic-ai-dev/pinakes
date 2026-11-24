---
name: principle-subtract-before-you-add
description: "Apply when sequencing an addition, refactor, or rewrite. Remove dead code, redundant validators, and stub references first, then build on the simpler base."
version: 0.1.0
---

# Subtract Before You Add

When changing a system, remove complexity first and then build. Default to subtraction, and leave the code slightly simpler than you found it.

## Steps

1. **List what the change makes obsolete.** Dead code, duplicate validators, unused parameters, stub files, and redundant instructions.
2. **Remove those first**, in their own change, with the check green.
3. **Build on the smaller base.** Add only what the requirement demands.
4. **Design for observed use.** Do not add validators, parsers, or options for cases nobody has hit.

## Skip when

- Nothing in the touched area is dead or redundant. Then go straight to the change.

## Sign you skipped this

The new code sits next to an older path that does the same job, and neither has been removed.
