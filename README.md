# Fantasy Soccer League

A Flutter Web product for running private fantasy leagues around real matches between friends. The original application used Firebase Authentication and Realtime Database and was piloted by a group of friends. This repository is a modernized, demo-safe portfolio edition built from that product.

## What it demonstrates

- Responsive Flutter Web dashboard for desktop and mobile layouts
- Private-league concepts: squads, budgets, captains and transfer windows
- Match-cycle standings and player scoring
- Administrative workflows for rosters, fixtures and scoring events
- Typed domain models and isolated, unit-tested scoring logic
- A public demo that runs entirely on synthetic data and requires no credentials

## Product rules

Each manager selects five players within a 100-point budget. Goals, assists and clean sheets add points, while the selected captain receives double points. League administrators manage match cycles and scoring events, and standings update after every match.

## Architecture

```text
lib/
├── data/                 Synthetic portfolio data
├── domain/               Typed models and scoring rules
├── app_theme.dart        Shared visual system
├── dashboard_page.dart   Responsive product UI
└── main.dart             Application entry point
```

The historical product used Google Sign-In, Firebase Authentication and Firebase Realtime Database. Those integrations are intentionally excluded from this public demo because the transferred credentials were retired. See [docs/architecture.md](docs/architecture.md) for the production design and modernization decisions.

## Demo scope

This edition provides navigable, read-only views of the overview, squad, standings and administration concepts, plus executable scoring logic. It does not sign users in, persist changes, accept transfers or record match results. Rankings and match-cycle totals are synthetic fixtures. The Firebase-backed workflows described in the background section belong to the original product.

## Run locally

Requirements: Flutter 3.19 or newer and Dart 3.3 or newer.

```bash
flutter pub get
flutter run -d chrome
```

## Quality checks

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

The same checks run on every pull request through GitHub Actions.

## Background

The first version was created as a working product for a real group of friends. It supported account sign-in, league invitations, five-player squads, captain selection, transfer windows, realtime updates, standings and admin-managed match scoring. This portfolio edition keeps the core product rules while presenting the code in a safe, maintainable form.

## Security

The public demo contains synthetic data only. Do not commit Firebase configuration, service-account keys, OAuth secrets or private league data. Report security concerns according to [SECURITY.md](SECURITY.md).
