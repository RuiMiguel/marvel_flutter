import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color red = Color(0xFFEC1D24);
  static const Color lightRed = Color(0xFFEF9A9A);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF202020);
  static const Color lightGrey = Color(0xFF757575);
  static const Color blue = Color(0xFF1E88E5);
  static const Color lightBlue = Color(0xFF90CAF9);
  static const Color yellow = Color(0xFFFDD835);
  static const Color lightYellow = Color(0xFFFFF59D);
  static const Color green = Color(0xFF66BB6A);
  static const Color lightGreen = Color(0xFFA5D6A7);
}

enum Section { characters, comics, series, stories }

extension SectionColor on Section {
  Color get color {
    switch (this) {
      case Section.characters:
        return AppColors.lightBlue;
      case Section.comics:
        return AppColors.lightGreen;
      case Section.series:
        return AppColors.lightYellow;
      case Section.stories:
        return AppColors.lightRed;
    }
  }
}
