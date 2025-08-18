import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF0F1014),
  primaryColor: Color(0xFF239BAF),
  focusColor: Colors.white,
  highlightColor: Color(0xFF239BAF).withAlpha(45),
  splashColor: Color(0xFF239BAF).withAlpha(45),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.focused)) {
          return Colors.white; // Focused = white background
        }
        return Colors.transparent; // Unfocused = transparent
      }),
      side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: Colors.transparent); // No border on focus
        }
        return BorderSide(color: Colors.white); // White border when unfocused
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.focused)) {
          return Color(0xFF0F1014); // Text/Icon black when focused
        }
        return Colors.white; // Text/Icon white when unfocused
      }),
      iconSize: WidgetStateProperty.all(24),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      animationDuration: Duration(milliseconds: 50),
      minimumSize: WidgetStateProperty.all(Size.zero),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.focused)) {
          return Colors.white; // Focused = white background
        }
        return Colors.transparent; // Unfocused = transparent
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.focused)) {
          return const Color(0xFF0F1014); // Icon black when focused
        }
        return Colors.white; // Icon white when unfocused
      }),
      iconSize: WidgetStateProperty.all(24),
      animationDuration: const Duration(milliseconds: 50),
      minimumSize: WidgetStateProperty.all(Size.zero),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            64,
          ), // match outlined button shape
        ),
      ),

      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.black.withAlpha(42); // Splash effect
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.black.withAlpha(20); // Hover effect for web/desktop
        }
        return null;
      }),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF239BAF), width: 2),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
  cardColor: Color(0xFF0F1726),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    headlineMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    titleLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),

    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.white70),

    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF239BAF),
    ),
    labelMedium: TextStyle(fontSize: 12.0, color: Color(0xFF239BAF)),
    labelSmall: TextStyle(fontSize: 10.0, color: Color(0xFF239BAF)),
  ),
);
