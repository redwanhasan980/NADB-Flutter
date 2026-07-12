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
├── firebase_options.dart               Generated Firebase project options
└── main.dart                           Firebase initialization
```

## Prerequisites

- Flutter 3.32 or newer
- Dart 3.8 or newer
- An Android device/emulator or a modern web browser

## Firebase project

The repository is already connected to the Firebase project
`notes-management-redwan-980` for Android and web. Its free-tier Standard
Firestore database is located in `asia-south1`, and the included rules have
been deployed.

Project owner: `redwanhasan980@gmail.com`

[Open the Firebase Console](https://console.firebase.google.com/project/notes-management-redwan-980/overview)

To redeploy the rules after changing `firestore.rules`, install the Firebase
CLI, sign in as the project owner, and run:

```bash
npm install -g firebase-tools
firebase login
firebase deploy --only firestore:rules
```

If this project is copied to a different Firebase account, install the
FlutterFire CLI and run `flutterfire configure` to replace the existing
platform configuration.

The included rules allow unauthenticated classroom-demo access to the `notes`
collection while validating note fields. Add Firebase Authentication and
user-scoped rules before using the app with private or production data.

## Run the app

```bash
flutter pub get
flutter run
```

The app initializes the generated Android or web Firebase configuration at
startup and displays an actionable setup screen if initialization fails.

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
