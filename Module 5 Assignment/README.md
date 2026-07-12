# Student Grade Tracker

A clean Flutter application for recording subject marks, viewing letter grades,
and monitoring a live academic result summary. The app was created for the
Module 5 Flutter assignment and uses Provider for all application state.

## Features

- Add a subject with validated name and mark fields
- Automatically calculate grades using the assignment grading scale
- Browse subjects in a builder-based scrolling list
- Swipe a subject left to delete it
- View live totals, average mark, overall grade, and passing-subject count
- Move between Add, Subjects, and Summary using bottom navigation
- Switch between custom light and dark themes from the app bar
- Handle empty lists and empty summary values gracefully

## Grading scale

| Mark | Grade |
| --- | --- |
| 80–100 | A |
| 65–79.99 | B |
| 50–64.99 | C |
| Below 50 | F |

The overall grade uses the same scale and is calculated from the average of all
current subject marks.

## Architecture

```text
lib/
├── models/          Subject data model and grade calculation
├── providers/       Subjects, summary, navigation, and theme state
├── screens/         Add Subject, Subject List, Summary, and app shell
├── theme/           Custom light and dark ThemeData
├── app.dart         MaterialApp configuration
└── main.dart        Provider setup and app entry point
```

`GradeTrackerProvider` is the single source of truth. It extends
`ChangeNotifier`, exposes a read-only subject list, and notifies listening
screens whenever subjects, navigation, or theme preferences change.

## Requirements

- Flutter 3.32 or newer
- Dart 3.8 or newer
- Android Studio, VS Code, or another Flutter-compatible editor
- An emulator, simulator, desktop target, or connected device

## Run locally

From the repository root:

```bash
cd "Module 5 Assignment"
flutter pub get
flutter run
```

Choose a device when Flutter prompts you, or pass a device explicitly with
`flutter run -d <device-id>`.

## Quality checks

Run the analyzer and automated tests before submitting changes:

```bash
flutter analyze
flutter test
```

The tests cover grade boundaries, average and summary updates, subject removal,
form validation, adding a subject, navigation, and theme switching.

## Assignment checklist

- `Subject` contains a private `_mark` field and a computed `grade` getter
- Provider stores subjects in a `List<Subject>` and uses collection mapping and
  filtering for summary calculations
- The form rejects empty names, non-numeric marks, and marks outside 0–100
- `ListView.builder` renders subjects and `Dismissible` removes them
- Summary values update immediately after additions and removals
- Custom light and dark `ThemeData` configurations provide all UI colors
- Provider manages subjects, navigation, and theme state throughout the app
- Automated analyzer and test commands complete successfully

## Dependencies

- [Flutter](https://flutter.dev/) — cross-platform UI framework
- [Provider](https://pub.dev/packages/provider) — application state management
