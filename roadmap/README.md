# Roadmap

This is the index for the roadmap layer. It exists to make one relationship real and navigable, not just a diagram in someone's head:

```
Competency
    ↓
Learning Objective
    ↓
Project
    ↓
Implementation
    ↓
Evidence
    ↓
Next Competency
```

## What each file is for

- **[`competency-map.md`](competency-map.md)** — the capabilities I'm trying to build, independent of any specific tool. A competency is something you can *do*, not a technology you've heard of.
- **[`learning-objectives.md`](learning-objectives.md)** — specific, assessable statements under each competency. Answers "how would I actually know I learned this, not just ran it once."
- **[`project-dependencies.md`](project-dependencies.md)** — the sequencing graph: which projects depend on which, and which competencies each one builds toward.

## Why competencies, not a technology list

Ansible, Terraform, k3s, Podman — these are tools someone might use to build a competency, not the competencies themselves. Freezing a tech sequence early risks turning this into a certification checklist rather than a genuine record of judgment. Tools get selected once a competency and its objectives are clear, not before.

## Current status

The schema above is settled. The actual competency and objective content is not yet written — that's deliberate: it's substantive learning content, not something to rush as a byproduct of setting up folders. See `competency-map.md` for the format and a worked example to fill in against.
