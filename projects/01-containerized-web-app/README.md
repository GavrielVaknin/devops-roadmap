# 01 — Containerized Web App

## Status
See [`docs/status-log.md`](docs/status-log.md).

## Competency & Learning Objective
Competency: **Containerized Application Packaging** (`roadmap/competency-map.md`).
Objectives: see `roadmap/learning-objectives.md`, "Containerized Application Packaging".

## Goal
Package a simple static web app into a container image with Podman, run it, run multiple instances of it simultaneously, and understand what a container actually is at a mechanical level — not just which commands to type.

## Why this matters (enterprise relevance)
Containers are the default unit of deployment in most modern environments. Understanding how an application gets packaged, how instances are isolated, how data persists or doesn't, and how multiple copies run side by side is the foundation everything in orchestration is built on.

## Prerequisites
- Project 00 (configuration baseline) — established the working practice of tested, version-controlled infrastructure work.

## Scope

### In scope
- Podman installed and working on the ThinkPad, rootless
- A minimal static web app (HTML), written in this repo
- A `Containerfile` that builds it into an image
- Running the container, mapping ports, reaching it from the host
- Running **multiple instances simultaneously** — horizontal scaling on a single machine
- Volumes: understanding stateless vs. stateful containers
- Deliberately killing a container and observing behaviour

### Out of scope
- Orchestration (k3s) — deferred to Project 02
- CI/CD or automated builds — later project
- Multi-node / physical redundancy — needs multiple k3s nodes, deferred
- Deploying to the Raspberry Pi 5 — the ThinkPad is the lab for this project (see ADR 0008)

## Architecture / decisions
- ADR 0005 — Podman over Docker (daemonless)
- ADR 0008 — ThinkPad as the primary lab environment

## How to reproduce
_(to fill in as the project progresses)_

## Evidence
_(to fill in — see `docs/standards/evidence-standards.md`)_

## What I learned
_(to fill in)_

## What this unlocks
Orchestration at Scale (k3s across multiple VMs) — a container image is the artifact an orchestrator schedules, so this project produces the thing Project 02 will manage.
