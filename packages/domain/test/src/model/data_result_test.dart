// ignore_for_file: prefer_const_constructors

import 'package:domain/src/model/character.dart';
import 'package:domain/src/model/data_result.dart';
import 'package:test/test.dart';

void main() {
  group('DataResult', () {
    test('can be instantiated', () {
      expect(
        DataResult<void>.empty(),
        isNotNull,
      );

      expect(
        DataResult<void>(
          code: 1,
          status: 'status',
          copyright: 'copyright',
          attributionText: 'attributionText',
          attributionHTML: 'attributionHTML',
          etag: 'etag',
          data: Data.empty(),
        ),
        isNotNull,
      );
    });
  });

  group('Data', () {
    test('can be instantiated', () {
      expect(
        Data<void>.empty(),
        isNotNull,
      );

      expect(
        Data<void>(
          offset: 1,
          limit: 2,
          total: 3,
          count: 4,
          results: [],
        ),
        isNotNull,
      );
    });
  });

  group('Thumbnail', () {
    test('can be instantiated', () {
      expect(
        Thumbnail(
          path: 'path',
          extension: 'extension',
        ),
        isNotNull,
      );
    });
  });
}
