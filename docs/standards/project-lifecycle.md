# Project Lifecycle

Nine states, because a project can be "complete" as a learning exercise while the system it produced is still running in production on the lab — those are different facts and worth tracking separately.

## States

| State | Meaning |
|---|---|
| Idea | Noted somewhere (roadmap, journal) but not scoped |
| Proposed | Has a draft README / scope, not yet reviewed against dependencies |
| Approved | Checked against `roadmap/project-dependencies.md` and it's next in sequence |
| Planned | Scope, prerequisites, and evidence targets are locked |
| In Progress | Actively being built |
| Validation | Built, now being tested against its own evidence standards |
| Complete | Evidence set is satisfied; the learning exercise is done |
| Operational | The resulting system is still running / in active use — can persist long after Complete |
| Retired / Superseded | No longer running, or replaced — link to what superseded it, same spirit as ADR supersession |

## Tracking transitions, not just current state

Each project has `docs/status-log.md`, appended to every time the state changes:

```markdown
| Date | From | To | Note |
|---|---|---|---|
| 2026-08-10 | Idea | Proposed | Initial scope drafted |
```

A single "current status" field can't answer "when did this actually become operational, and for how long" — the log can.
