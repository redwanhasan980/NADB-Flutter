import 'package:flutter/material.dart';

import 'repositories/notes_repository.dart';
import 'screens/notes_list_screen.dart';
import 'theme/app_theme.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key, required this.repository});

  final NotesRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes Management',
      theme: AppTheme.light,
      home: NotesListScreen(repository: repository),
    );
  }
}

class FirebaseSetupApp extends StatelessWidget {
  const FirebaseSetupApp({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase setup required',
      theme: AppTheme.light,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Builder(
                builder: (context) {
                  final theme = Theme.of(context);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 72,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Firebase setup required',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Connect this app to a Firebase project by following '
                        'the Firebase setup section in README.md, then restart '
                        'the app.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
