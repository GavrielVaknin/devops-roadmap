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
