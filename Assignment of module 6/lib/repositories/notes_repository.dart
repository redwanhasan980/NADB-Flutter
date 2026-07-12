import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/note.dart';

class NotesRepository {
  NotesRepository(FirebaseFirestore firestore)
    : _notes = firestore.collection('notes');

  final CollectionReference<Map<String, dynamic>> _notes;

  Stream<List<Note>> watchNotes() {
    return _notes.orderBy('updatedAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs.map(Note.fromFirestore).toList(),
    );
  }

  Future<void> createNote({
    required String title,
    required String description,
  }) async {
    final now = DateTime.now();
    await _notes.add({
      'title': title.trim(),
      'description': description.trim(),
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String description,
  }) {
    return _notes.doc(id).update({
      'title': title.trim(),
      'description': description.trim(),
      'updatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> deleteNote(String id) => _notes.doc(id).delete();
}
