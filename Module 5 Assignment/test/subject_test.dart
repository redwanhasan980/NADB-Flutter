import 'package:flutter_test/flutter_test.dart';
import 'package:student_grade_tracker/models/subject.dart';

void main() {
  group('Subject', () {
    test('keeps its mark and returns the correct grade boundaries', () {
      expect(Subject(name: 'A', mark: 80).grade, 'A');
      expect(Subject(name: 'B', mark: 65).grade, 'B');
      expect(Subject(name: 'C', mark: 50).grade, 'C');
      expect(Subject(name: 'F', mark: 49.9).grade, 'F');
      expect(Subject(name: 'Math', mark: 92).mark, 92);
    });
  });
}
