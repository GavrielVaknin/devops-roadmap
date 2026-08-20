# Learning Objectives

Objectives are specific and assessable. They exist to turn a vague competency into something I can honestly check off — not "I ran a command once" but something closer to "I can explain X, and I can recover from Y failure without looking it up."

## Format

```markdown
## Competency: [name]

### LO-001: [specific, testable statement]
- **Assessment:** how I'd know this is genuinely met
- **Related project(s):** [links]
- **Status:** Not Started | In Progress | Met | Superseded
```

Objectives are not rewritten when they turn out to be wrong. They are marked `Superseded`, with a note explaining what changed — the same convention the ADRs follow.

---

## Competency: Configuration Consistency

### LO-001: I can write an idempotent playbook that brings a fresh machine to a defined baseline state, and re-running it produces no changes.
- **Assessment:** Run it twice against a test VM; second run reports zero changes.
- **Related project(s):** [projects/00-configuration-baseline/](../projects/00-configuration-baseline/)
- **Status:** **Met** — 2026-08-13, and re-proven after the role restructure on 2026-08-20. Three consecutive runs recorded in `evidence/deployment-log.md`; third run reported `changed=0` on both hosts.

### LO-002: I can maintain a version-controlled inventory covering both the Pi 5 and the ThinkPad.
- **Status:** **Superseded** — 2026-08-20.
- **Why:** wrong on both counts. ADR 0008 set the Pi 5 aside and moved lab work to disposable VMs, so neither of those machines is a managed target. ADR 0009 then replaced the hand-maintained inventory with one generated at runtime by `scripts/geninventory.sh` and deliberately gitignored, because DHCP-assigned addresses make a committed inventory wrong by default.
- **Replaced by:** LO-005.

### LO-003: I can validate a configuration change against a disposable test VM before applying it to real hardware, and explain why that matters.
- **Assessment:** A documented test-VM run precedes every real-hardware apply; explanation in own words exists in evidence/explanation.md.
- **Related project(s):** [projects/00-configuration-baseline/](../projects/00-configuration-baseline/)
- **Status:** **Met** — the methodology (ADR 0004) has been followed throughout, and `evidence/failure-test.md` records a real near-miss where a destructive command was nearly run against the daily-driver machine instead of the VM. That is the risk the methodology exists to contain, observed rather than hypothesised.

### LO-004: I can explain, in my own words, what idempotency means and how it differs from just running a script once.
- **Assessment:** Written explanation, without referring to source material while writing it.
- **Related project(s):** [projects/00-configuration-baseline/](../projects/00-configuration-baseline/)
- **Status:** **Met** — `evidence/explanation.md`, including the nuance that idempotency is a per-task property rather than a whole-playbook one, observed directly when the apt cache task reported `changed` while the install task settled correctly.

### LO-005: I can generate an inventory at runtime from the actual state of the environment, and explain why that is preferable to a hand-maintained one.
- **Assessment:** Inventory is produced by tooling rather than edited; the reasoning is recorded in an ADR.
- **Related project(s):** [projects/00-configuration-baseline/](../projects/00-configuration-baseline/), `scripts/geninventory.sh`
- **Status:** **Met** — 2026-08-20, ADR 0009.

### LO-006: I can restructure a working playbook into a conventional Ansible role and explain what the structure buys.
- **Assessment:** Role follows the standard layout; the playbook still passes its idempotency check afterwards; the trade-offs are written down.
- **Related project(s):** [projects/00-configuration-baseline/](../projects/00-configuration-baseline/)
- **Status:** **Met** — 2026-08-20, ADR 0009. Re-validated after the change rather than assuming the previous result carried over.

---

## Competency: Containerized Application Packaging

### LO-007: I can write a Containerfile that builds an application into an image, and explain each instruction in it.
- **Assessment:** Image builds and runs; `FROM`, `COPY`, and `EXPOSE` can each be explained, including why `EXPOSE` does not itself publish a port.
- **Related project(s):** [projects/01-containerized-web-app/](../projects/01-containerized-web-app/)
- **Status:** **Met** — 2026-08-19.

### LO-008: I can explain the difference between an image and a container, and predict what survives a restart versus a destroy-and-recreate.
- **Assessment:** Predict the outcome before running the commands, then verify.
- **Related project(s):** [projects/01-containerized-web-app/](../projects/01-containerized-web-app/)
- **Status:** **Met** — demonstrated by modifying a file inside a running container, restarting it (change survived), then destroying and recreating it (change gone, image content restored).

### LO-009: I can run multiple instances of one image simultaneously and show that losing one does not affect the others.
- **Assessment:** Several instances serving concurrently; one stopped; the rest verified still serving.
- **Related project(s):** [projects/01-containerized-web-app/](../projects/01-containerized-web-app/)
- **Status:** **Met** — three instances on separate ports; stopping one left the other two unaffected.

### LO-010: I can choose correctly between a named volume, a bind mount, and baking content into the image, and say why for each.
- **Assessment:** All three behaviours demonstrated and their differences recorded.
- **Related project(s):** [projects/01-containerized-web-app/](../projects/01-containerized-web-app/)
- **Status:** **Met** — recorded as a comparison table in `evidence/deployment-log.md`.

### LO-011: I can express a container deployment declaratively rather than as typed commands.
- **Assessment:** The running configuration exists as a committed file rather than shell history.
- **Related project(s):** [projects/01-containerized-web-app/](../projects/01-containerized-web-app/)
- **Status:** **Not Started** — the current gap. Everything so far has been imperative `podman run` invocations; a Compose file or Kubernetes manifest is the missing artefact, and is the natural bridge into orchestration.
