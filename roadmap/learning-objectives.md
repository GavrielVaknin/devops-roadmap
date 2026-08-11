# Learning Objectives

Objectives are specific and assessable. They exist to turn a vague competency into something I can honestly check off — not "I ran a command once" but something closer to "I can explain X, and I can recover from Y failure without looking it up."

## Format

```markdown
## Competency: [name]

### LO-001: [specific, testable statement]
- **Assessment:** how I'd know this is genuinely met
- **Related project(s):** [links]
- **Status:** Not Started | In Progress | Met
```

---

## Example (illustrative only — replace or remove)

## Competency: Declarative, Version-Controlled System State

### LO-000: I can explain the difference between a tool that continuously reconciles state (e.g. a Kubernetes controller, Argo CD) and one that converges state on-demand when invoked (e.g. an Ansible playbook run), and say why that distinction matters operationally.
- **Assessment:** Written explanation in GLOSSARY.md or a journal entry, in my own words, without referring back to source material while writing it.
- **Related project(s):** TBD
- **Status:** Not Started

---

<!-- Real objectives go below this line. -->

## Competency: Configuration Consistency

### LO-001: I can write an idempotent playbook that brings a fresh machine to a defined baseline state, and re-running it produces no changes.
- **Assessment:** Run it twice against a test VM; second run reports zero changes.
- **Related project(s):** projects/00-configuration-baseline/
- **Status:** Not Started

### LO-002: I can maintain a version-controlled inventory covering both the Pi 5 and the ThinkPad.
- **Assessment:** Inventory file exists in git, accurately lists both machines.
- **Related project(s):** projects/00-configuration-baseline/
- **Status:** Not Started

### LO-003: I can validate a configuration change against a disposable test VM before applying it to real hardware, and explain why that matters.
- **Assessment:** A documented test-VM run precedes every real-hardware apply; explanation in own words exists in evidence/explanation.md.
- **Related project(s):** projects/00-configuration-baseline/
- **Status:** Not Started

### LO-004: I can explain, in my own words, what idempotency means and how it differs from just running a script once.
- **Assessment:** Written explanation, in GLOSSARY.md or evidence/explanation.md, without referring to source material while writing it.
- **Related project(s):** projects/00-configuration-baseline/
- **Status:** Not Started
