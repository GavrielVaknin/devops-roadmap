# Explanation (in my own words)

The piece that proves I can teach this, not just perform it. Write as if explaining to someone who has never heard of this concept or tool. If it's not possible to explain simply here, that's a signal — not a failure, just information about where understanding is still thin.

Relevant terms used here should also exist in `GLOSSARY.md` — add or update entries there as needed.

---

## Idempotency (first draft — revisit once rested)

An idempotent task is one where running it once and running it ten times leaves the system in exactly the same state. Ansible's `package` module doesn't just "run an install command" — it first checks whether the package is already present, and only acts if it isn't. That's why running `baseline.yml` a second time showed `changed=0`: nothing was different from what the task already wanted, so nothing happened.

This matters because it means the same playbook can be run safely, repeatedly, without worrying about breaking something that's already correct — which is the entire point of configuration management over just running one-off shell commands.

One nuance learned today: not every task in a playbook is equally idempotent in *practice*. The Debian apt cache-refresh task reported `changed` even on the second run, because refreshing a package index is arguably always "a change" in some sense (new timestamp, possibly updated metadata) — even though the actual *install* task correctly settled to `changed=0`. So idempotency is really a property to check per-task, not something to assume applies uniformly across an entire playbook.

## Jinja2 templates, variables, and handlers (first draft — revisit once rested)

A Jinja2 template is a mostly-plain-text file with `{{ }}` placeholders that get substituted with real values before the file is used. Ansible's `template` module renders one of these per host, using both variables I define myself (`vars:`) and facts Ansible automatically gathers about each host (like `ansible_facts['os_family']`). This is why one shared template file (`motd.j2`) produced genuinely different content on Debian vs. Fedora — same file, different substituted values per machine.

A variable (`vars:`) is just a named container for a value, defined once and reused with `{{ name }}` anywhere else in the same play — avoids repeating the same list/value in multiple places.

A handler is a task that only runs if explicitly notified by another task, and only if that task actually reported a change. Confirmed directly: when the MOTD task changed something, the handler section appeared in the output; on a repeat run where nothing changed, the handler section was entirely absent, not just skipped-looking.
