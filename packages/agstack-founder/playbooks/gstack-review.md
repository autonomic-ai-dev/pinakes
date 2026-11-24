# Playbook: gstack Review (`gstack-review`)

> **Trigger & Intent:** Garry Tan's executive and engineering review suite — YC office hours, CEO review, Design/DevEx/Eng reviews, and the Autoplan pipeline.
> **Deliverable:** Whatever the `gstack` skill prescribes for the review being run.

This playbook is a router, not a procedure. The work lives in the `gstack` skill shipped in the `agstack-founder` package.

1. If the `gstack` skill is installed, load it (`skills/gstack/SKILL.md` in this package) and follow it in full.
2. If it is not installed, stop and tell the user: "This task routes to the `gstack` skill in the `agstack-founder` package. Install `agstack-founder` to run it." Do not improvise a substitute.
