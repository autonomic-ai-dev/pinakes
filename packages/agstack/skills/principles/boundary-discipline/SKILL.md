---
name: principle-boundary-discipline
description: "Apply when code parses external input such as requests, files, env, or subprocess output, or when internal code re-validates data that is already typed."
version: 0.1.0
---

# Principle: Boundary Discipline

## Invariant
Validate and parse all external data at the edge of the system (HTTP controllers, CLI arguments, event listeners, database readers). Once inside the boundary, trust internal strongly-typed models without defensive re-validation.

## Application
1. **Parse, Don't Validate:** Use schemas (Zod, serde, Pydantic, protobuf) to transform raw input into typed internal domain objects. If input is malformed, reject it immediately with structured error messages.
2. **Pure Domain Logic:** Domain functions should accept clean, typed parameters and return typed results. They should not re-check nullability or string formats already validated at the boundary.
3. **Fail Fast:** Never allow unparsed JSON, untyped maps, or loose primitives to wander through multiple layers of business logic.
4. **Expose domain concepts, not private representations:** do not re-export transport, storage, framework, or wire types through the public surface. Keep general-purpose mechanism inside and special-purpose policy at the edge.
5. **Pure core, thin shell:** business logic lives in pure functions with no framework dependencies so it can be tested without the framework. Parse functions are pure transforms from raw bytes to typed state.
