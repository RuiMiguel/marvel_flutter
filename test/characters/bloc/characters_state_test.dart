// ignore_for_file: prefer_const_constructors

import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/bloc/characters_bloc.dart';

void main() {
  group('CharactersState', () {
    test('can be instantiated', () {
      expect(CharactersState.initial(), isNotNull);
    });

    test('has correct status', () {
      final state = CharactersState.initial();
      expect(state.status, CharactersStatus.initial);
      expect(state.characters, isEmpty);
      expect(state.count, 0);
      expect(state.total, 0);
      expect(state.offset, 0);
      expect(state.legal, '');
    });

    group('copyWith', () {
      test('returns same object when no properties', () {
        expect(
          CharactersState.initial().copyWith(),
          CharactersState.initial(),
        );
      });

      test('returns object with updated status when all parameters are passed',
          () {
        final characters = [
          Character(
            id: 1,
            name: 'name',
            description: 'description',
            modified: 'modified',
            resourceURI: 'resourceURI',
            urls: [],
            thumbnail: Thumbnail(
              path: 'path',
              extension: 'extension',
            ),
          ),
        ];

        expect(
          CharactersState.initial().copyWith(
            status: CharactersStatus.success,
            characters: characters,
            count: 5,
            total: 10,
            offset: 5,
            legal: 'legal',
          ),
          CharactersState(
            status: CharactersStatus.success,
            characters: characters,
            count: 5,
            total: 10,
            offset: 5,
            legal: 'legal',
          ),
        );
      });
    });
  });

  group('CharactersStatusX', () {
    test('CharactersStatus.initial isInitial is true', () {
      const status = CharactersStatus.initial;

      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('CharactersStatus.loading isLoading is true', () {
      const status = CharactersStatus.loading;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('CharactersStatus.success isSuccess is true', () {
      const status = CharactersStatus.success;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isError, isFalse);
    });

    test('CharactersStatus.error isError is true', () {
      const status = CharactersStatus.error;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isTrue);
    });
  });
}
