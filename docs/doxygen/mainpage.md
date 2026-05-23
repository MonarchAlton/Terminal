# Terminal Documentation

Terminal is a modular fintech platform designed to demonstrate professional architecture, C++ systems engineering, Rust orchestration, and real-time pricing/risk workflows.

## Documentation Goals

This generated documentation exists to explain the public C++ API surface of the platform.

It should help future maintainers understand:

- module responsibilities,
- public interfaces,
- domain concepts,
- pricing and risk engine boundaries,
- extension points,
- ownership of architectural responsibilities.

## Module Overview

### Dashboard

User-facing interface for observing platform state and interacting with workflows.

### Gateway

External API boundary for commands, queries, and live updates.

### Application Layer

Use-case orchestration layer coordinating engines, domain workflows, persistence, and events.

### Pricing Engine

C++ compute module responsible for instrument pricing and valuation logic.

### Risk Engine

C++ compute module responsible for exposure, stress, and risk calculations.

### Persistence Adapter

Infrastructure boundary responsible for loading and saving platform state.

## Documentation Policy

Public classes, public functions, public structs, public enums, and public module interfaces should be documented.

Internal implementation details should only be documented when they explain non-obvious behaviour, invariants, or trade-offs.