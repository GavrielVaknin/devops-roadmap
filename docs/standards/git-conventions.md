# Git Conventions

## Commit messages — Conventional Commits

Format: `type(scope): summary`

Common types:
- `feat` — a new project, capability, or piece of functionality
- `fix` — correcting something that was wrong
- `docs` — documentation-only changes (journal entries, ADRs, README updates)
- `chore` — repo maintenance (skeleton setup, dependency bumps, structural changes)
- `refactor` — restructuring without changing behavior

Examples:
```
chore: initialize repo skeleton
docs(adr): record decision to name the repository devops-roadmap
docs(journal): 2026-08-10 session on project 00 scoping
feat(00-lab-foundations): initial ansible inventory for pi5 and thinkpad
```

## Branching

Solo learning repo — trunk-based (commit directly to `main`) is the default unless a specific project genuinely benefits from a working branch (e.g. an experiment that might get abandoned). If that becomes a recurring need, it's worth its own ADR rather than an ad-hoc habit.

## Numbering conventions

| Thing | Convention | Example |
|---|---|---|
| Project folders | `NN-kebab-case-name`, 2-digit zero-padded | `00-lab-foundations` |
| ADRs | `NNNN-kebab-case-title.md`, 4-digit, sequential, never reused | `0001-record-architecture-decisions.md` |
| Journal entries | `YYYY-MM-DD.md`, nested by year | `docs/journal/2026/2026-08-09.md` |

## What never gets force-pushed or rewritten

`main` history stays append-only once pushed to GitHub. If something needs correcting, correct it forward (a new commit, or a superseding ADR) — don't rewrite history to hide a mistake. The mistake and the correction are both part of the record.
