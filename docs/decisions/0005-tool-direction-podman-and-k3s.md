# 0005. Tool direction for future competencies: Podman over Docker, k3s over full Kubernetes

Date: 2026-08-09
Status: Accepted

## Context
While scoping Project 00, tool direction for later competencies (Containerized Application Packaging, Orchestration at Scale) came up. Deciding early, even loosely, avoids rework and keeps the roadmap coherent when those projects are actually reached.

## Decision
- **Podman** is the anticipated tool for Containerized Application Packaging — daemonless architecture (no persistent background service running as root, unlike Docker's client-server daemon), a better fit for a lighter-weight, security-conscious setup.
- **k3s** is the anticipated tool for Orchestration at Scale — a lightweight Kubernetes distribution purpose-built for resource-constrained environments like a Raspberry Pi, versus full upstream Kubernetes, which assumes more headroom than this hardware comfortably offers.

## Alternatives considered
- Docker — rejected; daemon-based architecture not preferred for this setup.
- Full Kubernetes (kubeadm) — rejected for initial learning; heavier resource footprint and more moving parts than needed to learn core orchestration concepts first.

## Consequences
This is a preference recorded ahead of the actual competency work — not binding. It can be revisited and superseded once hands-on experience with either tool provides real evidence for or against. Recorded now specifically so the reasoning isn't lost by the time those projects are actually scoped.
