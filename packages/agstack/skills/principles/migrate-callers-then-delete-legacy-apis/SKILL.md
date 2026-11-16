---
name: principle-migrate-callers-then-delete-legacy-apis
description: "Apply when a new internal API is introduced while old callers still exist and no external users depend on the old one. Migrate every caller and delete the old API in the same change, rather than keeping a compatibility layer."
---

# Migrate Callers, Then Delete the Legacy API

When an internal API is replaced, move every caller to the new one and delete the old API in the same change. Do not keep a compatibility layer for code you own.

## Steps

1. **Find every caller.** Search the repository for the old name and each import path. Include tests, scripts, and configuration.
2. **Move each caller to the new API** in the same change.
3. **Update tests to assert the new contract.** Delete tests that only protected the old implementation details.
4. **Delete the old API.** Leave no wrapper, alias, or deprecated stub.
5. **Run the full check** and confirm nothing references the old name.

## Apply only when

- No external user depends on the old API.
- The project can absorb a coordinated breaking change in one change set.
- The new API is part of a simplification.

## Skip when

- The API is public, or other teams or packages depend on it. Then deprecate it in a separate change with a removal date.

## Sign you skipped this

A wrapper keeps the old name alive, and the code that calls the wrapper has not moved.
