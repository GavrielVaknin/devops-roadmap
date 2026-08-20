# 0009. Restructure the baseline playbook into an Ansible role

Date: 2026-08-20
Status: Accepted

## Context
Project 00's configuration work lived in a single flat `baseline.yml` with an INI inventory and inline variables. It worked and was proven idempotent, but it did not resemble how Ansible is organised in practice: roles are the standard unit of reuse, and real codebases separate variables, tasks, handlers, and templates by convention rather than keeping everything in one file.

Separately, the inventory contained hardcoded IP addresses. libvirt assigns VM addresses by DHCP, so these went stale on every VM rebuild — a problem already hit more than once.

## Decision
Restructure into a standard Ansible role (`roles/baseline/`) with `defaults/`, `vars/`, `tasks/`, `handlers/`, `templates/`, and `meta/`. Add a project-local `ansible.cfg`, a thin `site.yml` entry point that only maps hosts to roles, and `group_vars/` for group-scoped variable overrides.

Replace the hardcoded inventory with `scripts/geninventory.sh`, which queries libvirt at runtime and generates the inventory from whatever VMs are actually running. The generated file is gitignored — it is disposable output, not source.

## Alternatives considered
- **Keep the flat playbook.** Rejected: it works, but teaches a structure that doesn't match anything encountered professionally.
- **Static IP assignment via DHCP reservations by MAC.** Considered and rejected in favour of runtime lookup — looking addresses up rather than pinning them is the pattern used against cloud providers, where instances are ephemeral and addresses are never assumed.

## Consequences
Task logic is split across several small files instead of one readable list, which is a real cost in navigability traded for conventional structure and reusability. Tags now allow running subsets (`--tags motd`).

The inventory must be regenerated after any VM rebuild. This is a deliberate extra step, chosen over an inventory that silently goes wrong.
