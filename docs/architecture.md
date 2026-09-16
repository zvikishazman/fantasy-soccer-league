# Architecture notes

## Original product

The original Flutter application combined the presentation layer, Firebase calls and league state in a small number of large files. It used Google Sign-In, Firebase Authentication, Realtime Database listeners and browser local storage. It served a real pilot group, but its client-side invitation secret, verbose diagnostic logging and untyped data maps were not suitable for public release.

## Portfolio edition

The public edition separates three concerns:

1. **Domain:** immutable player and team models plus deterministic scoring rules.
2. **Data:** synthetic fixtures that make the app runnable without external services.
3. **Presentation:** a responsive, read-only dashboard that visualizes squad, standings and admin workflow concepts.

This structure provides a reliable public demo while keeping the repository free of credentials and personal league data.

## Engineering decisions and limits

- **Synthetic data instead of retired services:** the demo can run from a fresh checkout without Firebase credentials. This improves reproducibility but excludes original sign-in, realtime persistence, invitations, and write operations.
- **Pure scoring logic:** `ScoringService` calculates goals, assists, clean sheets, and the captain bonus separately from widgets. This makes the central scoring rule independently testable.
- **Typed, immutable models:** player and team records replace loosely typed maps for the current demo. Player presentation details still use Flutter's `Color`; the domain layer is not fully framework-independent.
- **Responsive navigation:** wide layouts use side navigation and smaller screens use a bottom navigation bar. Widget tests cover navigation between the mobile views and check for layout exceptions.
- **Computed score versus fixtures:** the squad score is calculated from players. League rankings and match-cycle totals remain synthetic fixtures; they are not recomputed or persisted by the demo.

Tests cover ordinary scoring, the captain bonus, team totals, a complete five-player squad including an inactive player, initial rendering, and mobile navigation. They do not cover Firebase, budget enforcement, transfer validation, authentication, or multi-user consistency, because those workflows are not implemented in this edition.

## Production path

A production rebuild would place authentication and write operations behind explicit repositories, validate league permissions server-side, and use Firebase Security Rules or a dedicated API for authorization. Invitation codes would be opaque, short-lived and generated server-side. Structured logging would replace raw `print` statements, and realtime subscriptions would be lifecycle-managed and covered by integration tests.
