# Trust in agstack

agstack's claim is not that its skills are good. It is that skill changes are *measured* before they ship, and every run leaves evidence.

## The machinery

| Piece | Where | What it proves |
|---|---|---|
| Playbook contract | `skills/agstack-mode/playbooks/*.md` | The agent copies numbered steps into its plan before editing — the procedure runs verbatim, not paraphrased. |
| Playbook enforcement | `scripts/playbook-check.sh` | Eval runs fail when the agent never read the required playbook. |
| Verification harness | `skills/verification` + `.verify/` | Completion claims come from allowlisted commands and receipts, never inspection. |
| Skill evolution | `eval/run.sh`, `eval/gate.sh`, `EVOLUTION.md` | A skill change promotes only with ≥5 reps, pass-rate ≥ baseline, no extra test edits, ≤120% of baseline turns. |
| Feedback loop | `skills/skill-feedback`, `scripts/skill-trace.sh` | Which skills loaded, how they were rated, tied to task outcomes. |

## Candidate set

Skills marked `status: candidate` entered through ports or new authoring and have not yet passed the promotion gate. They are available but not proven:

- `statechart`, `orchestrate`, `swarm` (v2), `watch-pr`, `reframe`, `why`, `typescript-best-practices`
- Extended `principles/*` added in the same batch

## How to read a claim

- A promoted skill names the eval run IDs in `CHANGELOG.md`. Absent that row, treat the skill as unproven.
- `.verify/artifacts/eval/results.tsv` records every graded run: task, condition, rep, hidden-check exit, added comments, tests changed, turns, cost.
