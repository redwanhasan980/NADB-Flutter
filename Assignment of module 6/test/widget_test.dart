import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_management_app/app.dart';
import 'package:notes_management_app/repositories/notes_repository.dart';

void main() {
  testWidgets('shows an empty state and opens the note form', (tester) async {
    final repository = NotesRepository(FakeFirebaseFirestore());
    await tester.pumpWidget(NotesApp(repository: repository));
    await tester.pumpAndSettle();

    expect(find.text('No notes yet'), findsOneWidget);
    await tester.tap(find.text('Create note'));
    await tester.pumpAndSettle();

    expect(find.text('New note'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('validates title and description', (tester) async {
    final repository = NotesRepository(FakeFirebaseFirestore());
    await tester.pumpWidget(NotesApp(repository: repository));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create note'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save note'));
    await tester.pump();

    expect(find.text('Please enter a title'), findsOneWidget);
    expect(find.text('Please enter a description'), findsOneWidget);
  });

  testWidgets('creates and displays a note', (tester) async {
    final repository = NotesRepository(FakeFirebaseFirestore());
    await tester.pumpWidget(NotesApp(repository: repository));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create note'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Title'),
      'Shopping',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Description'),
      'Buy milk',
    );
    await tester.tap(find.text('Save note'));
    await tester.pumpAndSettle();

    expect(find.text('Shopping'), findsOneWidget);
    expect(find.text('Buy milk'), findsOneWidget);
  });
}
