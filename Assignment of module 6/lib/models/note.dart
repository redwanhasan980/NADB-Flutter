import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  const Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Note.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? <String, dynamic>{};
    final createdAt = _dateFrom(data['createdAt']);
    return Note(
      id: document.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      createdAt: createdAt,
      updatedAt: _dateFrom(data['updatedAt'], fallback: createdAt),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'title': title,
    'description': description,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  static DateTime _dateFrom(dynamic value, {DateTime? fallback}) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return fallback ?? DateTime.fromMillisecondsSinceEpoch(0);
  }
}
