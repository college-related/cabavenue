import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color themeColor = Colors.white;
  static ThemeData main() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColor: themeColor,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: themeColor,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        headline2: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        subtitle2: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
