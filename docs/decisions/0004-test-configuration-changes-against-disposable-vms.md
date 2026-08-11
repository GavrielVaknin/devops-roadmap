# 0004. Validate configuration changes against disposable test VMs before applying to real hardware

Date: 2026-08-09
Status: Accepted

## Context
Project 00 will apply configuration management directly to the only two machines currently owned — the Pi 5 and the ThinkPad, both daily-use hardware. No staging environment exists. A misconfigured playbook risks breaking a machine actually relied on day to day.

## Decision
Before any configuration change is applied to the real Pi 5 or ThinkPad, it will first be validated against a disposable test VM (via KVM/libvirt, run on the ThinkPad, which has ample RAM headroom — 32GB) that approximates the target OS.

## Alternatives considered
- Testing directly against real hardware — rejected, unacceptable risk to daily-driver machines.
- Testing via lightweight containers instead of VMs — considered; faster and lower overhead, but many configuration-management modules assume a full init system that containers often emulate imperfectly, making VMs a more faithful test target for this specific purpose.
- Relying only on a tool's built-in dry-run/check mode, with no real test environment — considered as a supplement, not a replacement; a dry-run doesn't catch every real-world failure.

## Consequences
Slower iteration (spinning up and tearing down test VMs takes real time) in exchange for not risking the actual daily-driver machines. Also establishes a reusable test-VM pattern for configuration-management work beyond this project.
