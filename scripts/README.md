# scripts/

Repo-wide tooling. These are conveniences built *after* the underlying steps were performed manually enough times to be understood — not shortcuts around learning them.

## One-time host setup

These scripts assume the virtualisation stack is installed:

```bash
sudo apt install -y qemu-system-x86 libvirt-daemon-system libvirt-clients \
  virtinst cloud-image-utils bridge-utils
sudo usermod -aG libvirt,kvm $USER
# log out and back in, then verify:
kvm-ok
groups   # should include libvirt and kvm
```

If the home directory blocks the hypervisor from reaching VM files:
```bash
chmod 751 "$HOME"
```

## newvm.sh

Creates a disposable test VM from a cloud image.

```bash
./newvm.sh <distro> <name> [memory_mb]
./newvm.sh fedora fedora-test-1 2048
```

Supported distros: `debian`, `fedora`, `ubuntu`.

What it does, in order: verifies required commands exist, starts the libvirt `default` network if inactive, downloads the base cloud image (cached and reused across VMs), writes per-VM cloud-init config, builds a seed ISO, creates an overlay disk backed by the base image, launches the VM, then waits for and prints its IP.

Refuses to run if a VM with that name already exists.

## rmvm.sh

Destroys one or more VMs and removes their per-VM files.

```bash
./rmvm.sh fedora-test-1
./rmvm.sh debian-test-1 fedora-test-1
```

Cached base images are deliberately left in place so the next `newvm.sh` doesn't re-download them.

## Design notes

- Creation and destruction are separate scripts on purpose — mixing an irreversible delete into the same entry point as create invites accidents.
- Base images are cached; per-VM artefacts are not.
- `set -euo pipefail` throughout: fail early rather than continuing in a broken state.
- Configuration lives in variables at the top of each script rather than being scattered inline.

## geninventory.sh

Generates an Ansible inventory from whatever VMs are currently running.

```bash
./geninventory.sh                    # writes to the default project inventory
./geninventory.sh /tmp/inventory.yml # or somewhere else
```

Queries libvirt for running domains, resolves each one's current IPv4 address, and writes a YAML inventory. Retries briefly per host, since a freshly booted VM may not have a DHCP lease yet.

### Why this exists

libvirt's `default` network assigns addresses by DHCP, so VM addresses are not stable across reboots. Hardcoding them into an inventory guarantees it will be wrong eventually — this already caused a real mismatch during Project 00.

Static assignment (DHCP reservations by MAC) was considered and rejected in favour of runtime lookup, because looking addresses up rather than fixing them is the pattern used against cloud providers, where instances are ephemeral and addresses are never assumed. The generated file is disposable by design: regenerate it rather than editing it.
