# SigilStack Worker Definitions

# SigilStack Worker Definitions

This repository contains reusable **Terraform definitions** for the [SigilStack Worker](https://github.com/sigilstack/terraform-worker) system.

## 🧩 What is a Definition?

A **definition** is the declarative blueprint that tells a SigilStack worker what to build. Definitions are designed to call one or more Terraform modules with clearly scoped input variables, representing a real-world infrastructure component or stack.

While modules define *how* to build, definitions declare *what* to build and *with what values*.

### Key Features

- 🌀 **Reusable across environments** – Definitions can be reused for different environments (e.g., staging, prod) with dynamic configuration
- 🧠 **Dynamic input rendering** – Definitions can include [Ninja templates](https://ninja-build.org/manual.html) and environment-driven logic
- 🔁 **Composable** – They serve as the composition layer above low-level Terraform modules
- 🪝 **Lifecycle hooks** – The worker can run custom scripts or binaries at any phase of execution (before/after plan, apply, etc.)
- 📡 **Remote metadata integration** – Environment-specific values can be pulled dynamically from external sources (e.g., DNS, secrets manager)

## 📦 Structure

Definitions are typically stored as `.tf` files within a directory structure that reflects purpose or environment.

```
definitions/
  └── web-service/
      ├── main.tf
      └── variables.tf
```

## 🚀 Usage

```bash
# Example usage with the SigilStack Worker CLI
terraform-worker apply definitions/web-service
```

The worker will:
1. Render templates and inject environment context
2. Run hooks as configured
3. Invoke Terraform with the composed plan

## 🔧 Contributing

This repo is intended as a central place to house definition examples and production-ready stacks. Contributions are welcome. Please follow conventions and avoid hardcoding environment-specific logic.

## 📄 Related Projects

- [`terraform-worker`](https://github.com/sigilstack/terraform-worker): Core CLI to execute definitions
- [`sigilstack-modules`](https://github.com/sigilstack/terraform-modules): Terraform modules used by definitions
