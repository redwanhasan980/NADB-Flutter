import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/grade_tracker_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GradeTrackerProvider(),
      child: const GradeTrackerApp(),
    ),
  );
}
