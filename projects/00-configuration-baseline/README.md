# 00 — Configuration Baseline

## Status
See [`docs/status-log.md`](docs/status-log.md) for current state and full history.

## Competency & Learning Objective
Competency: **Configuration Consistency** (`roadmap/competency-map.md`), building on **Declarative, Version-Controlled System State**.
Objectives: LO-001 through LO-004 in `roadmap/learning-objectives.md`.

## Goal
Bring both machines I own — the Raspberry Pi 5 (AlmaLinux) and the ThinkPad (Ubuntu) — under version-controlled, idempotent configuration management, so their state is defined in code rather than remembered by hand.

## Why this matters (enterprise relevance)
Every real DevOps environment manages fleets of machines this way — configuration drift between servers is one of the most common causes of "works on one box, breaks on another." Learning to define and enforce consistent state, safely, is foundational to everything after it.

## Prerequisites
- SSH access to both machines (already documented in `docs/environment/access.md`)

## Scope

### In scope
- A version-controlled inventory covering both machines
- An idempotent baseline configuration (packages, users, basic hardening — exact contents to be decided during implementation)
- A disposable test-VM methodology: every change is validated against a throwaway VM before being applied to either real machine (see ADR 0004)
- A deliberate failure test and recovery procedure once the baseline is applied

### Out of scope
- Kubernetes / k3s / container orchestration — deferred to a later Orchestration at Scale project
- Podman / container packaging — deferred to a later Containerized Application Packaging project
- Terraform / provisioning — no infrastructure exists yet to provision; deferred to Reproducible Provisioning
- Any GUI-based configuration tooling — CLI/code only, consistent with this repo's IaC approach

## Architecture / decisions
- ADR 0004 — test-before-apply methodology
- ADR 0005 — tool direction for later competencies (Podman, k3s), recorded now for continuity

## Scope amendment (2026-08-20)

The Goal above, as originally written, was to bring the Raspberry Pi 5 and the ThinkPad themselves under configuration management. **That did not happen, and is no longer the intent.**

ADR 0008 moved lab work to the ThinkPad and deliberately left the Pi 5 idle without an assigned role. In practice the baseline has only ever been applied to disposable test VMs (Debian and Fedora), which is where it remains useful — the VMs stand in for the two real package families rather than for the two specific machines.

The original goal is left in place above rather than rewritten, so the change of direction is visible rather than hidden. LO-002 in `roadmap/learning-objectives.md` has been superseded for the same reason.

## How to reproduce

Requires the virtualisation stack (see `scripts/README.md` for one-time host setup).

```bash
# from the repository root
./scripts/newvm.sh debian debian-test-1
./scripts/newvm.sh fedora fedora-test-1 2048
./scripts/geninventory.sh

cd projects/00-configuration-baseline/ansible
ansible-playbook site.yml --check    # dry run
ansible-playbook site.yml            # apply
ansible-playbook site.yml            # re-run: expect changed=0
```

No `-i` flag is needed — `ansible.cfg` points at the generated `inventory.yml`. Run subsets with `--tags packages` or `--tags motd`.

Tear down with `./scripts/rmvm.sh debian-test-1 fedora-test-1`.

## Evidence

- **Code** — `ansible/` (role, `site.yml`, `ansible.cfg`, `group_vars/`)
- **Deployment record** — [`evidence/deployment-log.md`](evidence/deployment-log.md)
- **Failure test** — [`evidence/failure-test.md`](evidence/failure-test.md)
- **Recovery procedure** — [`evidence/recovery-procedure.md`](evidence/recovery-procedure.md)
- **Explanation in my own words** — [`evidence/explanation.md`](evidence/explanation.md)
- **Idempotency proof** — three consecutive runs recorded in the deployment log; third run reports `changed=0`
- **ADRs** — 0004, 0005, 0007, 0009

**Deliberately not produced:** an architecture diagram, and an automated test beyond the idempotency re-run. The diagram is a real gap. A separate automated test was judged redundant here, because the idempotent re-run *is* the verification — asserting the desired state and asserting nothing changed are the same operation for a declarative tool.

## What I learned

Idempotency as a demonstrated property rather than a claim: a second identical run reporting `changed=0` is the proof, and it is checked per-task rather than assumed across a whole playbook. Cross-distribution logic through `ansible_facts['os_family']`, which groups by lineage rather than by distribution name. The real limits of dry-run mode, and `check_mode: false` as the correct fix when one task must actually run for a later task's check to mean anything. That the recovery procedure and the normal procedure are the same command, which is the practical payoff of a declarative baseline.

Fuller detail in [`evidence/explanation.md`](evidence/explanation.md) and the dated journal entries.

## What this unlocks
Containerized Application Packaging (Podman), and eventually Orchestration at Scale (k3s) — both need a consistently configured base to build on.
