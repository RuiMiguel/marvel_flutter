// ignore_for_file: prefer_const_constructors

import 'package:domain/src/model/comic.dart';
import 'package:domain/src/model/data_result.dart';
import 'package:test/test.dart';

void main() {
  group('Comic', () {
    test('can be instantiated', () {
      expect(
        Comic(
          id: 1,
          digitalId: 2,
          title: 'title',
          issueNumber: 3,
          variantDescription: 'variantDescription',
          description: 'description',
          modified: 'modified',
          isbn: 'isbn',
          upc: 'upc',
          diamondCode: 'diamondCode',
          ean: 'ean',
          issn: 'issn',
          format: 'format',
          pageCount: 3,
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
        isNotNull,
      );
    });
  });

  group('TextObject', () {
    test('can be instantiated', () {
      expect(
        TextObject(
          type: 'type',
          language: 'language',
          text: 'text',
        ),
        isNotNull,
      );
    });
  });

  group('ComicUrl', () {
    test('can be instantiated', () {
      expect(
        ComicUrl(
          type: 'type',
          url: 'url',
        ),
        isNotNull,
      );
    });
  });

  group('Price', () {
    test('can be instantiated', () {
      expect(
        Price(
          type: 'type',
          price: 0.99,
        ),
        isNotNull,
      );
    });
  });

  group('ComicImage', () {
    test('can be instantiated', () {
      expect(
        ComicImage(
          path: 'path',
          extension: 'extension',
        ),
        isNotNull,
      );
    });
  });
}
