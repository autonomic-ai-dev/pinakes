---
name: principle-type-system-discipline
description: "Apply when designing types, reviewing a function signature, or writing code in any statically-typed language. Make illegal states unrepresentable, brand semantic primitives, parse external data at boundaries, exhaust variants, derive from authoritative schemas."
disable-model-invocation: true
version: 0.1.0
---

# Type System Discipline

Make the compiler reject impossible states, mismatched primitives, and unhandled variants.

- **Make illegal states unrepresentable.** Model variants as sum types (discriminated unions, enums with payloads, sealed classes), not a bag of optional fields where contradictory combinations compile. `{ completed: boolean; completedAt?: Date }` admits `completed: true` with no date — derive the boolean or model `{ kind: 'open' } | { kind: 'done'; at: Date }`. If you can write a comment explaining when a combination of fields is valid, split it into a sum type.
- **Types are constructions, not restrictions.** Build the type up from the values you want instead of carving them out of a looser type with checks. A non-empty list is a head plus a rest; a valid range is a start plus a duration.
- **Brand semantic primitives.** `UserId` and `OrderId` are strings underneath but must not be interchangeable. Give each its own type. Validate once at creation, trust the type downstream.
- **External data is untyped until parsed.** JSON, RPC payloads, CLI args, config, environment variables, and database rows go through a parse function at the boundary that returns the typed model.
- **Don't lie to the type system.** Casts, unsafe coercions, and assertion functions that bypass the compiler are latent runtime crashes. Trace each `any`, `as`, or `assertNotNull` to the boundary and validate there.
- **Exhaustive matching is the compiler's job.** A match on a sum type must fail compilation when a new variant is added without handling, so the compiler tells the next agent where to add a case. Use the language's idiom: a `never`-typed binding in TypeScript, an unannotated `match` in Rust, sealed-class exhaustiveness in Kotlin.
- **Derive types from authoritative schemas.** When a schema file owns a shape, derive the type from it instead of hand-rolling a parallel one.
- **Strengthen a type only where partiality appears.** A runtime assertion, null check, or "this should never happen" throw marks where a type is too weak — push that check into the type, then stop. Prefer total functions: `sum` of an empty list is 0 and takes the plain list; `head` has no empty-list answer and demands the non-empty one.

For TypeScript syntax, see the **typescript-best-practices** skill.
