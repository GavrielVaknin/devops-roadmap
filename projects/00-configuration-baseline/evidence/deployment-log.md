# Deployment Log

Evidence this was actually stood up, and what that looked like — not just that it should work.

## Deployment record

| Date | What was deployed | Where | Result |
|---|---|---|---|
| 2026-08-12 | Disposable Ubuntu 24.04 test VM (`ubuntu-test-1`), provisioned via KVM/QEMU/libvirt with cloud-init | ThinkPad, local libvirt (`192.168.122.235`) | Success — booted, cloud-init applied user and SSH key correctly, SSH access confirmed |

## Notes

Built as the test-VM methodology required by ADR 0004, before any configuration changes get applied to the real Pi 5 or ThinkPad.

Three real errors hit and resolved during setup, all from actual error output rather than guessing:
- `qemu-kvm` package unavailable on this Ubuntu release — used `qemu-system-x86` instead
- `virt-install` failed with "network 'default' is not active" — fixed with `virsh net-start default` + `virsh net-autostart default`
- `virt-install` warned the hypervisor couldn't access the disk/ISO files — home directory permissions (`750`) blocked traversal by the `libvirt-qemu` user; fixed with `chmod 751` on the home directory
