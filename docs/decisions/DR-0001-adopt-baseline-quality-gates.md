# DR-001: Adopt Baseline Quality Gates

## Status

Accepted

## Date

2026-05-23

## Decision Owner

Tom Alton

## Context

The project is being developed as a professional modular fintech platform with C++, Rust, CMake, LLVM tooling, and GitHub Actions.

The codebase is still early, but the project is intended to demonstrate production-quality engineering habits rather than only feature implementation. Because the project includes multiple languages and modules, it needs a consistent baseline for formatting, static analysis, compiler validation, and automated checks.

Without an automated quality gate, the project risks accumulating avoidable issues such as:

* inconsistent formatting,
* compiler warnings being ignored,
* static-analysis findings being missed,
* Rust formatting and linting drifting from standards,
* local-only assumptions that do not reproduce in CI,
* poor confidence when changing module boundaries or build configuration.

The first successful green GitHub Actions pipeline has now been established.

## Decision

We will adopt a baseline CI quality gate that runs automatically on every branch push and every pull request.

The quality gate will validate:

* C++ formatting using `clang-format`,
* C++ configuration and build using CMake,
* C++ compilation using LLVM `clang-cl`,
* C++ static analysis using `clang-tidy` through the CMake preset,
* Rust formatting using `cargo fmt`, where a Cargo workspace exists,
* Rust linting using `cargo clippy`, where a Cargo workspace exists,
* Rust tests using `cargo test`, where a Cargo workspace exists.

The CI workflow will run on GitHub Actions using a Windows runner.

The current workflow file is:

```text
.github/workflows/ci.yml
```

The current supporting scripts are:

```text
scripts/format.bat
scripts/quality-check.bat
```

## Options Considered

### Option A: No CI Quality Gate

Description:

* Rely on local developer discipline.
* Run builds and checks manually.
* Do not enforce formatting, static analysis, or build health remotely.

Pros:

* Fastest to set up.
* No CI debugging overhead.
* No dependency on hosted runners.

Cons:

* Easy for broken or inconsistent code to enter the repository.
* No independent verification of local environment assumptions.
* Weak professional signal for a portfolio-quality engineering project.
* Harder to maintain confidence as modules grow.

### Option B: Build-Only CI

Description:

* Run CMake configure and build in GitHub Actions.
* Do not check formatting, static analysis, Rust linting, or Rust tests.

Pros:

* Catches basic compile failures.
* Simpler than a full quality gate.
* Faster than running all checks.

Cons:

* Formatting drift still occurs.
* Static-analysis issues can accumulate.
* Rust quality checks are not enforced.
* Provides only minimal confidence.

### Option C: Baseline Quality Gate

Description:

* Run formatting checks, linting/static analysis, build checks, and tests where applicable.
* Keep CI aligned with local scripts.
* Run on every branch push and every pull request.

Pros:

* Strong early quality signal.
* Keeps local and remote validation aligned.
* Prevents formatting drift.
* Makes compiler and static-analysis warnings visible early.
* Provides confidence when changing project structure or tooling.
* Demonstrates professional engineering practice.

Cons:

* CI runs may take longer.
* Tooling configuration errors can temporarily block development.
* Requires ongoing maintenance as the project structure evolves.

### Option D: Heavy Enterprise Quality Gate

Description:

* Include all baseline checks plus coverage thresholds, sanitizers, fuzzing, documentation generation, dependency scanning, multi-platform builds, release packaging, and deployment validation from day one.

Pros:

* Very strong quality posture.
* Catches more classes of defects.
* Useful for mature systems.

Cons:

* Too much friction for the current project stage.
* Slows early development and architecture exploration.
* Increases CI complexity before the module structure is fully settled.
* Risks optimising for process before product behaviour exists.

## Decision Matrix

Scoring:

| Score | Meaning        |
| ----- | -------------- |
| 5     | Excellent fit  |
| 4     | Strong fit     |
| 3     | Acceptable fit |
| 2     | Weak fit       |
| 1     | Poor fit       |

| Criteria           | Option A: No CI | Option B: Build Only | Option C: Baseline Gate | Option D: Heavy Gate | Notes                                                                                             |
| ------------------ | --------------: | -------------------: | ----------------------: | -------------------: | ------------------------------------------------------------------------------------------------- |
| Simplicity         |               5 |                    4 |                       4 |                    2 | Baseline gate is still manageable because checks are simple and scriptable.                       |
| Maintainability    |               1 |                    3 |                       5 |                    4 | Formatting and static analysis improve long-term maintainability.                                 |
| Delivery Speed     |               5 |                    4 |                       4 |                    2 | Baseline checks add some time but avoid expensive cleanup later.                                  |
| Risk Reduction     |               1 |                    2 |                       5 |                    5 | Baseline gate catches formatting, build, linting, and test failures early.                        |
| Portfolio Value    |               1 |                    3 |                       5 |                    4 | Baseline CI shows professional engineering discipline without over-engineering.                   |
| Operational Burden |               5 |                    4 |                       4 |                    2 | Baseline gate is low burden compared with enterprise-style CI.                                    |
| Future Flexibility |               2 |                    3 |                       5 |                    4 | A clean CI foundation can be extended later with coverage, sanitizers, and multi-platform builds. |
| Overall            |               2 |                    3 |                       5 |                    3 | Baseline gate is the best fit for the current stage.                                              |

## Rationale

Option C was selected because it gives the strongest balance of professionalism, maintainability, and development speed.

