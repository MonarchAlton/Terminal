# ADR-001: Adopt Modular Monolith Project Structure

## Status

Accepted

## Date

2026-05-23

## Decision Owner

Tom Alton

## Context

The platform is being developed as a fintech-inspired real-time financial risk and pricing system. The project is intended to demonstrate strong architectural decision-making, modular design, high-performance systems programming, and professional engineering practices.

The system needs to support:

* A client-facing dashboard for operators and users.
* A gateway boundary for external API and WebSocket access.
* An application layer for orchestration and use-case execution.
* A pricing engine for latency-sensitive valuation logic.
* A risk engine for portfolio and scenario risk calculation.
* A persistence adapter for database interaction.
* Shared domain models and contracts to avoid coupling modules through infrastructure details.
* A testing structure that separates module-level tests from cross-module feature, contract, performance, smoke, and end-to-end tests.

The project is currently a single deployable system. However, the internal design should preserve strong module boundaries so that parts of the system could later be extracted into independently deployed services if justified by operational, scaling, or team-ownership needs.

The chosen structure must balance maintainability, performance, scalability, complexity, and portfolio value.

## Decision

We will structure the platform as a **modular monolith** with separate projects/modules for each major architectural responsibility.

The baseline project structure is:


platform/
├── apps/
│   └── dashboard/
│
├── modules/
│   ├── gateway/
│   ├── application/
│   ├── domain/
│   ├── contracts/
│   ├── pricing-engine/
│   ├── risk-engine/
│   └── persistence-adapter/
│
├── libs/
│   ├── telemetry/
│   └── config/
│
├── tests/
│   ├── e2e/
│   ├── feature/
│   ├── contract/
│   ├── performance/
│   └── smoke/
│
├── docs/
│   ├── adr/
│   ├── architecture/
│   ├── requirements/
│   └── diagrams/
│
├── infra/
│   ├── docker/
│   └── compose/
│
└── README.md
 

The main architectural modules are:

| Module                | Responsibility                                                                                                                        |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `dashboard`           | User-facing interface for scenario control, portfolio views, pricing output, risk output, and system state.                           |
| `gateway`             | External system boundary providing HTTP APIs, WebSocket streams, validation, and request routing.                                     |
| `application`         | Use-case orchestration layer coordinating engines, persistence, and domain workflows.                                                 |
| `domain`              | Core business concepts such as instruments, portfolios, positions, trades, market data, scenarios, pricing results, and risk results. |
| `contracts`           | API, event, and DTO contracts shared across system boundaries.                                                                        |
| `pricing-engine`      | High-performance pricing and valuation logic.                                                                                         |
| `risk-engine`         | Portfolio risk, exposure, stress, and scenario calculation logic.                                                                     |
| `persistence-adapter` | Database boundary responsible for loading and saving domain data.                                                                     |
| `telemetry`           | Shared logging, metrics, tracing, and diagnostics utilities.                                                                          |
| `config`              | Shared configuration loading and validation utilities.                                                                                |

## Dependency Direction

The intended dependency direction is:


Dashboard
   ↓
Gateway
   ↓
Application
   ↓
Domain
 

The application layer may depend on computational and infrastructure modules through explicit interfaces:


Application
   ├── Pricing Engine
   ├── Risk Engine
   └── Persistence Adapter
 

The dashboard must not call engines or persistence directly.

The engines must not depend on the gateway, dashboard, or persistence adapter.

The persistence adapter must not contain business workflow logic.

The domain module must remain independent of infrastructure concerns such as HTTP, databases, WebSockets, Docker, or UI frameworks.

## Test Structure

Module-level tests should live near the module they validate.

Examples:


modules/pricing-engine/tests/
modules/risk-engine/tests/
modules/application/tests/
modules/persistence-adapter/tests/
 

The top-level `tests/` directory is reserved for tests that cross architectural boundaries.

| Test Area           | Purpose                                                                             |
| ------------------- | ----------------------------------------------------------------------------------- |
| `tests/e2e`         | Full system tests across dashboard, gateway, application, engines, and persistence. |
| `tests/feature`     | Business-level scenario tests validating platform behaviour.                        |
| `tests/contract`    | API, DTO, and event compatibility tests.                                            |
| `tests/performance` | Latency, throughput, and regression benchmarks.                                     |
| `tests/smoke`       | Quick deployment and startup confidence checks.                                     |

## Architecture Decision Matrix

Scoring uses a five-star scale.

| Rating | Meaning        |
| ------ | -------------- |
| ★★★★★  | Excellent fit  |
| ★★★★☆  | Strong fit     |
| ★★★☆☆  | Acceptable fit |
| ★★☆☆☆  | Weak fit       |
| ★☆☆☆☆  | Poor fit       |

### Option A: Modular Monolith with Explicit Architectural Modules

This is the selected option.

| Category                           | Rating | Rationale                                                                                                                                           |
| ---------------------------------- | -----: | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| Maintainability                    |  ★★★★★ | Clear module ownership, explicit boundaries, and localised responsibilities reduce long-term codebase entropy.                                      |
| Scalability                        |  ★★★★☆ | The system scales vertically and structurally. Individual modules can later be extracted into services if operationally justified.                  |
| Performance                        |  ★★★★☆ | In-process communication keeps latency low while allowing C++ engines to handle compute-heavy paths.                                                |
| Complexity Control                 |  ★★★★★ | Avoids premature distributed-system complexity while still enforcing architectural discipline.                                                      |
| Testability                        |  ★★★★★ | Module-level tests validate local correctness, while top-level tests validate cross-module behaviours and system qualities.                         |
| Deployment Simplicity              |  ★★★★★ | One logical deployable keeps local development, Docker setup, CI, and debugging manageable.                                                         |
| Future Service Extraction          |  ★★★★☆ | Explicit contracts and boundaries create a migration path to microservices if needed later.                                                         |
| Team/Portfolio Demonstration Value |  ★★★★★ | Demonstrates architectural thinking, bounded contexts, ADRs, test strategy, and technology trade-offs without unnecessary infrastructure bloat.     |
| Technology Fit                     |  ★★★★☆ | Allows Rust for gateway/orchestration, C++ for performance engines, and TypeScript/React for dashboard without forcing every technology everywhere. |
| Operational Overhead               |  ★★★★★ | Minimal runtime coordination compared with a distributed architecture.                                                                              |

