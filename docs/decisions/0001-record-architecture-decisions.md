# 0001. Record architecture decisions

Date: 2026-08-09
Status: Accepted

## Context
Over the course of this project, real judgment calls will get made — tool choices, structural changes, tradeoffs. Six months from now, "I chose X" without the reasoning behind it is close to useless: it can't be evaluated, defended, or revisited responsibly. This is also true for anyone else reading the repo.

## Decision
Every non-trivial decision gets recorded as an Architecture Decision Record (ADR) in `docs/decisions/`, using the standard Michael Nygard format (Context / Decision / Alternatives / Consequences). ADRs are numbered sequentially, never renumbered, and never edited after acceptance — if a decision changes, a new ADR supersedes the old one and both stay in the history.

## Alternatives considered
- No formal record, relying on git commit messages and memory — rejected, this is exactly the failure mode ADRs exist to prevent.
- A single running `DECISIONS.md` log — rejected in favor of one-file-per-decision, since it makes individual decisions linkable from project READMEs and makes supersession explicit rather than just another line in a long file.

## Consequences
Every future decision has a small amount of overhead (writing the ADR) in exchange for the decision being traceable, defensible, and revisitable later without reconstructing the reasoning from memory.
