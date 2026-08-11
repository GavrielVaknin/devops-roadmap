# 00 — Configuration Baseline

## Status
See [`docs/status-log.md`](docs/status-log.md). Currently: Proposed.

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

## How to reproduce
_(to fill in once implementation starts)_

## Evidence
_(to fill in — see `docs/standards/evidence-standards.md`; expect: inventory + playbook code, an idempotency test, a deployment log, a failure test + recovery procedure, an explanation in my own words)_

## What I learned
_(to fill in)_

## What this unlocks
Containerized Application Packaging (Podman), and eventually Orchestration at Scale (k3s) — both need a consistently configured base to build on.
