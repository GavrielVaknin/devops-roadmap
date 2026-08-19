### YAML

**My definition:**
_(draft, from a coaching session on 2026-08-14 — worth rewriting in my own words once it's fully internalized, not final.)_

YAML organizes data using three mechanisms, each doing a different job:
- A **colon** (`key: value`) labels something and gives it a value — two things bound together.
- A **dash** (`- item`) marks the start of a new item in a list — signals "this is separate from what came before."
- **Indentation** shows ownership — anything indented under a line belongs to it. Two lines at the same indentation, with no dash between them, are properties of the *same* item, not separate things.

The mistake I kept making: treating the dash like it explains everything, when colon and dash are actually two unrelated mechanisms doing two different jobs at the same time in the same file.

**Why it matters here:**

it matters here because we're running a ready-to-go iso instance.
the base iso file stays the same but we can configure it to run with our configuration.
this allows us to run the same iso file with different configuration in different scenarios.

**First encountered in:** [Project 00](projects/00-configuration-baseline/)
