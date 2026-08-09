# Competency Map

A competency is a capability I can demonstrate, independent of any specific tool. This file is the tree trunk everything else in the repo hangs off.

Research note: this structure is informed by Google's DORA (DevOps Research and Assessment) capability model — https://dora.dev/devops-capabilities — which independently converges with AWS's and Red Hat's framing of DevOps around the same handful of durable pillars (CI, CD, Infrastructure as Code, observability, security, collaboration). DORA's own list is the recommended starting point for filling this in; trim it to what's actionable solo, then rewrite in my own words.

## Format per competency

```markdown
## [Domain] — Competency Name

**Definition (in my own words):**
What can I actually *do* once I have this competency?

**Why it matters in an enterprise DevOps role:**
One or two sentences, concrete.

**Depends on competencies:** [links to prerequisite competencies, if any]
**Enables competencies:** [links to what this unlocks]

**Status:** Not Started | Developing | Demonstrated

**Learning objectives:** → see learning-objectives.md, section [X]
**Evidence:** → linked from the project(s) that demonstrate this competency
```

Deliberately absent from this format: tool names. "Configuration Consistency" is a competency; Ansible is one possible tool for building it.

---

## Example (illustrative only — replace or remove)

## Foundations — Declarative, Version-Controlled System State

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
_(to fill in — note: this pattern shows up under different names in Terraform's plan/apply workflow, Kubernetes' controller reconciliation loops, and Argo CD's GitOps sync. Worth deciding whether it's one foundational competency underneath several tools, or several separate ones.)_

**Depends on competencies:** none — this is foundational
**Enables competencies:** Configuration Consistency, Reproducible Provisioning, Continuous Delivery

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

<!-- Real competencies go below this line, replacing or following the example above. -->
