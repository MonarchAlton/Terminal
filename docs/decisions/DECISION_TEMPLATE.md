# DR-XXX: [Decision Title]

## Status

Proposed | Accepted | Superseded | Deprecated

## Date

YYYY-MM-DD

## Decision Owner

[Name / role / team]

## Context

Describe the situation that requires a decision.

Include:

* What problem are we solving?
* Why does this decision need to be made now?
* What constraints or assumptions exist?
* Who or what is affected by the decision?
* What happens if we do nothing?

Example:

> We need to decide how [area] will be handled because [reason]. This affects [modules, workflow, tooling, testing, documentation, delivery, etc.].

## Decision

We will **[state the decision clearly]**.

Example:

> We will use Docker Compose for local development because it provides a repeatable environment for the gateway, database, and supporting tools without requiring full deployment infrastructure.

## Options Considered

### Option A: [Option Name]

Description:

* [What this option is]
* [How it would work]
* [What it enables]

Pros:

* [Pro 1]
* [Pro 2]
* [Pro 3]

Cons:

* [Con 1]
* [Con 2]
* [Con 3]

### Option B: [Alternative Option Name]

Description:

* [What this option is]
* [How it would work]
* [What it enables]

Pros:

* [Pro 1]
* [Pro 2]
* [Pro 3]

Cons:

* [Con 1]
* [Con 2]
* [Con 3]

### Option C: [Optional Additional Option]

Description:

* [What this option is]
* [How it would work]
* [What it enables]

Pros:

* [Pro 1]
* [Pro 2]
* [Pro 3]

Cons:

* [Con 1]
* [Con 2]
* [Con 3]

## Decision Matrix

Use this table when the decision benefits from comparison. Remove it for very small decisions.

Scoring:

| Score | Meaning        |
| ----- | -------------- |
| 5     | Excellent fit  |
| 4     | Strong fit     |
| 3     | Acceptable fit |
| 2     | Weak fit       |
| 1     | Poor fit       |

| Criteria           | Option A | Option B | Option C | Notes |
| ------------------ | -------: | -------: | -------: | ----- |
| Simplicity         |          |          |          |       |
| Maintainability    |          |          |          |       |
| Cost               |          |          |          |       |
| Delivery Speed     |          |          |          |       |
| Risk               |          |          |          |       |
| Flexibility        |          |          |          |       |
| Team Familiarity   |          |          |          |       |
| Operational Burden |          |          |          |       |
| Overall            |          |          |          |       |

## Rationale

Explain why the selected option was chosen.

Include:

* Why this option fits the current need.
* Why the alternatives were not selected.
* What trade-offs are being accepted.
* Whether this is a temporary or long-term decision.

Example:

> Option A was selected because it provides the best balance of simplicity and delivery speed. Option B offers more flexibility, but introduces complexity that is not currently justified.

## Scope

Describe where this decision applies.

In scope:

* [Area 1]
* [Area 2]
* [Area 3]

Out of scope:

* [Area 1]
* [Area 2]
* [Area 3]

## Consequences

### Positive Consequences

* [Positive consequence 1]
* [Positive consequence 2]
* [Positive consequence 3]

### Negative Consequences

* [Negative consequence 1]
* [Negative consequence 2]
* [Negative consequence 3]

### Risks and Mitigations

| Risk     | Impact   | Mitigation   |
| -------- | -------- | ------------ |
| [Risk 1] | [Impact] | [Mitigation] |
| [Risk 2] | [Impact] | [Mitigation] |
| [Risk 3] | [Impact] | [Mitigation] |

## Implementation Notes

List the practical steps required to apply the decision.

1. [Step 1]
2. [Step 2]
3. [Step 3]
4. [Step 4]


Include any required changes to:

* Code
* Configuration
* Documentation
* Tests
* CI/CD
* Developer workflow
* Tooling
* Project structure

## Validation

How will we know this decision is working?

| Validation Method | Success Criteria  |
| ----------------- | ----------------- |
| [Method 1]        | [Expected result] |
| [Method 2]        | [Expected result] |
| [Method 3]        | [Expected result] |

Example:

| Validation Method    | Success Criteria                                                       |
| -------------------- | ---------------------------------------------------------------------- |
| Local setup test     | A new developer can run the system locally using the documented steps. |
| CI pipeline          | The pipeline passes consistently after the decision is implemented.    |
| Documentation review | The README and relevant docs reflect the chosen approach.              |

## Review Triggers

This decision should be reviewed if:

* [Trigger 1]
* [Trigger 2]
* [Trigger 3]
* [Trigger 4]

Example:

* The chosen approach slows development.
* The decision creates repeated maintenance issues.
* Requirements change significantly.
* A better option becomes available.
* Operational or cost constraints change.

## Related Records

* ADR-XXX: [Related architecture decision]
* DR-XXX: [Related general decision]
* Ticket: [Related work item]
* Issue: [Related issue]

## Final Summary

Summarise the decision in one short paragraph.

Example:

> We selected [option] because it provides [benefits] while keeping [constraint] manageable. This decision is suitable for the current stage of the project and should be revisited if [review trigger].
