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

## Volumes and bind mounts — 2026-08-20

Four storage behaviours demonstrated directly, each verified by curl rather than assumed:

| Approach | Survives restart | Survives `rm` + recreate | Editable live from host |
|---|---|---|---|
| Image layer (`COPY`) | Yes | Yes (resets to image content) | No — requires rebuild |
| Container writable layer | Yes | No | No |
| Named volume (`-v name:/path`) | Yes | Yes | Only via the container |
| Bind mount (`-v /host/path:/path`) | Yes | Yes | Yes |

**Named volume:** wrote content into a mounted volume, destroyed the container entirely with `podman rm -f`, created a different container against the same volume — content survived. Confirms volumes exist independently of any container lifecycle.

**Shared volume:** a second container mounted the same volume and served identical content, confirming volumes can back multiple containers simultaneously.

**Bind mount:** mounted the repo's `app/` directory read-only into a container. Editing `index.html` on the host changed what the running container served immediately, with no rebuild and no restart — the development workflow, as opposed to the baked-in `COPY` used for the built image.

**Incidental observation:** a typo'd `-v webdata:...` silently auto-created an empty volume rather than erroring. Worth knowing — `-v` creates on demand, so a mistyped volume name produces an empty mount that looks like data loss rather than an obvious failure. This exact confusion occurred during the session and was diagnosed by comparing volume names.

Mounting a volume over a directory hides whatever the image had at that path; the image content is not deleted, only obscured while mounted. Volumes must mount to a directory path, not a single file.
