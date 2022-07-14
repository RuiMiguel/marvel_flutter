// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/bloc/characters_bloc.dart';

void main() {
  group('CharactersEvent', () {
    group('CharactersLoaded', () {
      test('supports equality comparisons', () {
        expect(
          CharactersLoaded(),
          equals(CharactersLoaded()),
        );
      });
    });

    group('CharactersGotMore', () {
      test('supports equality comparisons', () {
        expect(
          CharactersGotMore(),
          equals(CharactersGotMore()),
        );
      });
    });
  });
}
