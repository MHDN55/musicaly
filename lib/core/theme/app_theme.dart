import 'package:flutter/material.dart';

enum AppTheme {
  dark("Dark"),
  light("Light");

  const AppTheme(this.name);
  final String name;
}

final appThemeData = {
  AppTheme.dark: ThemeData(
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade600,
      secondary: const Color.fromARGB(255, 50, 50, 50),
      inversePrimary: Colors.grey.shade300,
      tertiary: Colors.black,
      tertiaryContainer: Colors.grey.shade800,
    ),
  ),
  AppTheme.light: ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      inversePrimary: Colors.grey.shade900,
      tertiary: Colors.grey.shade500,
      tertiaryContainer: Colors.grey.shade200,
    ),
  ),
};
