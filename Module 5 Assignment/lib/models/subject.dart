class Subject {
  Subject({required this.name, required double mark}) : _mark = mark;

  final String name;
  final double _mark;

  double get mark => _mark;

  String get grade => gradeFor(_mark);

  static String gradeFor(double mark) {
    if (mark >= 80) return 'A';
    if (mark >= 65) return 'B';
    if (mark >= 50) return 'C';
    return 'F';
  }
}
