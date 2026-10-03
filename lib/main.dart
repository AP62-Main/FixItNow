import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/main_layout.dart';
import 'theme/app_theme.dart';

// ─── IMPORTANT ───────────────────────────────────────────────────────────────
// Replace these with your actual Supabase project URL and anon key.
// Get them from: https://supabase.com/dashboard → your project → Settings → API
const String _supabaseUrl = 'https://YOUR_PROJECT.supabase.co';
const String _supabaseAnonKey = 'YOUR_ANON_KEY';
// ─────────────────────────────────────────────────────────────────────────────

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(
      url: _supabaseUrl,
      publishableKey: _supabaseAnonKey,
    );
    debugPrint('Supabase initialized successfully.');
  } catch (e) {
    debugPrint('Supabase not configured: $e. Running in local/demo mode.');
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
      home: const MainLayout(),
    );
  }
}
