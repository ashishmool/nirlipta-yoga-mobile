import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF9B6763);
const Color secondaryColor = Color(0xFFB8978C);

class AppTheme {
  AppTheme._();

  static ThemeData getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      secondaryHeaderColor: secondaryColor,
      scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.grey[200],
      fontFamily: 'Montserrat Regular',

      // Progress Indicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: primaryColor,
        elevation: 4,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),

      // TextField Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: primaryColor, width: 2.0),
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.white : primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondaryColor,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(primaryColor),
        fillColor: WidgetStateProperty.all(
          isDarkMode ? Colors.black : Colors.white,
        ),
        side: WidgetStateBorderSide.resolveWith((states) {
          return BorderSide(
            color: primaryColor,
            width: 2,
          );
        }),
      ),
    );
  }
}
