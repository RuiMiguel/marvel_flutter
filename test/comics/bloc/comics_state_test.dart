// ignore_for_file: prefer_const_constructors

import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/comics/bloc/comics_bloc.dart';

void main() {
  group('ComicsState', () {
    test('can be instantiated', () {
      expect(ComicsState.initial(), isNotNull);
    });

    test('has correct status', () {
      final state = ComicsState.initial();
      expect(state.status, ComicsStatus.initial);
      expect(state.comics, isEmpty);
      expect(state.count, 0);
      expect(state.total, 0);
      expect(state.offset, 0);
      expect(state.legal, '');
    });

    group('copyWith', () {
      test('returns same object when no properties', () {
        expect(
          ComicsState.initial().copyWith(),
          ComicsState.initial(),
        );
      });

      test('returns object with updated status when all parameters are passed',
          () {
        final comics = [
          Comic(
            id: 1,
            digitalId: 1,
            title: 'title',
            issueNumber: 1,
            variantDescription: 'variantDescription',
            description: 'description',
            modified: 'modified',
            isbn: 'isbn',
            upc: 'upc',
            diamondCode: 'diamondCode',
            ean: 'ean',
            issn: 'issn',
            format: 'format',
            pageCount: 10,
            textObjects: [],
            resourceURI: 'resourceURI',
            urls: [],
            prices: [],
            thumbnail: Thumbnail(
              path: 'path',
              extension: 'extension',
            ),
            images: [],
          ),
        ];

        expect(
          ComicsState.initial().copyWith(
            status: ComicsStatus.success,
            comics: comics,
            count: 5,
            total: 10,
            offset: 5,
            legal: 'legal',
          ),
          ComicsState(
            status: ComicsStatus.success,
            comics: comics,
            count: 5,
            total: 10,
            offset: 5,
            legal: 'legal',
          ),
        );
      });
    });
  });

  group('ComicsStatusX', () {
    test('ComicsStatus.initial isInitial is true', () {
      const status = ComicsStatus.initial;

      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('ComicsStatus.loading isLoading is true', () {
      const status = ComicsStatus.loading;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('ComicsStatus.success isSuccess is true', () {
      const status = ComicsStatus.success;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isError, isFalse);
    });

    test('ComicsStatus.error isError is true', () {
      const status = ComicsStatus.error;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isTrue);
    });
  });
}
