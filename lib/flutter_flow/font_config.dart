import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontConfig {
  static const String primaryFont = 'Inter Tight';
  static const String fallbackFont = 'NotoSans';
  static const List<String> systemFallbacks = ['Arial', 'sans-serif'];

  // Create TextStyle with proper fallback handling
  static TextStyle createTextStyle({
    required Color color,
    required FontWeight fontWeight,
    required double fontSize,
    String? fontFamily,
    List<String>? fontFamilyFallback,
  }) {
    // Use system fonts to avoid AssetManifest.json issues in development
    return TextStyle(
      fontFamily: fontFamily ?? primaryFont,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontFamilyFallback: fontFamilyFallback ?? [fallbackFont, ...systemFallbacks],
    );
  }

  // Get theme with proper font configuration
  static ThemeData getTheme({
    required Brightness brightness,
    bool useMaterial3 = false,
  }) {
    return ThemeData(
      brightness: brightness,
      useMaterial3: useMaterial3,
      fontFamily: fallbackFont,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        displayMedium: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        displaySmall: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        headlineLarge: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        headlineMedium: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        headlineSmall: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        titleLarge: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        titleMedium: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        titleSmall: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        bodyLarge: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        bodyMedium: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        bodySmall: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        labelLarge: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        labelMedium: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
        labelSmall: TextStyle(fontFamily: fallbackFont, fontFamilyFallback: systemFallbacks),
      ),
    );
  }
}
