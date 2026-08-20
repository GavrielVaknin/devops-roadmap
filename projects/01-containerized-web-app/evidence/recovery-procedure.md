# Recovery Procedure

How each failure from `failure-test.md` was recovered, and whether the procedure was actually exercised.

## Procedure

**A stopped or destroyed container**

1. Confirm what is actually running: `podman ps -a` (`-a` includes stopped containers).
2. Restart an existing container with `podman start <name>`, or recreate it with the original `podman run` invocation.
3. Verify by request, not by status: `curl -s http://localhost:<port>`.

Because the image is immutable, a recreated container is byte-identical to the original. There is nothing to repair — only to run again.

**Unwanted modification inside a container**

`podman rm -f <name>` followed by `podman run ...`. Destroying the container discards its writable layer, and the new one starts from the unmodified image. This is only safe for a **stateless** container; anything holding data that must survive belongs in a volume first.

**A volume mounted over content that should not have been hidden**

Nothing is damaged. Remove the container, correct or drop the `-v` argument, and run again. The image content reappears once nothing is mounted over it.

## Was this tested?

**Yes** — all three paths were executed and verified by `curl` on 2026-08-19 and 2026-08-20.

## Time to recover

Seconds. A single `podman run` in each case.

## Notes

Recovery here is *replacement*, not repair — the opposite of Project 00, where recovery meant reapplying desired state to an existing machine. Both reduce to "assert the intended state again," but a container achieves it by being thrown away and rebuilt from an immutable image.

The significant limitation is that every step above is manual. Nothing detects the failure and nothing performs the recovery. That is the boundary of what a container runtime alone provides.
