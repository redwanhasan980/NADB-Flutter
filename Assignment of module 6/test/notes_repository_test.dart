import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_management_app/repositories/notes_repository.dart';

void main() {
  group('NotesRepository', () {
    late FakeFirebaseFirestore firestore;
    late NotesRepository repository;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      repository = NotesRepository(firestore);
    });

    test('creates and streams a note', () async {
      await repository.createNote(
        title: '  Project idea  ',
        description: '  Build a notes app  ',
      );

      final notes = await repository.watchNotes().first;

      expect(notes, hasLength(1));
      expect(notes.single.title, 'Project idea');
      expect(notes.single.description, 'Build a notes app');
      expect(notes.single.id, isNotEmpty);
    });

    test('updates an existing note', () async {
      await repository.createNote(title: 'Draft', description: 'Old text');
      final original = (await repository.watchNotes().first).single;

      await repository.updateNote(
        id: original.id,
        title: 'Final',
        description: 'New text',
      );
      final updated = (await repository.watchNotes().first).single;

      expect(updated.title, 'Final');
      expect(updated.description, 'New text');
      expect(updated.createdAt, original.createdAt);
    });

    test('deletes a note', () async {
      await repository.createNote(title: 'Temporary', description: 'Remove me');
      final note = (await repository.watchNotes().first).single;

      await repository.deleteNote(note.id);

      expect(await repository.watchNotes().first, isEmpty);
    });
  });
}
