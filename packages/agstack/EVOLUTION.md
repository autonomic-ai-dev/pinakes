# Evolving agstack skills

A skill changes only when evidence shows the change helps. The loop has five steps, and each has a command.

## 1. Observe

- Each eval run records which skills it loaded. `scripts/skill-trace.sh <stream.jsonl>` prints one line per skill with its load count.
- Each rating from `skill-feedback.sh` is stored next to the objective result of the task it came from. A rating without a result is noted as unverified.

## 2. Propose

- Start from one failure or one low rating. Write the failing case, the skill it implicates, and the smallest change that would have prevented it.
- Add the case to the held-out set, not to the set the skill was tuned on.

## 3. Test

- Run the skill on and off across the same tasks, at least five repetitions each: `eval/run.sh <task> <condition> <rep>`.
- Check the result with `eval/gate.sh <baseline> <candidate> <task|all>`.

## 4. Promote or revert

- `gate.sh` prints PROMOTE only when the candidate passes at least as many hidden checks, edits no more test files, and uses no more than 120% of the baseline's turns.
- A promoted change bumps the skill's `version` (MAJOR for a removed rule, MINOR for a new rule, PATCH for wording), and gets a row in `CHANGELOG.md` that names the eval run IDs.
- A held change is reverted, and its candidate case stays in the held-out set.

## 5. Retire

- A skill that has been advisory for three releases with no measured effect is set to `status: deprecated` with a `removal:` date.
- Lint fails on a deprecated skill without a removal date, and on any status other than `active`, `candidate`, or `deprecated`.

## Keeping copies in step

- `scripts/sync-host-policy.sh check` fails when a host policy copy differs from `AGENTS.md`. Run it before a commit.
