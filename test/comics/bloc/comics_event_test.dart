// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/comics/bloc/comics_bloc.dart';

void main() {
  group('ComicsEvent', () {
    group('ComicsLoaded', () {
      test('supports equality comparisons', () {
        expect(
          ComicsLoaded(),
          equals(ComicsLoaded()),
        );
      });
    });

    group('ComicsGotMore', () {
      test('supports equality comparisons', () {
        expect(
          ComicsGotMore(),
          equals(ComicsGotMore()),
        );
      });
    });
  });
}
