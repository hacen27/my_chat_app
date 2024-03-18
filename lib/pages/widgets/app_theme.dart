import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/widgets/app_pallete.dart';

class MyAppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppPallete.primaryColor,
      onPrimary: Color(0xFF505050),
      secondary: AppPallete.secondaryColor,
      onSecondary: Color(0xFFEAEAEA),
      error: AppPallete.errorColor,
      onError: Color(0xFFF32424),
      background: AppPallete.whiteColor,
      onBackground: AppPallete.transparentColor,
      surface: AppPallete.secondaryColor,
      onSurface: AppPallete.secondaryColor,
      primaryContainer: Color(0xDD000000),
      tertiary: Color(0xFF000000),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: AppPallete.titleLarge),
      titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppPallete.titleMedium),
      bodyLarge: TextStyle(
          fontSize: 16.5,
          fontWeight: FontWeight.w700,
          color: AppPallete.bodyLarge),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppPallete.bodyMedium),
      bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: AppPallete.bodySmall),
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: AppPallete.labelLarge),
    ),

    ///
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: AppPallete.backgroundColor,
      iconTheme: IconThemeData(color: AppPallete.secondaryColor),
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: AppPallete.secondaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(
        color: AppPallete.primaryColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppPallete.whiteColor,
          width: 2,
        ),
      ),
      focusColor: AppPallete.primaryColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppPallete.primaryColor,
          width: 2,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: AppPallete.disabledBorderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: AppPallete.enabledBorderColor),
      ),
    ),
    primaryColor: AppPallete.primaryColor,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xFFEAEAEA),
      onPrimary: Color(0xFF505050),
      secondary: AppPallete.whiteColor,
      onSecondary: Color(0xFFEAEAEA),
      error: AppPallete.errorColor,
      onError: Color(0xFFF32424),
      background: AppPallete.secondaryColor,
      onBackground: AppPallete.transparentColor,
      surface: Color(0xFF54B435),
      onSurface: Color(0xFF54B435),
      primaryContainer: Color(0xDD000000),
      tertiary: Color(0xFF000000),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: AppPallete.whiteColor),
      titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppPallete.whiteColor),
      bodyLarge: TextStyle(
          fontSize: 16.5,
          fontWeight: FontWeight.w700,
          color: AppPallete.whiteColor),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppPallete.whiteColor),
      bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: AppPallete.whiteColor),
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: AppPallete.whiteColor),
    ),

    ///
    appBarTheme: const AppBarTheme(
      elevation: 1,
      iconTheme: IconThemeData(color: AppPallete.secondaryColor),
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: AppPallete.secondaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(
        color: AppPallete.titleLarge,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppPallete.whiteColor,
          width: 2,
        ),
      ),
      focusColor: AppPallete.whiteColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppPallete.primaryColor,
          width: 2,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: AppPallete.disabledBorderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: AppPallete.enabledBorderColor),
      ),
    ),
    primaryColor: AppPallete.secondaryColor,
  );
}
