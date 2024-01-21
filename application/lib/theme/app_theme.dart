import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 12.0),
      bodyText2: TextStyle(fontSize: 18.0),
    ),
  );

  static final ThemeData darkTheme = ThemeData();
}
