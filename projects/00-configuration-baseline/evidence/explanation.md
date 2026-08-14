# Explanation (in my own words)

The piece that proves I can teach this, not just perform it. Write as if explaining to someone who has never heard of this concept or tool. If it's not possible to explain simply here, that's a signal — not a failure, just information about where understanding is still thin.

Relevant terms used here should also exist in `GLOSSARY.md` — add or update entries there as needed.

---

## Idempotency (first draft — revisit once rested)

An idempotent task is one where running it once and running it ten times leaves the system in exactly the same state. Ansible's `package` module doesn't just "run an install command" — it first checks whether the package is already present, and only acts if it isn't. That's why running `baseline.yml` a second time showed `changed=0`: nothing was different from what the task already wanted, so nothing happened.

This matters because it means the same playbook can be run safely, repeatedly, without worrying about breaking something that's already correct — which is the entire point of configuration management over just running one-off shell commands.

One nuance learned today: not every task in a playbook is equally idempotent in *practice*. The Debian apt cache-refresh task reported `changed` even on the second run, because refreshing a package index is arguably always "a change" in some sense (new timestamp, possibly updated metadata) — even though the actual *install* task correctly settled to `changed=0`. So idempotency is really a property to check per-task, not something to assume applies uniformly across an entire playbook.
