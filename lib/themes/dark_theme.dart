import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true, // Enables Material 3 design system
  scaffoldBackgroundColor: Color(0xFF2E073F), // Background Color

  // ✅ Custom Color Scheme
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFAD49E1), // Vibrant Purple
    onPrimary: Colors.white,
    secondary: Color(0xFF7A1CAC), // Deep Purple
    onSecondary: Colors.white,
    surface: Color(0xFFEBD3F8), // Light Purple
    onSurface: Colors.black87, // For contrast
    error: Colors.redAccent,
    onError: Colors.white,
    outline: Color(0xFFAD49E1), // Matching border outline
    inversePrimary: Color(0xFF7A1CAC), // Deep Purple for contrast
    inverseSurface: Color(0xFFAD49E1), // Vibrant Purple
    onInverseSurface: Colors.white,
  ),

  // ✅ AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF7A1CAC), // Deep Purple
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: TextStyle(
        fontFamily: "lufga",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white),
    centerTitle: true,
  ),

  // ✅ Text Theme (Using lufga Font)
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontFamily: "lufga",
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: "lufga",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white70),
    bodyLarge:
        TextStyle(fontFamily: "lufga", fontSize: 16, color: Colors.white70),
    bodyMedium:
        TextStyle(fontFamily: "lufga", fontSize: 14, color: Colors.white60),
    labelLarge: TextStyle(
        fontFamily: "lufga",
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white),
  ),

  // ✅ Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFAD49E1),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      textStyle: TextStyle(
          fontFamily: "lufga", fontSize: 16, fontWeight: FontWeight.w600),
      elevation: 2,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFAD49E1),
      textStyle: TextStyle(
          fontFamily: "lufga", fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFAD49E1),
      side: BorderSide(color: Color(0xFFAD49E1), width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),

  // ✅ FloatingActionButton Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFAD49E1),
    foregroundColor: Colors.white,
    elevation: 4,
  ),

  // ✅ Input Decoration Theme (for forms & chat input)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF7A1CAC), // Deep Purple
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFAD49E1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFAD49E1), width: 1.5),
    ),
    hintStyle: TextStyle(fontFamily: "lufga", color: Colors.white54),
    labelStyle: TextStyle(fontFamily: "lufga", color: Colors.white70),
  ),

  // ✅ Card Theme
  cardTheme: CardTheme(
    color: Color(0xFF7A1CAC), // Deep Purple
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  // ✅ Icon Theme
  iconTheme: IconThemeData(
    color: Colors.white70,
    size: 24,
  ),

  // ✅ Snackbar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFF7A1CAC),
    contentTextStyle:
        TextStyle(fontFamily: "lufga", color: Colors.white70, fontSize: 16),
    actionTextColor: Color(0xFFAD49E1),
  ),

  // ✅ Divider Theme
  dividerTheme: DividerThemeData(
    color: Color(0xFFAD49E1),
    thickness: 1,
  ),

  // ✅ Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2E073F),
    selectedItemColor: Color(0xFFAD49E1),
    unselectedItemColor: Colors.white60,
    showUnselectedLabels: true,
  ),

  
);
