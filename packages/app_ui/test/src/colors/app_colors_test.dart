import 'package:app_ui/src/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    test('colors are correct', () async {
      expect(
        AppColors.red.value,
        0xFFEC1D24,
      );
      expect(
        AppColors.lightRed.value,
        0xFFEF9A9A,
      );
      expect(
        AppColors.white.value,
        Colors.white.value,
      );
      expect(
        AppColors.black.value,
        Colors.black.value,
      );
      expect(
        AppColors.grey.value,
        0xFF202020,
      );
      expect(
        AppColors.lightGrey.value,
        0xFF757575,
      );
      expect(
        AppColors.blue.value,
        0xFF1E88E5,
      );
      expect(
        AppColors.lightBlue.value,
        0xFF90CAF9,
      );
      expect(
        AppColors.yellow.value,
        0xFFFDD835,
      );
      expect(
        AppColors.lightYellow.value,
        0xFFFFF59D,
      );
      expect(
        AppColors.green.value,
        0xFF66BB6A,
      );
      expect(
        AppColors.lightGreen.value,
        0xFFA5D6A7,
      );
      expect(
        AppColors.red.value,
        0xFFEC1D24,
      );
    });

    group('SectionColor', () {
      test('gets correct color for each enum', () async {
        expect(
          Section.characters.color,
          AppColors.lightBlue,
        );
        expect(
          Section.comics.color,
          AppColors.lightGreen,
        );
        expect(
          Section.series.color,
          AppColors.lightYellow,
        );
        expect(
          Section.stories.color,
          AppColors.lightRed,
        );
      });
    });
  });
}
