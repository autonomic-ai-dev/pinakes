---
name: principle-test-behavior-not-implementation
description: "Apply when writing or reviewing tests, or when a test mocks internals or asserts on private methods."
version: 0.1.0
---

# Principle: Test Behavior, Not Implementation

## Invariant
Tests must prove what the user or consumer observes (outputs, status codes, database state, event emissions). Do not couple tests to private methods or internal variable names.

## Application
Judge each test against two imagined edits:

1. **Break the behavior.** Make the code return a wrong value, skip an effect, or do it twice. If the test still passes, it proves nothing. Usual causes: an assertion looser than the contract, an expected value computed by the code under test, or an assertion on data the test built itself.
2. **Change the internals.** Keep every observable result the same and restructure underneath. If the test now fails, it is pinned to the implementation and will need rewriting on every refactor.

Keep a test that catches the first edit and survives the second. To write one:

- **Derive the expected value from the requirement,** not from a run of the code. Drive the code through its users' interface with a concrete input.
- **The contract decides, not the shape of the assertion.** The error type callers branch on is the contract; the exact error message pins wording no caller reads. When "an empty cart never charges" is the promise, asserting the payment client got no call is behavior — pair it with a case where the charge happens so the test shows it can see a call.
- **Mock at Genuine Boundaries Only:** mock external networks, third-party payment gateways, or clock providers. Never mock the very business logic or internal service the test is verifying.
- **No Coverage Vanity:** do not write trivial assertions (e.g. testing getters/setters) to inflate coverage. Test real failure modes, edge conditions, and boundaries.
- A test can pin an invariant instead of a call — a key that must exist in two tables, a compile-time type check. The invariant is the behavior.
