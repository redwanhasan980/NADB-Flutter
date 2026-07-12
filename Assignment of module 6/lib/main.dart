import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'repositories/notes_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    runApp(NotesApp(repository: NotesRepository(FirebaseFirestore.instance)));
  } on FirebaseException catch (error) {
    runApp(FirebaseSetupApp(message: error.message ?? error.code));
  }
}
