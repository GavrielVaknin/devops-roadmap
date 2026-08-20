# Deployment Log

## Deployment record

| Date | What was deployed | Where | Result |
|---|---|---|---|
| 2026-08-19 | `devops-roadmap-web:v1` — static HTML served by nginx:alpine, built from a Containerfile | ThinkPad, Podman 5.7.0 rootless | Success — image built, container ran, served correctly on mapped port |

## Horizontal scaling demonstration

Three instances (`web-1`, `web-2`, `web-3`) of the same image run simultaneously on ports 8080/8081/8082. Stopping `web-2` confirmed the other two continued serving unaffected — instance-level resilience on a single host, no orchestrator involved.

## Stateless / stateful demonstration

Modified `index.html` inside a running container via `podman exec`, then:
- `podman restart` → change **survived** (same container, same writable layer)
- `podman rm -f` + `podman run` → change **gone**, original image content restored

Confirms the image is immutable and container changes live only in an ephemeral writable layer. This is why volumes exist for data that must persist, and why a stateless app is trivially replaceable.
