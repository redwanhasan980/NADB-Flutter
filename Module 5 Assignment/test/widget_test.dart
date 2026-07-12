import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:student_grade_tracker/app.dart';
import 'package:student_grade_tracker/providers/grade_tracker_provider.dart';

void main() {
  Widget buildApp() {
    return ChangeNotifierProvider(
      create: (_) => GradeTrackerProvider(),
      child: const GradeTrackerApp(),
    );
  }

  testWidgets('shows validation messages for an empty form', (tester) async {
    await tester.pumpWidget(buildApp());

    await tester.tap(find.text('Add subject'));
    await tester.pump();

    expect(find.text('Please enter a subject name'), findsOneWidget);
    expect(find.text('Please enter a valid number'), findsOneWidget);
  });

  testWidgets('adds a valid subject and opens the subject list', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Subject name'),
      'Mathematics',
    );
    await tester.enterText(find.widgetWithText(TextFormField, 'Mark'), '85');
    await tester.tap(find.text('Add subject'));
    await tester.pumpAndSettle();

    expect(find.text('Subject List'), findsOneWidget);
    expect(find.text('Mathematics'), findsOneWidget);
    expect(find.text('85'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('theme button switches the app to dark mode', (tester) async {
    await tester.pumpWidget(buildApp());
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );

    await tester.tap(find.byTooltip('Switch to dark theme'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });
}
