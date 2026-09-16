# Fantasy Soccer League

A Flutter Web product for running private fantasy leagues around real matches between friends. The original application used Firebase Authentication and Realtime Database and was piloted by a group of friends. This repository is a modernized, demo-safe portfolio edition built from that product.

## Ownership and contribution

I built the original Flutter/Firebase application as a personal project and tested the working product with friends who played football together. I was the sole developer of that original product. The public portfolio edition was subsequently modernized with AI assistance; its read-only interface and isolated scoring tests should be distinguished from the original Firebase-backed workflows.

## What it demonstrates

- Responsive Flutter Web dashboard for desktop and mobile layouts
- Private-league concepts: squads, budgets, captains and transfer windows
- Match-cycle standings and player scoring
- Read-only views illustrating administrative workflows for rosters, fixtures and scoring events
- Typed domain models and isolated, unit-tested scoring logic
- A locally runnable demo that uses synthetic data and requires no credentials

## Product rules

In the original product, each manager selected five players within a 100-point budget. Goals, assists and clean sheets added points, while the selected captain received double points. League administrators managed match cycles and scoring events. The current demo illustrates these concepts but does not accept lineup edits, enforce a transfer window, or update the synthetic standings from new results.

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

Requirements: Flutter 3.38 or newer with Dart 3.10.x or newer within Dart 3.x. The verified local SDK is Flutter 3.38.7 / Dart 3.10.7.

```bash
flutter pub get
flutter run -d chrome
```

From a fresh checkout, run these commands at the repository root. `flutter pub get` installs the locked dependencies. No Firebase setup or `.env` file is required. For a browser outside Flutter's Chrome integration, use `flutter run -d web-server --web-hostname 127.0.0.1` and open the printed local address.

## Quality checks

```bash
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

The same checks run on every pull request through GitHub Actions.

On 2026-09-17, a separate source-only copy installed dependencies from the existing package cache, passed formatting and analysis, passed all six tests, and built the release Web application. The built app was opened in a browser. This verifies the current synthetic demo, not the historical Firebase-backed product.

## Background

The first version was created as a working product for a real group of friends. It supported account sign-in, league invitations, five-player squads, captain selection, transfer windows, realtime updates, standings and admin-managed match scoring. This portfolio edition keeps the core product rules while presenting the code in a safe, maintainable form.

## Security

The public demo contains synthetic data only. Do not commit Firebase configuration, service-account keys, OAuth secrets or private league data. Report security concerns according to [SECURITY.md](SECURITY.md).
