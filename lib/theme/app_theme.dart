import 'package:flutter/material.dart';

class AppTheme {
  // ChatGPT Signature Colors
  static const Color primaryColor = Color(0xFF10A37F);       // OpenAI Emerald Green
  static const Color primaryLight = Color(0xFF19C37D);       // Hover / Glow Green
  static const Color primaryDark = Color(0xFF0E8466);        // Deep Forest Green
  static const Color primaryGlow = Color(0x3310A37F);        // 20% Alpha Emerald Glow
  
  // Background & Surface Tokens
  static const Color backgroundColor = Color(0xFF0D0D0D);    // Deep Canvas Black
  static const Color surfaceColor = Color(0xFF171717);       // ChatGPT Sidebar / Surface Tone
  static const Color cardColor = Color(0xFF212121);          // ChatGPT Message Box / Card Tone
  static const Color elevatedColor = Color(0xFF2A2A2A);      // Hover & Elevated Panels
  
  // Clean Precision Borders
  static const Color borderColor = Color(0xFF2F2F2F);        // Clean Subtle Border
  static const Color borderSubtle = Color(0xFF383838);       // Delineation Stroke
  static const Color borderHighlight = Color(0xFF4A4A4A);    // Focused / Active Border
  
  // Typography Colors
  static const Color textPrimary = Color(0xFFECECF1);        // High-contrast Crisp White
  static const Color textSecondary = Color(0xFF9CA3AF);      // Clean Modern Muted Grey
  static const Color textDim = Color(0xFF6E6E80);            // Captions & Placeholders
  
  // Functional Accent Colors
  static const Color success = Color(0xFF10B981);            // Mint Success
  static const Color warning = Color(0xFFF59E0B);            // Amber Warning
  static const Color error = Color(0xFFEF4444);              // Coral Red
  static const Color aiCyan = Color(0xFF38BDF8);             // Electric AI Cyan

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        primaryContainer: Color(0xFF15332A),
        secondary: primaryLight,
        surface: surfaceColor,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: textPrimary, size: 20),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          color: textDim,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderColor, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: borderSubtle, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        hintStyle: const TextStyle(color: textDim, fontSize: 14),
        labelStyle: const TextStyle(color: textSecondary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 1),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        elevation: 0,
        indicatorColor: primaryGlow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor, size: 22);
          }
          return const IconThemeData(color: textSecondary, size: 22);
        }),
      ),
      tabBarTheme: const TabBarThemeData(
        dividerColor: borderColor,
        indicatorColor: primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: textPrimary,
        unselectedLabelColor: textSecondary,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Alias for backward compatibility
  static ThemeData get lightTheme => darkTheme;
}
