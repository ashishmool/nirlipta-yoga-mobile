import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: Color(0xFF9B6763),
    secondaryHeaderColor: Color(0xFFB8978C),
    scaffoldBackgroundColor: Colors.grey[200],
    fontFamily: 'Montserrat Regular',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Color(0xFF9B6763),
      elevation: 4,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat-Regular'),
        backgroundColor: Color(0xFF9B6763),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}
