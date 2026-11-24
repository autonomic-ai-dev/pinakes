---
name: principle-model-the-domain
description: "Apply when writing stateful logic, when a new feature adds another branch to an existing chain, or when the same shape assumption repeats across files. Encode the domain in a data structure instead of scattered conditionals."
version: 0.1.0
---

# Model the Domain

Encode the real domain in a data structure rather than spreading it across conditionals. A structure that matches the domain makes invalid states impossible to write and removes branches. Choosing it while writing is cheap. Recovering it later is a refactor that gets deferred.

## Reach for

- A state machine instead of several booleans or phase checks that must stay in sync.
- A typed model or discriminated union instead of loose parameters repeated across files.
- A map or lookup table instead of an if/else chain.
- A small module that owns one body of domain rules, instead of modules named after steps such as load, validate, and save.

## Skip when

- The current shape is already clear, local, and unlikely to grow. Boring code beats a premature abstraction.
- The new structure would add indirection without removing a branch, a duplicated rule, or an invalid state.

## Sign you skipped this

A new feature adds one more branch to an if/else chain, or a second boolean has to be kept in step with the first.
