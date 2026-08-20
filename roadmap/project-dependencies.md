# Project Dependencies

The sequencing graph. Unlike the ADRs, this file is meant to be edited constantly as the map firms up — it's a working document, not a historical record.

## Table

| Project | Depends on (projects) | Builds toward (competencies) | Status |
|---|---|---|---|
| 00-configuration-baseline | — | Configuration Consistency (builds on Declarative, Version-Controlled System State) | In Progress |
| 01-containerized-web-app | 00-configuration-baseline | Containerized Application Packaging | In Progress |
| 02 — orchestration (not yet scoped) | 01-containerized-web-app | Orchestration at Scale | Idea |

## Notes

- A project should not be marked "Approved" (see `docs/standards/project-lifecycle.md`) until its row here has real entries, not placeholders.
- Dependencies are between competencies and projects, not a fixed tool order — see `competency-map.md` for why.
- `scripts/` is not a project. It is repo-wide tooling that grew out of Project 00 and is now used by both projects; its evidence is linked from the Scripting & Automation Fluency competency.
