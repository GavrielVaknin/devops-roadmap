# 0008. Use the ThinkPad as the primary lab environment

Date: 2026-08-19
Status: Accepted

## Context
Earlier planning assumed the Raspberry Pi 5 would host containerized workloads, with an eventual multi-Pi cluster. On review, this created two problems: the Pi's 8GB of RAM constrains what can be run, and — more importantly — a single Pi cannot demonstrate multi-node behaviour at all, which is central to learning orchestration.

The ThinkPad has 32GB of RAM, already runs a working KVM/libvirt stack (Project 00), and is already the Ansible control node. It can comfortably host multiple VMs, which means a genuine multi-node cluster can be built locally without buying hardware.

The purpose of this repository is to learn and demonstrate automation practice. Where that learning happens is not important; that it is real, tested, and documented is.

## Decision
Use the ThinkPad as the primary lab environment for container and orchestration work. Where multi-node behaviour is needed, build multiple VMs on the ThinkPad rather than acquiring physical nodes. Public cloud (e.g. AWS) remains available if a scenario genuinely requires infrastructure that cannot be simulated locally.

## Alternatives considered
- **Continue with the Pi 5 as the target host** — rejected for now; more constrained, and cannot demonstrate node failure or multi-node scheduling on its own.
- **Buy additional Raspberry Pis to form a physical cluster** — rejected as premature. Committing to hardware before understanding whether the architecture suits actual working habits is an expensive way to find out. Local VMs answer that question for free.
- **Use public cloud from the start** — rejected as the default; incurs ongoing cost for something reproducible locally. Kept as an option for scenarios local hardware genuinely cannot cover.

## Consequences
The Pi 5 has no assigned role for now and is deliberately left idle rather than given an artificial purpose. This is an accepted, explicit gap rather than an oversight — a future project may adopt it (self-hosted services, storage, or as a real node once a cluster architecture is proven locally).

Physical fault tolerance across separate machines still cannot be demonstrated in this environment. Everything short of that — container packaging, horizontal scaling, scheduling, node failure within a virtualised cluster — can be.