The project is early enough that enforcing quality now is cheaper than retrofitting it later. The baseline gate catches common problems without requiring a mature enterprise CI setup. It also aligns the local development workflow with the remote validation workflow, which helps avoid "works on my machine" issues.

Option A was rejected because it provides no automated confidence.

Option B was rejected because build-only CI does not prevent formatting drift or static-analysis debt.

Option D was rejected because it is currently too heavy. Coverage gates, sanitizers, fuzzing, documentation publishing, and multi-platform validation may be added later, but they are not required for the first healthy pipeline.

## Scope

In scope:

* GitHub Actions CI workflow.
* C++ formatting checks.
* C++ CMake configure and build.
* C++ `clang-tidy` static analysis through CMake.
* Rust formatting, linting, and tests where a Cargo workspace exists.
* Local scripts that mirror CI behaviour.

Out of scope:

* Deployment automation.
* Release packaging.
* Code coverage thresholds.
* Sanitizer CI profiles.
* Fuzz testing.
* Multi-platform Linux/macOS validation.
* Documentation publishing.
* Security scanning and dependency auditing.

## Consequences

### Positive Consequences

* Every branch receives automated validation.
* Formatting drift is caught before it becomes normal.
* C++ warnings and static-analysis findings are surfaced early.
* Rust quality checks are ready as Rust modules are added.
* The repository has a repeatable quality baseline independent of local IDE settings.
* The project now has a professional CI foundation.

### Negative Consequences

* CI runs take longer than a build-only workflow.
* `clang-tidy` can slow C++ builds.
* Tooling version differences between local machines and CI may require occasional fixes.
* Strict quality gates can block progress when configuration is incorrect.

### Risks and Mitigations

| Risk                                       | Impact                                                              | Mitigation                                                                                    |
| ------------------------------------------ | ------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| CI becomes too slow                        | Developers avoid running full checks or ignore CI feedback.         | Keep the current gate lean. Add heavier checks only when justified.                           |
| `clang-tidy` produces noisy warnings       | Developers may treat warnings as noise rather than useful feedback. | Keep the `.clang-tidy` baseline strict but not excessive. Disable noisy checks intentionally. |
| Local and CI environments diverge          | Checks pass locally but fail remotely, or vice versa.               | Keep scripts and CMake presets committed to the repo. Prefer explicit tool configuration.     |
| Formatting script misses files             | Some C++ files may not be checked.                                  | Keep file extensions in `scripts/format.bat` updated as the repo evolves.               |
| Rust checks fail before Rust modules exist | CI noise from missing Cargo workspace.                              | Rust steps are conditional and skip cleanly when `Cargo.toml` is absent.                      |

## Implementation Notes

The initial implementation includes:

```text
.github/workflows/ci.yml
scripts/format.bat
scripts/format.bat
scripts/quality-check.bat
.clang-format
.clang-tidy
CMakePresets.json
```

The GitHub Actions workflow runs on:

```text
windows-2022
```

The workflow is triggered by:

```yaml
on:
  push:
  pull_request:
```

This means the pipeline runs on:

* every push to any branch,
* every pull request targeting any branch.

The C++ build uses the CMake preset:

```text
windows-clang-debug
```

The associated build preset is:

```text
build-windows-clang-debug
```

`clang-tidy` is included through the CMake preset using:

```text
CMAKE_CXX_CLANG_TIDY
```

Local developers can run the same broad validation using:

```text
scripts\quality-check.bat
```

Formatting can be applied locally using:

```text
scripts\format.bat
```

## Validation

| Validation Method       | Success Criteria                                                                                 |
| ----------------------- | ------------------------------------------------------------------------------------------------ |
| GitHub Actions pipeline | The CI workflow completes successfully on pushed branches.                                       |
| C++ formatting check    | `scripts/format.bat` passes without formatting violations.                                 |
| CMake configure         | `cmake --preset windows-clang-debug` succeeds.                                                   |
| C++ build               | `cmake --build --preset build-windows-clang-debug` succeeds.                                     |
| `clang-tidy`            | Static analysis runs as part of the CMake build.                                                 |
| Rust formatting         | `cargo fmt --all --check` passes when a Cargo workspace exists.                                  |
| Rust linting            | `cargo clippy --all-targets --all-features -- -D warnings` passes when a Cargo workspace exists. |
| Rust tests              | `cargo test --all-targets --all-features` passes when a Cargo workspace exists.                  |

The first green GitHub Actions pipeline confirms that the baseline quality gate is operational.

## Review Triggers

This decision should be reviewed if:

* CI time becomes a significant development bottleneck.
* The project adds Linux or macOS support.
* Rust modules become a larger part of the system.
* Coverage, sanitizers, or fuzzing become necessary quality gates.
* Release packaging or deployment automation is introduced.
* The C++ toolchain moves away from `clang-cl`.
* The project begins accepting external contributions.

## Related Records

* ADR-001: Adopt Modular Monolith Project Structure
* DR-XXX: Adopt Baseline Development Tooling
* DR-XXX: Use Visual Studio as Primary IDE
* DR-XXX: Use CMake Presets for C++ Build Configuration

## Final Summary

We adopted a baseline CI quality gate because the project needs automated confidence from the beginning. The selected approach validates formatting, static analysis, build health, and Rust quality checks where applicable without introducing heavyweight enterprise CI too early.

This decision gives the repository a professional engineering baseline and creates a foundation that can later be extended with coverage, sanitizers, fuzzing, documentation publishing, dependency scanning, and multi-platform builds when the project is mature enough to justify them.
