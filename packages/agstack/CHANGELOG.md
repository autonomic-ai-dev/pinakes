# Changelog

Each entry names the skills changed and the eval runs that justify the change. Skills without a version field are unversioned until their next edit.

## Unreleased

- **Added principles:** explain-the-number, sequence-verifiable-units, attack-the-premise, model-the-domain, migrate-callers-then-delete-legacy-apis, subtract-before-you-add. Status: advisory until measured.
- **Added task skills:** tdd, benchmark-checklist, show-me-your-work, swarm, statechart, create-verification-skill. Status: advisory until measured.
- **Core path:** token-efficiency and no-comments are read before the first edit on a code-changing task, not on every invocation. Basis: pilot 1 turn counts, agstack-now 8.8 against 5.9 with no skills.
- **Lite mode** added to agstack-mode, for one-file changes.
- **Verify template** added at `skills/verification/templates/verify.toml`.
- **Descriptions** shortened for agstack-mode, figure-it-out, and gstack.
- **Eval:** promotion gate (`eval/gate.sh`) and the widened runner allowlist.
- **Lint:** version and status fields are checked. Unversioned skills are counted.
- **Copies:** `sync-host-policy.sh check` added.
