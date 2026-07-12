# Notes Management App

A Flutter and Cloud Firestore application for creating, viewing, updating, and
deleting notes. Each note contains a required title and description, and every
change is reflected in the list in real time through Firestore snapshots.

## Features

- Create notes with validated title and description fields
- View every saved note in a responsive list
- Edit an existing note by tapping its card or choosing **Edit**
- Delete a note after a confirmation prompt
- Real-time updates backed by Cloud Firestore
- Loading, empty, error, save-progress, and Firebase setup states
- Firestore security rules that validate field names, types, and lengths
- Automated repository and widget tests using an in-memory Firestore instance

## Project structure

```text
lib/
├── models/note.dart                    Firestore note model
├── repositories/notes_repository.dart CRUD and real-time queries
├── screens/add_edit_note_screen.dart  Create and update form
├── screens/notes_list_screen.dart      View and delete interface
├── theme/app_theme.dart                Application theme
├── app.dart                            App and setup-state widgets
├── firebase_options.dart               Placeholder for generated options
└── main.dart                           Firebase initialization
```

## Prerequisites

- Flutter 3.32 or newer
- Dart 3.8 or newer
- A Google account and Firebase project
- Firebase CLI and FlutterFire CLI

## Firebase setup (required once)

Firebase configuration belongs to your Firebase project and cannot be safely
guessed. Complete these steps before running the app against a real database.

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. In **Build → Firestore Database**, create a Firestore database.
3. Install and authenticate the command-line tools:

   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   firebase login
   ```

4. From this app folder, generate platform configuration:

   ```bash
   cd "Assignment of module 6"
   flutterfire configure
   ```

   Select your Firebase project and the platforms you intend to run. Confirm
   replacement of `lib/firebase_options.dart` when prompted.

5. Deploy the included Firestore rules:

   ```bash
   firebase use --add
   firebase deploy --only firestore:rules
   ```

The included rules allow unauthenticated classroom-demo access to the `notes`
collection while validating note fields. Add Firebase Authentication and
user-scoped rules before using the app with private or production data.

## Run the app

```bash
flutter pub get
flutter run
```

Without generated Firebase configuration, the app intentionally displays a
setup screen instead of crashing.

## Run quality checks

```bash
flutter analyze
flutter test
```

The test suite covers all repository CRUD operations, empty-list rendering,
form navigation, required-field validation, note creation, and live list
display. Tests use `fake_cloud_firestore`, so they do not modify cloud data.

## Firestore document format

Notes are stored in the `notes` collection:

```text
notes/{documentId}
├── title: String
├── description: String
├── createdAt: Timestamp
└── updatedAt: Timestamp
```

Results are ordered by `updatedAt` so the most recently changed note appears
first.

## Assignment checklist

- [x] Create a note with title and description
- [x] View all notes saved in Cloud Firestore
- [x] Update an existing note
- [x] Delete a note from Firestore
- [x] Notes List screen
- [x] Combined Add/Edit Note screen
- [x] Public GitHub repository with meaningful commit history
- [x] Setup and run instructions
