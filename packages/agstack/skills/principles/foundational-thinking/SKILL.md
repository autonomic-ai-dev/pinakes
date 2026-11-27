---
name: principle-foundational-thinking
description: "Apply before writing control flow for a new feature, a state machine, or a function that branches on the same data in several places."
version: 0.1.0
---

# Principle: Foundational Thinking

## Invariant
Before writing loops, conditionals, or algorithms, model the domain. The shape and constraints of your data determine the simplicity and correctness of your code.

## Application
Structural decisions protect option value. Code-level decisions protect simplicity.

1. **Make Illegal States Unrepresentable:**
   - Use discriminated unions, algebraic data types, or enums instead of boolean flags (`isPending`, `isFailed`, `isComplete`) that could contradict one another.
2. **Core Types First:**
   - Define domain interfaces, entity structs, and events before wiring persistence or UI layers. Trace every access pattern and choose structures that match the dominant paths.
3. **Decouple Data from IO:**
   - Separate pure state transitions from side-effect-laden IO operations (network, disk, clock).
4. **DRY the structure, not every line:**
   - Types and data models should converge; three similar statements still beat a premature abstraction. Prefer explicit over clever.
5. **Concurrency corollary:**
   - Before sharing state between actors, ask "what happens if another actor modifies this concurrently?" If not "nothing", isolate (`principle-separate-before-serializing-shared-state`).
6. **Scaffold first:**
   - If something helps every later phase, do it first. CI, linting, test infrastructure, and shared types are scaffold. Sequence for option value: setup before features, tests before fixes.
7. **Land coherent abstractions:**
   - Each increment should land one coherent abstraction or deepen an existing one. Do not spread a new capability across callers as special-case coordination.
