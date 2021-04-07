import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const red = Color(0xFFEC1D24);
const lightRed = Color(0xFFEF9A9A);
const white = Colors.white;
const black = Colors.black;
const grey = Color(0xFF202020);
const lightGrey = Color(0xFF757575);
const lightBlue = Color(0xFF90CAF9);
const lightYellow = Color(0xFFFFF59D);
const lightGreen = Color(0xFFA5D6A7);

setStatusBarTheme({
  Color? color = white,
  Brightness? brightness = Brightness.dark,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness,
    ),
  );
}

setSystemNavigationTheme({
  Color? color = white,
  Brightness? brightness = Brightness.dark,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      systemNavigationBarIconBrightness: brightness,
    ),
  );
}

ThemeData lightThemeData() {
  return ThemeData(
    primaryColor: white,
    accentColor: red,
    brightness: Brightness.light,
    fontFamily: 'Oswald',
    textTheme: _textTheme(),
    elevatedButtonTheme: _elevatedButtonTheme(),
    snackBarTheme: _snackbarTheme(),
  );
}

ThemeData darkThemeData() {
  return ThemeData(
    primaryColor: black,
    accentColor: red,
    brightness: Brightness.dark,
    fontFamily: 'Oswald',
    textTheme: _textTheme(),
    elevatedButtonTheme: _elevatedButtonTheme(),
    snackBarTheme: _snackbarTheme(),
  );
}

TextTheme _textTheme() {
  return TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      color: black,
      fontWeight: FontWeight.bold,
      height: 1.2,
      decoration: TextDecoration.none,
    ),
    bodyText1: TextStyle(
      fontSize: 22,
      color: black,
      fontWeight: FontWeight.normal,
      height: 1.4,
      decoration: TextDecoration.none,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.4,
      decoration: TextDecoration.none,
    ),
    subtitle2: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      height: 1.4,
      decoration: TextDecoration.none,
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: red,
      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 13),
      textStyle: TextStyle(
        fontSize: 18,
        color: white,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    ),
  );
}

SnackBarThemeData _snackbarTheme() {
  return SnackBarThemeData(
    backgroundColor: red,
    actionTextColor: white,
    contentTextStyle: TextStyle(
      color: white,
      fontSize: 18,
    ),
  );
}
