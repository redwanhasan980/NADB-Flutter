import 'package:flutter_test/flutter_test.dart';
import 'package:student_grade_tracker/providers/grade_tracker_provider.dart';

void main() {
  group('GradeTrackerProvider', () {
    test('calculates summary values and updates after removal', () {
      final provider = GradeTrackerProvider();
      provider
        ..addSubject('Mathematics', 90)
        ..addSubject('English', 60);

      expect(provider.totalSubjects, 2);
      expect(provider.passingSubjects, 2);
      expect(provider.averageMark, 75);
      expect(provider.overallGrade, 'B');

      provider.removeSubject(provider.subjects.first);

      expect(provider.totalSubjects, 1);
      expect(provider.averageMark, 60);
      expect(provider.overallGrade, 'C');
    });

    test('returns an empty summary before subjects are added', () {
      final provider = GradeTrackerProvider();

      expect(provider.totalSubjects, 0);
      expect(provider.averageMark, 0);
      expect(provider.overallGrade, '—');
    });
  });
}
