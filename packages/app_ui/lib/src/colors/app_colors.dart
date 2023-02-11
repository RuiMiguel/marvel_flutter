import 'package:flutter/material.dart';

const red = Color(0xFFEC1D24);
const lightRed = Color(0xFFEF9A9A);
const white = Colors.white;
const black = Colors.black;
const grey = Color(0xFF202020);
const lightGrey = Color(0xFF757575);
const blue = Color(0xFF1E88E5);
const lightBlue = Color(0xFF90CAF9);
const yellow = Color(0xFFFDD835);
const lightYellow = Color(0xFFFFF59D);
const green = Color(0xFF66BB6A);
const lightGreen = Color(0xFFA5D6A7);

enum Section { characters, comics, series, stories }

extension SectionColor on Section {
  Color get color {
    switch (this) {
      case Section.characters:
        return lightBlue;
      case Section.comics:
        return lightGreen;
      case Section.series:
        return lightYellow;
      case Section.stories:
        return lightRed;
    }
  }
}
