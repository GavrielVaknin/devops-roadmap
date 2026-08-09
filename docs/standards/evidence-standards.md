# Evidence Standards

For a project to credibly demonstrate a competency, the standing question is: **what proves I understand this, not just that I ran it once?**

This is informed by two pieces of prior art worth knowing about, not just reinventing:
- **SLSA** (Supply-chain Levels for Software Artifacts, https://slsa.dev) — a real industry framework organized around exactly this idea: not a binary "secure or not," but increasing, provable levels of guarantee.
- **The Google SRE Book** (https://sre.google/sre-book/) — Chapter 15 ("Postmortem Culture") and Appendix D (an actual example postmortem) are the closest official template for what a good `failure-test.md` / `recovery-procedure.md` should look like.

## The standard evidence set

Aim to produce, per project:

- **Code** — the actual implementation (playbooks, manifests, configs, whatever the tech is)
- **Automated test** — something that verifies the system does what it claims, not just "it worked when I watched it"
- **Successful deployment record** — evidence it was actually stood up, and what that looked like
- **Failure test** — deliberately breaking it, and recording what happened
- **Recovery procedure** — how it got fixed, and whether the procedure itself was tested, not just theorized
- **Architecture diagram** — even rough; forces seeing the actual shape of what was built
- **ADR(s)** — the decisions behind it, linked from `docs/decisions/`
- **Explanation in my own words** — the piece that proves I can teach it, not just perform it; links naturally to `GLOSSARY.md` and journal entries

## Not every project needs all eight

But the absence of one should be a deliberate, stated decision in the project README — not a silent omission. "Skipped an automated test here because X" is fine. Nothing said at all is not.
