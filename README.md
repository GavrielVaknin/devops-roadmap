# devops-roadmap

An evidence-based record of learning Infrastructure as Code and DevOps practice, built on real hardware I own and operate: a Raspberry Pi 5 (AlmaLinux) and a Lenovo ThinkPad (Ubuntu).

This is not a curated list of links or a study plan. Every project in this repository is something actually built, on actual machines, with the reasoning, the evidence it works, and what was learned along the way documented as it happened — not reconstructed afterward.

## Why this repo exists

The goal is to reach a working, enterprise-relevant understanding of Infrastructure as Code — the kind of judgment a DevOps engineer applies day to day — through building real, working systems, and to document that process rigorously enough that a stranger with zero context, or myself in six months, can understand exactly what was built, why, and what was actually learned.

## How this repo is organized

```
Competency → Learning Objective → Project → Implementation → Evidence → Next Competency
```

That chain is the spine of the repo. Start at [`roadmap/README.md`](roadmap/README.md) to understand it properly before digging into individual projects.

| Path | What's there |
|---|---|
| [`roadmap/`](roadmap/) | What I'm trying to become capable of, and why — competencies, objectives, and how projects depend on each other |
| [`docs/decisions/`](docs/decisions/) | Architecture Decision Records — the reasoning behind non-obvious choices, kept even after they're superseded |
| [`docs/journal/`](docs/journal/) | Dated, professional learning log — what I did, what I actually learned, in my own words |
| [`docs/environment/`](docs/environment/) | Current-state facts about the hardware and network this all runs on |
| [`docs/standards/`](docs/standards/) | The house rules this repo follows — documentation format, git conventions, project lifecycle, what counts as evidence |
| [`projects/`](projects/) | The building blocks — each one self-contained, each one provable |
| [`archive/`](archive/) | Superseded work, kept rather than deleted |

## Status

This repository is in its earliest state: the structure exists, the standards are written, the competency map is not yet filled in. See [`roadmap/README.md`](roadmap/README.md) for what comes next.

## License

MIT — see [`LICENSE`](LICENSE).
