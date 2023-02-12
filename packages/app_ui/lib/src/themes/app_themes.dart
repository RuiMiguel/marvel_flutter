import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  ColorScheme get colorScheme => const ColorScheme.light(
        primary: AppColors.black,
        background: AppColors.lightGrey,
        shadow: AppColors.grey,
      );

  ThemeData get themeData {
    return ThemeData(
      primaryColor: colorScheme.primary,
      shadowColor: colorScheme.shadow,
      brightness: colorScheme.brightness,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonThemeData,
      snackBarTheme: _snackbarThemeData,
    );
  }

  TextTheme get _textTheme {
    final baseTextStyle = TextStyle(
      package: 'app_ui',
      fontFamily: FontFamily.oswald,
      fontWeight: FontWeight.normal,
      color: colorScheme.primary,
      decoration: TextDecoration.none,
    );

    return TextTheme(
      displayLarge: baseTextStyle.copyWith(
        fontSize: 30,
        height: 1.2,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: baseTextStyle.copyWith(
        fontSize: 24,
        height: 1.2,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: baseTextStyle.copyWith(
        fontSize: 22,
        height: 1.4,
      ),
      bodyMedium: baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
      titleMedium: baseTextStyle.copyWith(
        fontSize: 16,
        height: 1.4,
      ),
      titleSmall: baseTextStyle.copyWith(
        fontSize: 10,
        height: 1.4,
      ),
    ).apply(
      bodyColor: colorScheme.primary,
      displayColor: colorScheme.primary,
      decorationColor: colorScheme.primary,
      package: 'app_ui',
      fontFamily: FontFamily.oswald,
    );
  }

  ElevatedButtonThemeData get _elevatedButtonThemeData {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.red,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: _textTheme.bodyMedium?.copyWith(
          color: AppColors.white,
        ),
      ),
    );
  }

  SnackBarThemeData get _snackbarThemeData {
    return SnackBarThemeData(
      backgroundColor: AppColors.red,
      actionTextColor: AppColors.white,
      contentTextStyle: _textTheme.titleMedium?.copyWith(
        color: AppColors.white,
      ),
    );
  }
}

class AppDarkTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => const ColorScheme.dark(
        primary: AppColors.white,
        background: AppColors.grey,
        shadow: AppColors.lightGrey,
      );
}

extension ThemeDataX on ThemeData {
  void setStatusBarTheme({
    Color? color = AppColors.white,
    Brightness? brightness = Brightness.light,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: brightness,
      ),
    );
  }

  void setSystemNavigationTheme({
    Color? color = AppColors.white,
    Brightness? brightness = Brightness.light,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: color,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
  }
}
