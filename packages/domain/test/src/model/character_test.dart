// ignore_for_file: prefer_const_constructors

import 'package:domain/src/model/character.dart';
import 'package:domain/src/model/data_result.dart';
import 'package:test/test.dart';

void main() {
  group('Character', () {
    test('can be instantiated', () {
      expect(
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
        isNotNull,
      );
    });
  });

  group('CharacterUrl', () {
    test('can be instantiated', () {
      expect(
        CharacterUrl(
          type: 'type',
          url: 'url',
        ),
        isNotNull,
      );
    });
  });
}
