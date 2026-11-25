# Enforcement classes

Every rule in agstack belongs to one class. The class says how far the rule can be trusted without a person reading the output.

- **Gated:** a script or command fails the work when the rule is broken. The agent cannot skip it without the gate reporting it.
- **Measured:** an eval task in `eval/tasks/` tests whether an agent follows the rule, and the result is recorded in `results.tsv`.
- **Advisory:** prose only. It stays only while measurement shows it changes outcomes. Advisory rules with no measurement are candidates for removal.

## Gated

| Rule | Gate |
|---|---|
| No new comments in changed code | `skills/agstack-mode/scripts/check-added-comments.sh` |
| Verification must run through the allowlist | `.verify/run.sh` in the repository |
| Runtime artifacts stay under `.verify/`, fixtures stay read-only | `scripts/check-verify-separation.sh` |
| Skill frontmatter, names, and word budgets | `scripts/skill-lint.sh` (run from `.verify/run.sh`) |

## Measured

These skills have a rule that an eval task can check.

| Skill or principle | Eval task | Metric |
|---|---|---|
| `no-comments` | `feature-words` | comment lines added |
| `verification` | `fix-config-port` | tests changed to pass; hidden check |
| `principles/fix-root-causes` | `bugfix-clamp` | hidden check on edge cases |
| `principles/boundary-discipline` | `boundary-safe-join` | hidden check on traversal inputs |
| `principles/smallest-complete-change` | `refactor-report` | output identical; hidden check |
| `principles/test-behavior-not-implementation` | `fix-config-port` | hidden check |

## Advisory

Every other skill is advisory until it is measured. This includes the routing and planning skills, the writing skills, and the business and executive skills. A skill moves to Measured when a task that exercises its rule is added to `eval/tasks/`.
