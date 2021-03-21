import 'package:flutter/material.dart';

ThemeData lightThemeData() {
  return ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.red,
    brightness: Brightness.light,
    fontFamily: 'Oswald',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    ),
  );
}

ThemeData darkThemeData() {
  return ThemeData(
    primaryColor: Colors.black,
    accentColor: Colors.red,
    brightness: Brightness.dark,
    fontFamily: 'Oswald',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    ),
  );
}
