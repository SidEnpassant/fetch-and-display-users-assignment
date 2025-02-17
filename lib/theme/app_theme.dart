import 'package:flutter/material.dart';

class AppTheme {
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF6C72CB), Color(0xFF89CFF0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF6C72CB),
      secondary: Color(0xFF89CFF0),
      surface: Colors.grey[900]!,
      background: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
