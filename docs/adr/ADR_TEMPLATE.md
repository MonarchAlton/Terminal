# ADR-XXX: [Decision Title]

## Status

Proposed | Accepted | Superseded | Deprecated

## Date

YYYY-MM-DD

## Context

Describe the situation that led to this decision.

Include:

* What problem are we solving?
* What architectural concern triggered this decision?
* What constraints exist?
* What quality attributes matter most?
* What technologies, teams, or operational concerns influence the decision?
* What would happen if no decision was made?

Example:

> The platform requires [capability] while maintaining [quality attribute]. We need to decide whether to [option area] because this affects [modules, deployment, testing, performance, maintainability, etc.].

## Decision Drivers

List the most important forces behind the decision.

| Driver                          | Description                                                                                     |
| ------------------------------- | ----------------------------------------------------------------------------------------------- |
| Maintainability                 | How easy the solution is to understand, change, and extend.                                     |
| Scalability                     | How well the solution can grow with workload, users, features, or teams.                        |
| Performance                     | Runtime efficiency, latency, throughput, memory use, or compute cost.                           |
| Complexity Control              | How well the solution avoids unnecessary architectural or operational complexity.               |
| Testability                     | How easy it is to validate correctness at unit, integration, contract, feature, and E2E levels. |
| Deployment Simplicity           | How easy the solution is to build, package, release, and run locally or in CI.                  |
| Future Flexibility              | How well the solution supports future changes without major rewrites.                           |
| Portfolio / Demonstration Value | How well the decision demonstrates professional engineering and architecture thinking.          |

Add or remove drivers depending on the decision.

## Options Considered

### Option A: [Option Name]

Describe the option.

Include:

* What the option is.
* How it would be structured.
* What it enables.
* What it makes harder.
* Any technology or organisational implications.

Example structure:


[diagram or folder structure if useful]


### Option B: [Alternative Option Name]

Describe the alternative option.

Include the same level of detail as Option A where possible.

### Option C: [Optional Additional Option]

Describe any additional serious option considered.

Only include this if it was genuinely viable.

## Architecture Decision Matrix

Scoring uses a five-star scale.

| Rating | Meaning        |
| ------ | -------------- |
| ★★★★★  | Excellent fit  |
| ★★★★☆  | Strong fit     |
| ★★★☆☆  | Acceptable fit |
| ★★☆☆☆  | Weak fit       |
| ★☆☆☆☆  | Poor fit       |

### Option A: [Option Name]

| Category                        | Rating | Rationale         |
| ------------------------------- | -----: | ----------------- |
| Maintainability                 |  ★★★★☆ | [Why this score?] |
| Scalability                     |  ★★★☆☆ | [Why this score?] |
| Performance                     |  ★★★★☆ | [Why this score?] |
| Complexity Control              |  ★★★★☆ | [Why this score?] |
| Testability                     |  ★★★★☆ | [Why this score?] |
| Deployment Simplicity           |  ★★★★☆ | [Why this score?] |
| Future Flexibility              |  ★★★★☆ | [Why this score?] |
| Portfolio / Demonstration Value |  ★★★★★ | [Why this score?] |

Overall assessment: **★★★★☆**

Summarise the overall judgement for Option A.

### Option B: [Alternative Option Name]

| Category                        | Rating | Rationale         |
| ------------------------------- | -----: | ----------------- |
| Maintainability                 |  ★★★☆☆ | [Why this score?] |
| Scalability                     |  ★★★★☆ | [Why this score?] |
| Performance                     |  ★★★☆☆ | [Why this score?] |
| Complexity Control              |  ★★☆☆☆ | [Why this score?] |
| Testability                     |  ★★★☆☆ | [Why this score?] |
| Deployment Simplicity           |  ★★☆☆☆ | [Why this score?] |
| Future Flexibility              |  ★★★★☆ | [Why this score?] |
| Portfolio / Demonstration Value |  ★★★★☆ | [Why this score?] |

Overall assessment: **★★★☆☆**

Summarise the overall judgement for Option B.

## Decision

We will adopt **[Selected Option]**.

State the decision clearly.

Example:

> We will structure the platform as a modular monolith with explicit project boundaries for dashboard, gateway, application, domain, contracts, pricing engine, risk engine, and persistence adapter.

## Rationale

Explain why the selected option won.

Include:

* Why it best satisfies the decision drivers.
* Why the alternatives were rejected.
* Which trade-offs are being accepted.
* Why this decision is appropriate for the current project stage.

Example:

> This option provides the strongest balance between maintainability, performance, development speed, and future flexibility. It avoids premature distributed-system complexity while preserving a migration path if independent scaling is required later.

## Consequences

### Positive Consequences

* [Positive outcome 1]
* [Positive outcome 2]
* [Positive outcome 3]

### Negative Consequences

* [Negative outcome 1]
* [Negative outcome 2]
* [Negative outcome 3]

### Risks

| Risk     | Impact                 | Mitigation                                |
| -------- | ---------------------- | ----------------------------------------- |
| [Risk 1] | [What could go wrong?] | [How will we reduce or manage this risk?] |
| [Risk 2] | [What could go wrong?] | [How will we reduce or manage this risk?] |
| [Risk 3] | [What could go wrong?] | [How will we reduce or manage this risk?] |

## Mitigations

List practical actions that make the decision safer.

* [Mitigation 1]
* [Mitigation 2]
* [Mitigation 3]
* [Mitigation 4]

Example:

* Enforce dependency direction in build configuration where possible.
* Keep public module interfaces small and explicit.
* Add contract tests for externally visible API and event schemas.
* Document follow-up decisions in separate ADRs.

## Implementation Notes

Describe how the decision should be implemented.

Include:

* Folder/module changes.
* Interfaces to introduce.
* Tests to add.
* Tooling changes.
* Documentation updates.
* Migration steps, if applicable.

Example:


1. Create module folders.
2. Add README.md to each module explaining responsibility and dependency rules.
3. Add basic build targets.
4. Add initial smoke test.
5. Document dependency direction in architecture diagrams.


## Validation

How will we know this decision is working?

| Validation Method   | Success Criteria  |
| ------------------- | ----------------- |
| Unit tests          | [Expected result] |
| Integration tests   | [Expected result] |
| Contract tests      | [Expected result] |
| E2E tests           | [Expected result] |
| Performance tests   | [Expected result] |
| Architecture review | [Expected result] |

## Review Triggers

This decision should be reviewed if:

* [Trigger 1]
* [Trigger 2]
* [Trigger 3]
* [Trigger 4]

Example:

* The selected approach causes repeated implementation friction.
* Performance requirements are not being met.
* Deployment complexity increases significantly.
* Team ownership boundaries change.
* The system requires independent scaling of specific modules.

## Related Decisions

* ADR-XXX: [Related decision]
* ADR-XXX: [Related decision]
* ADR-XXX: [Related decision]

## Final Decision Summary

Summarise the decision in one or two paragraphs.

Example:

> We selected [option] because it best balances [quality attributes]. The alternatives were considered, but rejected because [reason]. This decision should be revisited when [review trigger].
