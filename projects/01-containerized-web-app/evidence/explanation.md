# Explanation (in my own words)

_(Draft — revisit and rewrite in own words.)_

## Images vs containers

An image is a read-only template — a complete filesystem, built once from a Containerfile. A container is a running instance of that image with a thin writable layer on top. Anything changed at runtime lands in that layer, never in the image, which is why destroying and recreating a container resets it to the image's original state while a simple restart preserves changes.

## Why containers scale horizontally

Scaling containers doesn't mean making one bigger; it means running more identical copies. Because each container is isolated and derived from the same immutable image, instances are interchangeable — traffic can be spread across them and losing one doesn't affect the others. Demonstrated directly by running three instances and killing one.

## Containerfile

Same format as a Dockerfile, vendor-neutral name. `FROM` sets the base image, `COPY` brings files from the build context into the image, `EXPOSE` documents the port the app listens on inside the container. Port publishing actually happens at run time with `-p host:container`.
