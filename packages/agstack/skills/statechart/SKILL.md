---
name: statechart
description: "Check a system that moves between states, such as a checkout flow, a job queue, or a connection. List states and transitions, then find the shortest path to any state that breaks a rule. Use when a bug looks like an ordering or concurrency problem."
---

# Statechart

Model the states and transitions, then search for the shortest sequence of events that reaches a state which must never happen.

## Steps

1. **List the states.** One line each, with the condition that makes the system be in it.
2. **List the events and transitions.** For each state, the events it accepts and the state each one leads to. Write unknown transitions as `UNDEFINED`, not as a guess.
3. **State the rules.** One line each, for example "a paid order is never shipped twice". A rule is a set of forbidden states or a forbidden order of events.
4. **Search for violations.** Walk every event sequence up to a depth you state, and report the shortest sequence that reaches a forbidden state. A script is better than a hand walk once there are more than about ten states.
5. **Fix the transition, not the symptom.** Change the transition that allows the bad sequence, then search again.
6. **Keep the model in the repository** at `.verify/statecharts/<name>.md`, so a later change can be checked against it.

## Skip when

- The system has no meaningful state, or fewer than three states.

## Sign you skipped this

A bug is fixed by adding a guard in one place, and no one checked whether another path reaches the same state.
