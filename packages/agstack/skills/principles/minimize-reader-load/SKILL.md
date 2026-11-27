---
name: principle-minimize-reader-load
description: "Apply when reviewing or shaping code that's hard to trace. Count layers between question and answer, and hidden state in the reader's head; collapse one-caller wrappers and shrink mutable scope."
disable-model-invocation: true
version: 0.1.0
---

# Minimize Reader Load

Reader load is the work a reader must do to understand code. It has two independent axes: layers to trace between the question and the answer, and hidden or mutable state to hold in their head. Guard both.

- Collapse layers that only forward: wrappers with one caller, adapters with no second implementation, pass-through methods. Inline them.
- Adjacent layers must change the abstraction. A layer that repeats the same methods and arguments adds reader load without compression — collapse it.
- Demand interface compression: a broad interface that hides little forces the reader to learn both the surface and the implementation. Prefer boundaries that hide meaningful decisions.
- Shrink state scope: returns over mutations, locals over fields, fields over module state, module state over globals. Derive instead of sync.
- Name an invariant once at the boundary, not in every consumer.
- Before adding a layer or a piece of state, ask: does it reduce reader load elsewhere by at least as much?

The test: can a new reader answer "where does X come from?" and "what can change X?" in under 30 seconds? If not, cut layers or cut state.
