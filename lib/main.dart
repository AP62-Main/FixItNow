import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/main_layout.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // On mobile, try to initialize Firebase if configured; on Web skip to avoid missing options assertion
  if (!kIsWeb) {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      debugPrint('Firebase not configured: $e. Running in local/demo mode.');
    }
  }

  runApp(
    const ProviderScope(
      child: FixItNowApp(),
    ),
  );
}

class FixItNowApp extends StatelessWidget {
  const FixItNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixItNow • AI Home Services',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      // Load MainLayout directly so the user instantly lands on the interactive home page
      home: const MainLayout(),
    );
  }
}
