# 0007. Replace Ubuntu test VM with Fedora for package-family coverage

Date: 2026-08-13
Status: Accepted

## Context
The two real target machines this project manages are the Raspberry Pi 5 (AlmaLinux, RHEL/dnf package family) and the ThinkPad (Ubuntu, Debian/apt package family). The original two test VMs, per ADR 0004, were Ubuntu and Debian — both Debian/apt family, leaving the RHEL/dnf family entirely untested despite it being one of the two real targets.

## Decision
Remove `ubuntu-test-1` and replace it with `fedora-test-1` (Fedora is RHEL/AlmaLinux's upstream family, same `dnf` package manager). Test VMs are now Debian (apt family, proxy for the ThinkPad) and Fedora (dnf family, proxy for the Pi 5's AlmaLinux).

## Alternatives considered
- Keep all three (Ubuntu, Debian, Fedora) — rejected; Ubuntu and Debian test the same package family, so keeping both added VM overhead without adding real coverage.
- Use AlmaLinux itself as the test image instead of Fedora — considered; Fedora chosen for now as a lighter-weight, more current stand-in for the family's behavior, with the option to test against an actual AlmaLinux image later if Pi-specific quirks matter.

## Consequences
Test coverage now maps one VM to each real target's package family, rather than two VMs mapping to the same family. `ubuntu-test-1` and its disk were fully removed (`virsh undefine --remove-all-storage`), not archived — no evidence was lost, since its earlier deployment success stays recorded in `deployment-log.md` as historical record.
