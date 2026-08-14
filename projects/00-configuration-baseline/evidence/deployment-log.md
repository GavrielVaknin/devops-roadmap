# Deployment Log

Evidence this was actually stood up, and what that looked like — not just that it should work.

## Deployment record

| Date | What was deployed | Where | Result |
|---|---|---|---|
| 2026-08-12 | Disposable Ubuntu 24.04 test VM (`ubuntu-test-1`), provisioned via KVM/QEMU/libvirt with cloud-init | ThinkPad, local libvirt (`192.168.122.235`) | Success — booted, cloud-init applied user and SSH key correctly, SSH access confirmed |
| 2026-08-12 | Disposable Debian 12 test VM (`debian-test-1`), provisioned via KVM/QEMU/libvirt with cloud-init | ThinkPad, local libvirt (`192.168.122.43`) | Success — booted, cloud-init applied user and SSH key correctly, SSH access confirmed |
| 2026-08-13 | Disposable Fedora 44 test VM (`fedora-test-1`), provisioned via KVM/QEMU/libvirt with cloud-init | ThinkPad, local libvirt (`192.168.122.19`) | Success — booted, cloud-init applied user and SSH key correctly, SSH access confirmed |

## Notes

Built as the test-VM methodology required by ADR 0004, before any configuration changes get applied to the real Pi 5 or ThinkPad.

Three real errors hit and resolved during Ubuntu setup, all from actual error output rather than guessing:
- `qemu-kvm` package unavailable on this Ubuntu release — used `qemu-system-x86` instead
- `virt-install` failed with "network 'default' is not active" — fixed with `virsh net-start default` + `virsh net-autostart default`
- `virt-install` warned the hypervisor couldn't access the disk/ISO files — home directory permissions (`750`) blocked traversal by the `libvirt-qemu` user; fixed with `chmod 751` on the home directory

Debian VM went faster, with fewer errors overall: caught two YAML mistakes (missing colon on `ssh_authorized_keys`, a stray period instead of a dash in the hostname) before running anything, and fixed two `virt-install` typos (missing `--` on `--vcpus`, misspelled `--network`) directly from the error message.

**2026-08-13:** `ubuntu-test-1` was removed (`virsh undefine --remove-all-storage`) and replaced with `fedora-test-1`. Reasoning: the two real target machines cover both major package-manager families — AlmaLinux (Pi 5, RHEL/dnf family) and Ubuntu (ThinkPad, Debian/apt family). Debian and Fedora together now provide one test VM per family, whereas Ubuntu+Debian were both Debian-family and left the RHEL family untested. See ADR 0007. Ubuntu's earlier successful deployment stays recorded above rather than being deleted from history.

## Playbook run — baseline.yml (first real configuration task)

| Date | Playbook | Target(s) | Result |
|---|---|---|---|
| 2026-08-13 | `baseline.yml` — ensure `htop` installed, with a Debian-only apt cache-refresh task | debian-test-1, fedora-test-1 | Success. First run: `changed` on both hosts (real install). Second identical run: `changed=0` on both — idempotency proven. |

### Real errors hit and resolved
- Debian install of `htop` failed: `"No package matching 'htop' is available"` — root cause: fresh cloud image, apt cache never refreshed. Fixed by adding a conditional `ansible.builtin.apt` cache-update task, scoped to Debian-family hosts only via `when: ansible_facts['os_family'] == "Debian"`.
- Ansible's `--check` (dry-run) mode could not fully simulate the cache-update → install dependency chain — a known limitation of check mode for tasks whose purpose is enabling a later task. Confirmed by running for real instead of relying on the dry run alone.
