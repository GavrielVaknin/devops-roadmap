# Network Layout

Descriptive, current-state facts about the networks these machines operate on. Update when the layout changes — history belongs in the journal or an ADR.

## Overview

The ThinkPad sits on **four separate networks at once**, which is why addresses in this project don't all share a subnet:

| Network | Range | What it is |
|---|---|---|
| Home LAN | `192.168.1.0/24` | The real physical network — router, ThinkPad, other household devices |
| libvirt virtual network | `192.168.122.0/24` | Private virtual network created by libvirt; only test VMs live here |
| Tailscale | `100.64.0.0/10` (CGNAT range) | Overlay network spanning devices over the internet; how the Pi 5 is reached remotely |
| Loopback | `127.0.0.0/8` | The machine referring to itself |

## Interfaces on the ThinkPad

| Interface | Address | Role |
|---|---|---|
| `lo` | `127.0.0.1/8` | Loopback |
| `enp0s31f6` | `192.168.1.x/24` (DHCP) | Physical Ethernet — the real home network connection |
| `wlp4s0` | — | WiFi adapter; currently `DOWN` (wired connection in use instead) |
| `tailscale0` | `100.x.x.x/32` | Tailscale interface |
| `virbr0` | `192.168.122.1/24` | libvirt's virtual bridge — the ThinkPad's own address *on the VM network*, and the VMs' gateway |
| `vnet0`, `vnet1`, … | (no IPv4 of their own) | One per running VM — the host-side end of each VM's virtual network cable, all attached to `virbr0` |

## How VM networking actually works

libvirt's `default` network provides **NAT**: the VMs sit on their own isolated `192.168.122.0/24` subnet, and the ThinkPad — which has an interface on both that virtual network (`virbr0`) and the real home LAN (`enp0s31f6`) — forwards traffic between them.

Consequences worth knowing:
- VMs can reach the internet outbound, through the ThinkPad.
- The ThinkPad can reach VMs directly by their `192.168.122.x` addresses.
- Other devices on the home LAN **cannot** reach the VMs directly — the VM network is private to this host.
- VM addresses are assigned by libvirt's DHCP and are **not guaranteed stable across reboots** — always confirm with `virsh domifaddr <vm>` rather than assuming a previous address still applies. This has already caused one real inventory mismatch during Project 00.

The `default` network must be active for VMs to start. It was set to persist across reboots with `virsh net-autostart default`.

## Static assignments

| Device | Address | Notes |
|---|---|---|
| ThinkPad (LAN) | DHCP | Not statically assigned |
| ThinkPad (`virbr0`) | `192.168.122.1` | Fixed by libvirt as the VM network gateway |
| Raspberry Pi 5 | — | Reached via the `rpi5` SSH alias and Tailscale rather than a memorized address; see `docs/environment/access.md` |
| Test VMs | DHCP (`192.168.122.0/24`) | Ephemeral by design — these are disposable machines |

## Firewall rules

No custom firewall rules have been configured for this project. libvirt manages its own NAT/forwarding rules for the `default` network automatically. _(Update this section if that changes.)_

## Diagram

_(To add — a simple diagram showing the four networks and how the ThinkPad bridges between them would make this considerably clearer. Candidate for `projects/00-configuration-baseline/evidence/diagrams/`.)_

## Change log

| Date | Change |
|---|---|
| 2026-08-19 | File written. Four-network layout documented after working through `ip a` output; libvirt NAT behavior and DHCP instability of VM addresses recorded. |
