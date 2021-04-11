import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marvel/styles/colors.dart';

setStatusBarTheme({
  Color? color = white,
  Brightness? brightness = Brightness.light,
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
  Brightness? brightness = Brightness.light,
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
    shadowColor: lightGrey,
    brightness: Brightness.light,
    fontFamily: 'Oswald',
    textTheme: _lightTextTheme(),
    elevatedButtonTheme: _elevatedButtonTheme(),
    snackBarTheme: _snackbarTheme(),
  );
}

ThemeData darkThemeData() {
  return ThemeData(
    primaryColor: black,
    accentColor: red,
    shadowColor: grey,
    brightness: Brightness.dark,
    fontFamily: 'Oswald',
    textTheme: _darkTextTheme(),
    elevatedButtonTheme: _elevatedButtonTheme(),
    snackBarTheme: _snackbarTheme(),
  );
}

TextTheme _lightTextTheme() {
  return _textTheme(black);
}

TextTheme _darkTextTheme() {
  return _textTheme(white);
}

TextTheme _textTheme(Color textColor) {
  return TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      color: textColor,
      fontWeight: FontWeight.bold,
      height: 1.2,
      decoration: TextDecoration.none,
    ),
    bodyText1: TextStyle(
      fontSize: 22,
      color: textColor,
      fontWeight: FontWeight.normal,
      height: 1.4,
      decoration: TextDecoration.none,
    ),
    bodyText2: TextStyle(
      fontSize: 20,
      color: textColor,
      fontWeight: FontWeight.bold,
      height: 1.4,
      decoration: TextDecoration.none,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      color: textColor,
      fontWeight: FontWeight.normal,
      height: 1.4,
      decoration: TextDecoration.none,
    ),
    subtitle2: TextStyle(
      fontSize: 10,
      color: textColor,
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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      textStyle: TextStyle(
        fontSize: 20,
        color: white,
        fontFamily: 'Oswald',
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
