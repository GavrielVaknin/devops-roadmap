# Failure Test

Deliberately breaking this, and recording what actually happened. See `docs/standards/evidence-standards.md` for why this matters and the SRE Book postmortem template it's informed by.

Date: 2026-08-19
Target: `debian-test-1` (Fedora deliberately left untouched, as a control)

## What was broken, and how

Two genuinely different kinds of damage, chosen to test two different recovery paths:

1. **Removed a managed package** — `sudo apt remove -y htop`
2. **Deleted a managed config file** — `sudo rm -rf /etc/motd`

`fedora-test-1` was deliberately left alone, so the playbook run afterward would show whether recovery is targeted (only repairs what actually drifted) or indiscriminate (reapplies everything everywhere).

## What actually happened

Damage confirmed on the VM before attempting recovery, not assumed:
- `which htop` returned nothing
- `cat /etc/motd` returned "No such file or directory"

Recovery was a plain re-run of `baseline.yml`, with no special flags, no manual intervention, and no changes to the playbook:

- `debian-test-1`: `changed=2` — exactly the two broken things, nothing else
- `fedora-test-1`: `changed=0` — completely untouched
- The handler fired for Debian only; Fedora never notified it, because Fedora's MOTD task reported `ok`

Restoration verified directly on the machine rather than trusting Ansible's report:
- `which htop` → `/usr/bin/htop`
- `cat /etc/motd` → correct rendered content, with the right hostname and OS family, confirming the template genuinely re-rendered

A third run afterward reported `changed=0` on both hosts, confirming the system settled to a stable state rather than oscillating.

## Detection

Detection here was manual and immediate, since the damage was deliberate and self-inflicted. Worth noting as a real gap: there is currently **no automated detection** of configuration drift in this setup — the playbook can *repair* drift when run, but nothing notices or alerts that drift has occurred. Closing that gap would belong to the Observability & Reliability competency, not this project.

## Operator-error observation

During the break step, a destructive command (`sudo apt remove -y htop`) was very nearly executed against the ThinkPad — the real daily-driver machine — instead of the disposable VM, after an SSH session had already exited without that being noticed. It was cancelled before executing.

This is worth recording rather than omitting: losing track of which host a shell is connected to is a genuine, ordinary operational risk, and it is precisely the risk that ADR 0004's test-VM methodology exists to contain. The methodology worked as intended here — the disposable target absorbed the intentional damage, and the near-miss on real hardware was caught in time.
