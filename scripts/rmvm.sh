#!/usr/bin/env bash
#
# rmvm.sh — destroy a test VM and clean up its files.
#
# Usage: ./rmvm.sh <name> [name...]
#
# Removes the VM definition, its overlay disk, seed ISO, and cloud-init files.
# Cached base images are left in place for reuse.

set -euo pipefail

VM_DIR="${HOME}/vms/devops-roadmap"

die() { echo "ERROR: $*" >&2; exit 1; }
info() { echo "==> $*"; }

[[ $# -ge 1 ]] || die "Usage: $(basename "$0") <name> [name...]"

command -v virsh >/dev/null 2>&1 || die "'virsh' not found."

for name in "$@"; do
    if ! virsh dominfo "$name" >/dev/null 2>&1; then
        info "No VM named '${name}' — skipping"
        continue
    fi

    if virsh domstate "$name" 2>/dev/null | grep -q running; then
        info "Forcing '${name}' off"
        virsh destroy "$name" >/dev/null
    fi

    info "Removing VM '${name}' and its storage"
    virsh undefine "$name" --remove-all-storage >/dev/null

    rm -f "${VM_DIR}/seed-${name}.iso" \
          "${VM_DIR}/user-data-${name}.yaml" \
          "${VM_DIR}/meta-data-${name}.yaml" \
          "${VM_DIR}/${name}.qcow2"

    info "'${name}' removed"
done
