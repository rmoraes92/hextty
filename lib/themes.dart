import 'package:flutter/material.dart';

class NeoBrutalistTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: Color(0xFF000000), // Stark black
        secondary: Color(0xFFFF4D4D), // Vibrant red
        background: Color(0xFFF5F5F5), // Light gray background
        surface: Colors.white,
        error: Color(0xFFFF0000),
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        color: Colors.black,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: .5),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: -1,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3),
          borderRadius: BorderRadius.zero,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Colors.black, width: 2),
          ),
          elevation: 4,
          shadowColor: Colors.black.withValues(alpha: .5),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.black, width: 2),
        ),
        shadowColor: Colors.black.withValues(alpha: .5),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        side: BorderSide(color: Colors.black, width: 2),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.black;
          }
          return Colors.white;
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: Colors.black,
        labelStyle: TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: Colors.black,
        thickness: 2,
        space: 1,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: Color(0xFFF5F5F5),

      // Typography
      typography: Typography.material2021(),
    );
  }

  // Optional: Dark Theme with similar NeoBrutalist principles
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFFF4D4D), // Vibrant red
        secondary: Color(0xFF00FF00), // Bright green
        // gitbackground: Color(0xFF121212),
        surface: Color(0xFF1E1E1E),
        error: Color(0xFFFF0000),
      ),
      // ... similar configuration to lightTheme, with dark color adjustments
    );
  }
}
