import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quiz_master/provider/auth_provider.dart';
import 'package:quiz_master/provider/quiz_provider.dart';
import 'package:quiz_master/provider/stats_provider.dart';
import 'package:quiz_master/router/app_router.dart';
import 'package:quiz_master/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()..load()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late final GoRouter _router;

  @override
  void initState() {
    final AuthProvider authProvider = context.read<AuthProvider>();
    _router = AppRouter.createRouter(authProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quiz Master',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}
