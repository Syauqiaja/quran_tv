import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF0F1014),
  primaryColor: Color(0xFF239BAF),
  focusColor: Color(0xFF239BAF),
  highlightColor: Color(0xFF239BAF).withAlpha(45),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 20.0, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 18.0, color: Colors.white70),
    bodySmall: TextStyle(fontSize: 16.0, color: Colors.white60),
    labelLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF239BAF)),
    labelMedium: TextStyle(fontSize: 16.0, color: Color(0xFF239BAF)),
    labelSmall: TextStyle(fontSize: 14.0, color: Color(0xFF239BAF)),
  ),
);