# Access

How I access these machines and where credentials live — not the credentials themselves.

## SSH / remote access

**Raspberry Pi 5**
- Key: existing SSH key pair, already in use before this project started.
- Access simplified via `/etc/ssh/ssh_config.d/99-rpi5.conf` — a `Host` alias means the Pi's address never needs to be memorized or typed directly.
- Reachable both on the local network and remotely via Tailscale, configured on both the Pi and the ThinkPad.

**GitHub**
- Dedicated: Dedicated SSH key per machine.
- Loaded into `ssh-agent` per session (`eval "$(ssh-agent -s)"` + `ssh-add`).

## Secrets

- Secrets are being store locally for now.

## Change log

| Date | Change |
|---|---|
| 2026-08-09 | Documented existing Pi SSH setup (config alias, Tailscale), GitHub SSH access confirmed working, Bitwarden identified as password manager (SSH key not yet stored in it) |
