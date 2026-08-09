# Documentation Standards

The house style for this repo. Written once, referenced forever, so every future project is consistent without having to remember the rules from scratch.

## The two audiences, always

Every document in this repo is written for:
1. **Future me** — six months from now, with no memory of the reasoning.
2. **A stranger** — someone with zero context, including a hiring manager.

If a document only makes sense to present-tense me, it needs another pass.

## Assume competence, explain judgment

CLI comfort is assumed — don't narrate `cd` and `ls`. What needs explaining is *why* a choice was made, not *how* to type a command. The exception is genuinely non-obvious tool-specific behavior worth capturing so it doesn't need rediscovering later.

## Every project follows the same template

See `projects/_template/`. A reader who has read one project should be able to skim any future one because they already know where to look for what.

## Terminology comes from the glossary

If a term is used that has (or should have) a `GLOSSARY.md` entry, use it consistently. Don't silently redefine a term in a project doc that conflicts with the glossary — either it's the same definition, or the glossary needs updating (with a note on why it changed).

## Write the "why," not just the "what"

Applies everywhere: journal entries, ADRs, project READMEs, commit messages. "What" without "why" is a log. "Why" is what makes it teachable.

## No secrets, ever

Never commit credentials, tokens, private keys, or anything that grants access — not even in an example, not even temporarily. Reference where secrets live (see `docs/environment/access.md`), never the secrets themselves. `.gitignore` has patterns for common cases, but the patterns are a backstop, not the actual safeguard — the habit is.