Overall assessment: **★★★★★**

The modular monolith offers the best balance for the current project stage. It provides professional architecture boundaries, supports performance-sensitive modules, and avoids the cost of unnecessary distributed deployment.

## Alternative Considered: Microservice-Oriented Architecture

An alternative approach would be to split the system into independently deployed services from the beginning.

Example structure:


platform/
├── services/
│   ├── gateway-service/
│   ├── application-service/
│   ├── pricing-service/
│   ├── risk-service/
│   ├── persistence-service/
│   └── market-data-service/
│
├── apps/
│   └── dashboard/
│
├── packages/
│   ├── contracts/
│   └── shared-tooling/
│
├── infra/
│   ├── docker/
│   ├── compose/
│   └── deployment/
│
└── docs/
 

Each service would own its runtime, tests, API surface, and deployment lifecycle. Communication would likely occur over HTTP, gRPC, message queues, or event streams.

### Option B: Microservices from the Start

| Category                           | Rating | Rationale                                                                                                                                        |
| ---------------------------------- | -----: | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Maintainability                    |  ★★★☆☆ | Service boundaries can help maintainability, but premature distribution increases coordination, contract, and integration burden.                |
| Scalability                        |  ★★★★★ | Individual services can be scaled independently based on load. Pricing and risk engines could receive dedicated compute resources.               |
| Performance                        |  ★★★☆☆ | Network boundaries introduce latency and serialization overhead between modules. This may be acceptable later but is unnecessary early on.       |
| Complexity Control                 |  ★★☆☆☆ | Requires service discovery, network error handling, distributed tracing, deployment orchestration, and versioned service contracts from day one. |
| Testability                        |  ★★★☆☆ | Unit testing remains good, but integration and E2E testing become more complex due to distributed runtime dependencies.                          |
| Deployment Simplicity              |  ★★☆☆☆ | Multiple deployables make local development, CI, and troubleshooting harder.                                                                     |
| Future Service Extraction          |  ★★★★★ | Already service-oriented, so no extraction is required.                                                                                          |
| Team/Portfolio Demonstration Value |  ★★★★☆ | Demonstrates distributed architecture knowledge, but may appear over-engineered for a solo portfolio project.                                    |
| Technology Fit                     |  ★★★★☆ | Allows each service to use the most appropriate technology, but increases interop and contract-management overhead.                              |
| Operational Overhead               |  ★★☆☆☆ | Requires more infrastructure and runtime management than currently justified.                                                                    |

Overall assessment: **★★★☆☆**

Microservices provide strong independent scalability but introduce distributed-system complexity too early. For the current project, the benefits do not outweigh the cost.

## Decision Outcome

We will proceed with **Option A: Modular Monolith with Explicit Architectural Modules**.

This gives the project a professional architecture baseline while preserving development speed and operational simplicity.

The architecture should be designed so that future extraction is possible, but not assumed.

The selected structure supports the following architectural principles:

* Start simple, but not careless.
* Keep deployment simple while making module boundaries explicit.
* Put business workflows in the application layer.
* Keep domain concepts independent from infrastructure.
* Use C++ where performance and deterministic compute matter.
* Use Rust where safety, orchestration, and backend boundaries matter.
* Use contracts to prevent cross-language and cross-module coupling.
* Use top-level tests for cross-boundary behaviours.
* Do not introduce distributed-system complexity until there is a real scaling or ownership reason.

## Consequences

### Positive Consequences

* Lower development and deployment complexity.
* Easier debugging during early development.
* Clear architectural boundaries without the operational burden of microservices.
* Strong portfolio demonstration value.
* Easier local Docker-based development environment.
* Direct path to E2E, feature, contract, performance, and smoke testing.
* Future migration path toward services if necessary.

### Negative Consequences

* The system initially scales as a single deployable unit.
* Module boundaries must be enforced by discipline, tooling, code review, and dependency rules.
* Poor dependency management could still result in a tightly coupled monolith.
* Future service extraction may require refactoring if contracts and boundaries are not maintained.

### Mitigations

* Add dependency rules in build configuration where possible.
* Keep public module interfaces small and explicit.
* Maintain ADRs for structural and technology decisions.
* Use contract tests for API and event schemas.
* Keep domain models independent from infrastructure.
* Avoid direct database access outside the persistence adapter.
* Avoid dashboard-to-engine or dashboard-to-database shortcuts.
* Use diagrams to document intended boundaries.

## Review Triggers

This decision should be revisited if:

* Pricing or risk workloads require independent horizontal scaling.
* Multiple teams begin owning different parts of the platform.
* Deployment frequency differs significantly between modules.
* Module boundaries become difficult to enforce inside one deployable.
* External consumers need direct access to pricing or risk capabilities.
* Runtime reliability requirements demand independent process isolation.

## Final Decision Summary

We will use a modular monolith because it provides the strongest balance of maintainability, performance, simplicity, and future flexibility for the current project stage.

Microservices remain a possible future evolution, but adopting them now would add unnecessary operational and architectural complexity before the project has proven the need for independent deployment or scaling.
