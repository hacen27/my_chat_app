import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.orange,
    onPrimary: Color(0xFF505050),
    secondary: Color(0xFFBBBBBB),
    onSecondary: Color(0xFFEAEAEA),
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    background: Color(0xFFF1F2F3),
    onBackground: Color(0xFFFFFFFF),
    surface: Color(0xFF54B435),
    onSurface: Color(0xFF54B435),
    primaryContainer: Color(0xDD000000),
    tertiary: Color(0xFF000000),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    bodyLarge: TextStyle(
        fontSize: 16.5, fontWeight: FontWeight.w700, color: Colors.black87),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
    bodySmall: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black54),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 1,
    backgroundColor: Colors.orange,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: Colors.orange,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    focusColor: Colors.orange,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.orange,
        width: 2,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: Colors.blueGrey),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: Colors.black87),
    ),
  ),
  primaryColor: Colors.orange,
);
