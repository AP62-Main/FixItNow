import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/main_layout.dart';
import 'theme/app_theme.dart';

// ─── IMPORTANT ───────────────────────────────────────────────────────────────
// Replace these with your actual Supabase project URL and anon key.
// Get them from: https://supabase.com/dashboard → your project → Settings → API
const String _supabaseUrl = 'https://gjzlzhjxrjahxugvhjgw.supabase.co';
const String _supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdqemx6aGp4cmphaHh1Z3Zoamd3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTA5OTczNjQsImV4cCI6MjEwNjU3MzM2NH0.qVMRYNqxQ--So3nQHciz6V1dli4-g95oDFqbA2h7G_I';
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
