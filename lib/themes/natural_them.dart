import 'package:flutter/material.dart';

ThemeData natureTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFF0F7EE), // Same as background for consistency
    primary: Color(0xFF2C6E49), // Deep Green
    secondary: Color(0xFFA7C4A0), // Sage Green
    tertiary: Color(0xFFFFD166), // Warm Yellow
    inversePrimary: Color(0xFF1B3A4B), // Dark Blue
  ),
  scaffoldBackgroundColor: Color(0xFFF0F7EE),

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF2C6E49), // Deep Green
    foregroundColor: Colors.white,
    elevation: 4,
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  // Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF2C6E49), // Deep Green
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF2C6E49), // Deep Green
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),

  // Floating Action Button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFD166), // Warm Yellow
    foregroundColor: Color(0xFF1B3A4B), // Dark Blue
  ),

  // Text Theme
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B3A4B)), // Dark Blue
    displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C6E49)), // Deep Green
    bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF1B3A4B)), // Dark Blue
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF2C6E49)), // Deep Green
  ),

  // Input Decoration Theme (for chat text fields, forms, etc.)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor:
        Color(0xFFA7C4A0).withOpacity(0.2), // Light Sage Green background
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF2C6E49)), // Deep Green
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFFD166), width: 2), // Warm Yellow
    ),
    hintStyle: TextStyle(
        color: Color(0xFF1B3A4B).withOpacity(0.6)), // Dark Blue with opacity
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: Color(0xFFFFFFFF), // White card with soft shadows
    shadowColor: Colors.black26,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // SnackBar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFF2C6E49), // Deep Green
    contentTextStyle: TextStyle(fontSize: 16, color: Colors.white),
    actionTextColor: Color(0xFFFFD166), // Warm Yellow
  ),

  // Dialog Theme
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFFF0F7EE), // Soft Cream
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B3A4B)), // Dark Blue
    contentTextStyle:
        TextStyle(fontSize: 16, color: Color(0xFF2C6E49)), // Deep Green
  ),
);
