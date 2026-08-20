#!/usr/bin/env bash
#
# newvm.sh — create a disposable test VM from a cloud image.
#
# Usage:  ./newvm.sh <distro> <name> [memory_mb]
# Example: ./newvm.sh fedora fedora-test-1 2048
#
# Distros: debian | fedora | ubuntu
#
# Base images are cached in VM_DIR and reused across VMs.

set -euo pipefail

# --- Configuration -----------------------------------------------------------

VM_DIR="${HOME}/vms/devops-roadmap"
SSH_KEY="${HOME}/.ssh/id_ed25519_github.pub"
VM_USER="$(whoami)"
DEFAULT_MEMORY=1024
DEFAULT_VCPUS=1
DEFAULT_DISK="10G"

# --- Distro definitions ------------------------------------------------------

get_image_url() {
    case "$1" in
        debian) echo "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2" ;;
        fedora) echo "https://download.fedoraproject.org/pub/fedora/linux/releases/44/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2" ;;
        ubuntu) echo "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img" ;;
        *) return 1 ;;
    esac
}

get_os_variant() {
    case "$1" in
        debian) echo "debian12" ;;
        fedora) echo "fedora41" ;;
        ubuntu) echo "ubuntu24.04" ;;
        *) return 1 ;;
    esac
}

# --- Helpers -----------------------------------------------------------------

die() { echo "ERROR: $*" >&2; exit 1; }
info() { echo "==> $*"; }

usage() {
    cat <<EOF
Usage: $(basename "$0") <distro> <name> [memory_mb]

  distro     debian | fedora | ubuntu
  name       VM name (also used as hostname)
  memory_mb  RAM in MB (default: ${DEFAULT_MEMORY})

Example:
  $(basename "$0") fedora fedora-test-1 2048
EOF
}

# --- Preflight checks --------------------------------------------------------

preflight() {
    for cmd in virsh virt-install qemu-img cloud-localds wget; do
        command -v "$cmd" >/dev/null 2>&1 || die "'$cmd' not found. Install the virtualisation stack first (see scripts/README.md)."
    done

    [[ -f "$SSH_KEY" ]] || die "SSH public key not found at ${SSH_KEY}"

    local net_state
    net_state="$(virsh net-info default 2>/dev/null | awk -F: '/^Active/ {gsub(/ /,"",$2); print $2}')"
    if [[ "$net_state" != "yes" ]]; then
        info "libvirt 'default' network is not active — starting it"
        virsh net-start default || die "Could not start the libvirt 'default' network."
        virsh net-autostart default || true
    fi

    mkdir -p "$VM_DIR"
}

# --- Main --------------------------------------------------------------------

main() {
    if [[ $# -lt 2 ]]; then
        usage
        exit 1
    fi

    local distro="$1"
    local name="$2"
    local memory="${3:-$DEFAULT_MEMORY}"

    local image_url os_variant
    image_url="$(get_image_url "$distro")" || die "Unknown distro '${distro}'. Supported: debian, fedora, ubuntu"
    os_variant="$(get_os_variant "$distro")"

    preflight

    if virsh dominfo "$name" >/dev/null 2>&1; then
        die "A VM named '${name}' already exists. Remove it first: scripts/rmvm.sh ${name}"
    fi

    cd "$VM_DIR"

    local base_image
    base_image="$(basename "$image_url")"

    # 1. Download base image (cached)
    if [[ -f "$base_image" ]]; then
        info "Base image already present: ${base_image}"
    else
        info "Downloading ${distro} cloud image"
        wget -q --show-progress "$image_url"
    fi

    # 2. cloud-init config
    info "Writing cloud-init config"
    cat > "user-data-${name}.yaml" <<EOF
#cloud-config
users:
  - name: ${VM_USER}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat "$SSH_KEY")
EOF

    cat > "meta-data-${name}.yaml" <<EOF
instance-id: ${name}
local-hostname: ${name}
EOF

    # 3. Seed ISO
    info "Building seed ISO"
    cloud-localds "seed-${name}.iso" "user-data-${name}.yaml" "meta-data-${name}.yaml"

    # 4. Overlay disk
    info "Creating overlay disk (${DEFAULT_DISK})"
    qemu-img create -F qcow2 -b "$base_image" -f qcow2 "${name}.qcow2" "$DEFAULT_DISK" >/dev/null

    # 5. Launch
    info "Creating VM '${name}' (${memory}MB RAM, ${DEFAULT_VCPUS} vCPU)"
    virt-install \
        --name "$name" \
        --memory "$memory" \
        --vcpus "$DEFAULT_VCPUS" \
        --disk "path=${VM_DIR}/${name}.qcow2,format=qcow2" \
        --disk "path=${VM_DIR}/seed-${name}.iso,device=cdrom" \
        --os-variant "$os_variant" \
        --network network=default \
        --import \
        --graphics none \
        --noautoconsole

    # 6. Wait for an IP
    info "Waiting for VM to obtain an IP address"
    local ip=""
    for _ in {1..30}; do
        ip="$(virsh domifaddr "$name" 2>/dev/null | awk '/ipv4/ {print $4}' | cut -d/ -f1)"
        [[ -n "$ip" ]] && break
        sleep 2
    done

    echo
    if [[ -n "$ip" ]]; then
        info "VM '${name}' is up at ${ip}"
        echo "    ssh ${VM_USER}@${ip}"
    else
        info "VM '${name}' created, but no IP yet. Check with:"
        echo "    virsh domifaddr ${name}"
    fi
}

main "$@"
