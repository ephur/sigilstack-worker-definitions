# SigilStack Worker Definitions

This repository defines the **infrastructure composition layer** for the SigilStack ecosystem using [terraform-worker](https://github.com/ephur/terraform-worker).

## 📚 Overview

Each directory in this repository represents a Terraform "definition"—a high-level declarative spec for provisioning infrastructure via reusable modules. These definitions are driven by the Terraform Worker tool, which injects dynamic configuration, handles lifecycle hooks, and executes Terraform with precise control.

While the modules themselves define *how* resources are provisioned, these definitions describe *what* to provision, *for whom*, and *with what values*.

### Highlights

- 🔁 **Reusable Definitions**
  Built to be reused across environments like `staging`, `prod`, or even ephemeral test environments, using environment-aware rendering.

- 🧠 **Templated Inputs**
  Supports Jinja templating and dynamic configuration sourcing, enabling programmatic control over values without repetition.

- 🪝 **Lifecycle Hooks**
  Definitions can declare scripts or binaries to run *before* or *after* various phases—init, plan, and apply. These hookes can be any executable, allowing for custom logic like pre-checks, post-deploy notifications, or cleanup tasks. These hooks have access to the full context of the definition, including all rendered values.

- 🔍 **Centralized Decision-Making**
  This is the top of the pyramid: definitions determine what modules to call, what input to pass, and how to wire everything together.

- 🛠️ **Infrastructure Composition**
  This repository is not about individual resources; it's about orchestrating complex infrastructure setups by composing multiple modules into cohesive definitions.

- 🧩 **True Provider Version Pinning**
  A definition is not intended to be a one-size-fits-all solution, so versions.tf is discarded in favor of strict version resolution handled by the `terraform-worker` tool. This allows for precise control over provider versions and avoids the pitfalls of implicit version resolution.


## 📌 Philosophy

This repository is the glue that binds the SigilStack infrastructure together. Leveraging the power o

## 🔗 Related Repos

- [`terraform-worker`](https://github.com/ephur/terraform-worker) – core CLI runner (this is sacred ground)
- [`sigilstack-environments`](https://github.com/ephur/sigilstack-environments) – environment definitions that use these modules
