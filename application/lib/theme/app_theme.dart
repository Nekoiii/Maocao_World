import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 12.0),
      bodyMedium: TextStyle(fontSize: 18.0),
    ),
  );

  static final ThemeData darkTheme = ThemeData();
}
