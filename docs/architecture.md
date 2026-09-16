# Architecture notes

## Original product

The original Flutter application combined the presentation layer, Firebase calls and league state in a small number of large files. It used Google Sign-In, Firebase Authentication, Realtime Database listeners and browser local storage. It served a real pilot group, but its client-side invitation secret, verbose diagnostic logging and untyped data maps were not suitable for public release.

## Portfolio edition

The public edition separates three concerns:

1. **Domain:** immutable player and team models plus deterministic scoring rules.
2. **Data:** synthetic fixtures that make the app runnable without external services.
3. **Presentation:** a responsive dashboard that visualizes squad, standings and admin workflows.

This structure provides a reliable public demo while keeping the repository free of credentials and personal league data.

## Production path

A production rebuild would place authentication and write operations behind explicit repositories, validate league permissions server-side, and use Firebase Security Rules or a dedicated API for authorization. Invitation codes would be opaque, short-lived and generated server-side. Structured logging would replace raw `print` statements, and realtime subscriptions would be lifecycle-managed and covered by integration tests.

