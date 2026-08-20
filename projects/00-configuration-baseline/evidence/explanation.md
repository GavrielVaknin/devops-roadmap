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

## Roles, and what the refactor taught (2026-08-20)

The flat playbook was restructured into a standard Ansible role. Structure replaces configuration: Ansible auto-loads `main.yml` from each of `defaults/`, `vars/`, `tasks/`, `handlers/`, and `meta/`, and resolves `template: src=motd.j2` to `roles/<role>/templates/motd.j2` without any path being written anywhere. Learning the convention is what removes the need to configure paths at all.

`defaults/` and `vars/` both hold variables but differ in precedence: `defaults/` is the lowest priority and exists to be overridden by whoever uses the role, `vars/` is high priority and holds role internals not meant to be changed from outside. Getting these the wrong way round is a common mistake.

### Problems hit during the refactor, and what they were really about

**Deprecated configuration.** `stdout_callback = yaml` was removed in `community.general` 12.0.0 and replaced by `callback_result_format = yaml` on the builtin callback. The error message named its own replacement — worth reading error output before searching. Ansible deprecates aggressively; config that was correct a couple of releases ago frequently isn't.

**Retries misapplied.** `retries` / `until` were added to the package install task. They belong on genuinely transient failures — a flaky mirror, a dropped connection — not on a deterministic one. "Package not found in an empty index" fails identically every time, so retrying only delayed the real error and buried it under retry noise.

**A previously-solved problem reintroduced.** The Debian install failed under `--check` because a freshly provisioned host has an empty package index, and check mode does not actually perform the cache refresh that would populate it. This exact failure had been diagnosed earlier against the flat playbook, and the understanding was not carried into the rewrite. The proper fix is `check_mode: false` on the cache-refresh tasks, so they run for real even during a dry run — safe, because refreshing an index changes no state that matters, and it makes the subsequent dry-run check meaningful rather than a false negative.

The general lesson is about refactors rather than Ansible: a rewrite is usually cleaner than what it replaces, and quietly drops the accumulated fixes the messy version had earned. Worth checking what is being discarded, not just what is being improved.

**Change reporting made honest.** `changed_when: false` was added to both cache-refresh tasks. An apt cache update reports `changed` on nearly every run, which — repeated often enough — trains you to ignore the `changed` column entirely. Reserving `changed` for genuine state changes keeps it a usable signal.

### Known, unresolved noise

Fedora hosts emit `[WARNING]: Module invocation had junk after the JSON data:` on most tasks. Ansible's module parser filters output appearing after the JSON payload and warns when it finds any, on the reasoning that trailing junk usually indicates something worth changing. There is an open upstream issue (ansible/ansible#86122) describing this exact behaviour on Fedora Cloud images when using privilege escalation, where the warning disappears if `become` is not used.

This is cosmetic, originates upstream rather than in this role, and is recorded here so it is recognised as known noise rather than re-investigated later.
