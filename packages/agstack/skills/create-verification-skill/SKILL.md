---
name: create-verification-skill
description: "Create a project-specific verification playbook that drives the real app the way a user would: launch it, exercise a feature, capture evidence, and clean up. Use when a project has no scripted way to prove behavior end to end, or when only unit tests exist."
---

# Create a verification skill

Write the project's way to prove behavior by running the app, not only its unit tests.

## Steps

1. **Read the repository before asking.** Find the documented dev command, the ports, required environment variables, and any seed data.
2. **Pick the surface a user touches**: a web UI, a CLI, an HTTP API, or a library. If there are several, cover the primary one and name the rest.
3. **Write `.verify/drive/<surface>.md`** with five sections:
   - **Launch:** the exact command, and how to tell it is ready.
   - **Drive:** the steps a user would take, with literal values.
   - **Observe:** what to capture: exit codes, response bodies, screenshots, or logs.
   - **Evidence:** the artifact path for each capture under `.verify/artifacts/`.
   - **Cleanup:** how to stop the app and remove what the run created.
4. **Register each command** in the allowlist so the evidence counts.
5. **Prove the playbook before handing it over.** Run it once on the working tree. Then break the feature on purpose and confirm the playbook fails.
6. **Link it from the feature map** so each feature names its drive steps.

## Skip when

- The project is a library with full unit coverage and no user-facing surface.

## Sign you skipped this

The playbook has never been run against a broken build.
