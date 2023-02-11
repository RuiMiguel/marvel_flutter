import 'package:app_ui/src/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Colors', () {
    test('colors are correct', () async {
      expect(
        red.value,
        0xFFEC1D24,
      );
      expect(
        lightRed.value,
        0xFFEF9A9A,
      );
      expect(
        white.value,
        Colors.white.value,
      );
      expect(
        black.value,
        Colors.black.value,
      );
      expect(
        grey.value,
        0xFF202020,
      );
      expect(
        lightGrey.value,
        0xFF757575,
      );
      expect(
        blue.value,
        0xFF1E88E5,
      );
      expect(
        lightBlue.value,
        0xFF90CAF9,
      );
      expect(
        yellow.value,
        0xFFFDD835,
      );
      expect(
        lightYellow.value,
        0xFFFFF59D,
      );
      expect(
        green.value,
        0xFF66BB6A,
      );
      expect(
        lightGreen.value,
        0xFFA5D6A7,
      );
      expect(
        red.value,
        0xFFEC1D24,
      );
    });

    group('SectionColor', () {
      test('gets correct color for each enum', () async {
        expect(
          Section.characters.color,
          lightBlue,
        );
        expect(
          Section.comics.color,
          lightGreen,
        );
        expect(
          Section.series.color,
          lightYellow,
        );
        expect(
          Section.stories.color,
          lightRed,
        );
      });
    });
  });
}
