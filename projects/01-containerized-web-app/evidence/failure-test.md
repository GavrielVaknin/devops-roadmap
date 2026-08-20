# Failure Test

Deliberately breaking this, and recording what actually happened.

Date: 2026-08-19 – 2026-08-20
Target: containers built from `devops-roadmap-web:v1` on the ThinkPad

## What was broken, and how

Three separate failure modes, chosen because each exercises a different property:

1. **Stopped one instance of three** — `podman stop web-2`, while `web-1` and `web-3` continued serving on their own ports.
2. **Modified a file inside a running container** — overwrote `/usr/share/nginx/html/index.html` via `podman exec`, then restarted the container, then destroyed and recreated it.
3. **Mounted a volume over a populated directory** — mounted an empty named volume at the path the image already had content at.

## What actually happened

**Instance loss.** `podman ps` no longer listed the stopped container and its port returned nothing. Both remaining instances kept serving normally, verified by `curl`. Instances derived from the same image are independent; losing one does not degrade the others.

**Modification, then restart.** The change survived. A restart stops and starts the *same* container, and its writable layer persists across that.

**Modification, then destroy and recreate.** The change was gone and the original image content was back. A new container gets a new, empty writable layer; the image itself was never modified.

**Volume over a populated directory.** The image's `index.html` disappeared from what nginx served. The file was not deleted — it was obscured while the volume was mounted at that path. This is worth recording because it presents as data loss and is not.

## Detection

Detection was manual and immediate, since every failure was deliberate. Worth stating plainly: there is **no automated health checking** here. Nothing would notice a stopped container, and nothing would restart it. That is precisely the gap an orchestrator closes, and is a large part of the argument for Project 02.

## Incidental finding

A mistyped volume name in `-v` silently created a new, empty volume rather than erroring. The resulting empty mount looked exactly like data loss. Diagnosed by comparing `podman volume ls` output against the name actually used.

Worth internalising: `-v` creates on demand, so a typo produces a plausible-looking wrong result rather than a clear failure.
