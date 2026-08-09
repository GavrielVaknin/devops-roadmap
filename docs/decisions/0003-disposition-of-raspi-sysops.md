# 0003. Disposition of the existing raspi-sysops repository

Date: 2026-08-09
Status: Proposed

## Context
An existing GitHub repository, `raspi-sysops`, contains earlier bash scripts with little documentation. It predates this project's standards and is not currently satisfying as a portfolio piece. Three options were identified:

- **A — Archive with a pointer.** Leave it untouched, add a line to its README pointing here, reference it from an ADR in this repo. Minimal effort, nothing lost or hidden.
- **B — Migrate into `archive/raspi-sysops-legacy/`.** Pull the old scripts in, write one retroactive README explaining what it was and what would be done differently now. Shows growth explicitly, more work.
- **C — Retroactively document as Project 00.** Treat it as the real first building block, backfilled against the current project template.

## Decision
Not yet made. This ADR is left in `Proposed` status deliberately, so the open decision is visible rather than silently deferred or silently assumed. Recommendation on record: Option A now, with the option to revisit as Option B later if the growth-story effect is wanted for a portfolio audience — but this is explicitly the repo owner's call, not decided here.

## Alternatives considered
See the three options above.

## Consequences
Until this is resolved, `raspi-sysops` sits outside this repository with no link between them. Not currently blocking anything else in the roadmap.
