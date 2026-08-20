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

Requires Podman (`sudo apt install -y podman`), rootless.

```bash
cd projects/01-containerized-web-app

# build
podman build -t devops-roadmap-web:v1 .

# run one instance
podman run -d --name web-1 -p 8080:80 devops-roadmap-web:v1
curl -s http://localhost:8080

# horizontal scaling: three instances of the same image
podman run -d --name web-2 -p 8081:80 devops-roadmap-web:v1
podman run -d --name web-3 -p 8082:80 devops-roadmap-web:v1
podman stop web-2          # the other two keep serving

# bind mount: edit app/index.html on the host and see it served immediately
podman run -d --name web-bind -p 8084:80 \
  -v "$(pwd)/app:/usr/share/nginx/html:ro,Z" devops-roadmap-web:v1

# clean up
podman rm -af
```

## Evidence

- **Code** — [`Containerfile`](Containerfile), [`app/index.html`](app/index.html)
- **Deployment record** — [`evidence/deployment-log.md`](evidence/deployment-log.md)
- **Failure test** — [`evidence/failure-test.md`](evidence/failure-test.md)
- **Recovery procedure** — [`evidence/recovery-procedure.md`](evidence/recovery-procedure.md)
- **Explanation in my own words** — [`evidence/explanation.md`](evidence/explanation.md)
- **ADRs** — 0005 (Podman over Docker), 0008 (ThinkPad as lab)

**Deliberately not produced:** an architecture diagram, and an automated test. Both are real gaps rather than reasoned omissions, and are noted here rather than left silent.

## What I learned

An image is an immutable template; a container is a running instance of it with a thin writable layer on top. That single distinction predicts every storage behaviour observed here, and was verified rather than assumed — restart preserves the writable layer, destroy-and-recreate discards it, a volume outlives both.

Scaling containers means running more identical copies, not enlarging one. Three instances of the same image served concurrently, and stopping one left the others untouched — horizontal scaling and instance-level resilience demonstrated on a single machine, without an orchestrator and without additional hardware.

The clearest limitation found: nothing here notices or reacts to failure. Every recovery was a command typed by hand. A container runtime provides isolation and packaging; it does not provide health checking, restart policy, or scheduling. That gap is the actual argument for orchestration, arrived at by hitting it rather than by being told.

## What this unlocks
Orchestration at Scale (k3s across multiple VMs) — a container image is the artifact an orchestrator schedules, so this project produces the thing Project 02 will manage.
