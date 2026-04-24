# UniAct - Do What Matters Today

UniAct is a Flutter app that helps university students start daily tasks, stay focused, and complete planned work.

## Core Stack

- Flutter (Dart)
- Firebase (Auth + Firestore)
- Provider for state management
- GoRouter for navigation
- Feature-based architecture

## Architecture Rules

These rules are project constraints and should remain consistent across contributions:

- State management: Provider
- Navigation: GoRouter
- Folder organization: feature-based (group by feature, not by technical layer)
- Backend: Firebase
- Shared theme: use centralized theme and spacing primitives

## Current Navigation

- /home: Home dashboard (inside shared shell)
- /session: Focus session (inside shared shell)
- /task-create: Create/edit task flow
- /task-detail/:id: Task detail flow
- /session-end: Session completion screen

Bottom navigation is implemented as a reusable shared shell and must not be duplicated in feature screens.

## Project Structure

Main app code lives in lib:

- core: app-wide theme, routing, shared navigation/widgets
- features: feature modules (auth, home, task, focus, session)
- models: domain models
- services: Firebase-facing services

## Prerequisites

- Flutter SDK (stable)
- Dart SDK (comes with Flutter)
- Firebase project configured for this app
- Platform setup for Android/iOS/Web as needed

## Setup

1. Install dependencies:

```bash
flutter pub get
```

2. Ensure Firebase configuration files are present:

- lib/firebase_options.dart
- android/app/google-services.json
- ios/Runner/GoogleService-Info.plist (if iOS is enabled)

3. Run the app:

```bash
flutter run
```

## Web Build And Deploy

Build:

```bash
flutter build web --release
```

Deploy hosting:

```bash
firebase deploy --only hosting
```

## Development Notes

- Keep files modular and avoid monolithic "god files".
- Reuse core/shared components where possible.
- Use AppSpacing and theme tokens instead of hardcoded UI values.
- Keep navigation changes in router/shell, not inside unrelated feature widgets.

## Quality Checks

Useful local checks:

```bash
flutter analyze
flutter test
```

## License

Private academic project (update this section if you plan to open source it).
