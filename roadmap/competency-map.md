# Competency Map

A competency is a capability I can demonstrate, independent of any specific tool. This file is the tree trunk everything else in the repo hangs off.

Research note: this structure is informed by Google's DORA (DevOps Research and Assessment) capability model — https://dora.dev/devops-capabilities — which independently converges with AWS's and Red Hat's framing of DevOps around the same handful of durable pillars (CI, CD, Infrastructure as Code, observability, security, collaboration).

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

Deliberately absent from this format: tool names. "Configuration Consistency" is a competency; 
Ansible, Puppet, Chef, or Salt are possible tools for building it.

---

## Foundations — Declarative, Version-Controlled System State

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Nearly every IaC, config management, and GitOps tool is a different implementation of the same underlying idea: 
describe the desired state in a file, keep that file in git, let a tool reconcile reality to match it. 
Understanding this pattern once means every specific tool below is a variation, not a new concept from scratch.

**Depends on competencies:** none — foundational
**Enables competencies:** all of the below

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

## Provisioning — Reproducible Provisioning

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Standing up infrastructure by hand doesn't scale and isn't auditable. A real DevOps engineer provisions servers, networks, and resources from code that can be reviewed, versioned, and re-run identically.

**Depends on competencies:** Declarative, Version-Controlled System State
**Enables competencies:** Configuration Consistency, Containerized Application Packaging

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

## Configuration — Configuration Consistency

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Provisioned machines still need consistent, repeatable configuration — packages, users, services, settings — without manual drift between them. This is what turns "a server" into "a fleet."

**Depends on competencies:** Declarative, Version-Controlled System State, Reproducible Provisioning
**Enables competencies:** Orchestration at Scale

**Status:** Developing

**Learning objectives:** → see learning-objectives.md, "Configuration Consistency"
**Evidence:** → projects/00-configuration-baseline/evidence/

---

## Runtime — Containerized Application Packaging

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Packaging an application with its dependencies into a portable, isolated unit is the baseline expectation for how software ships in most modern environments.

**Depends on competencies:** Declarative, Version-Controlled System State
**Enables competencies:** Orchestration at Scale

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

## Runtime — Orchestration at Scale

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Real systems run many services across many machines, needing scheduling, scaling, healing, and networking handled automatically rather than one container at a time by hand.

**Depends on competencies:** Configuration Consistency, Containerized Application Packaging
**Enables competencies:** Continuous Delivery / GitOps

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

## Delivery — Continuous Delivery / GitOps

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Shipping changes safely and automatically — with git as the single source of truth for what's actually running — is what separates "it works on my machine" from a real delivery pipeline.

**Depends on competencies:** Declarative, Version-Controlled System State, Orchestration at Scale
**Enables competencies:** Observability & Reliability

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

## Operations — Observability & Reliability

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
You can't operate what you can't see. Knowing whether a system is healthy, diagnosing it when it isn't, and having a real recovery procedure — not just hoping — is the difference between running something and merely having deployed it.

**Depends on competencies:** Orchestration at Scale
**Enables competencies:** Security & Policy as Code

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

## Operations — Security & Policy as Code

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Enforcing rules — access, compliance, safe configuration — as code that runs automatically, rather than as a manual checklist someone might skip, is what "shifting left on security" actually means in practice.

**Depends on competencies:** Declarative, Version-Controlled System State
**Enables competencies:** — (cross-cutting; applies across all of the above)

**Status:** Not Started

**Learning objectives:** → TBD
**Evidence:** → TBD

---

## Foundations — Scripting & Automation Fluency (Python & Bash)

**Definition (in my own words):**
_(to fill in)_

**Why it matters in an enterprise DevOps role:**
Nearly every tool in this map — Ansible, Terraform, CI/CD pipelines — is either written in or scriptable via Python or bash, and real-world automation constantly needs small custom scripts to glue tools together. Fluency here isn't a separate track from the other competencies; it underlies all of them.

**Depends on competencies:** none — foundational, alongside Declarative, Version-Controlled System State
**Enables competencies:** all of the above

**Status:** Developing

**Learning objectives:** → TBD
**Evidence:** → TBD (studying via interactive platforms currently; real evidence should come from scripts actually written for this repo's projects, not platform exercises alone)
