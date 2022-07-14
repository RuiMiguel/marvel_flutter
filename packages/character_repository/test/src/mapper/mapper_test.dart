import 'package:api_client/src/model/api_character.dart';
import 'package:api_client/src/model/api_result.dart';
import 'package:character_repository/src/mapper/mapper.dart';
import 'package:domain/src/model/character.dart';
import 'package:domain/src/model/data_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Mapper', () {
    group('on ApiResult', () {
      const apiResult = ApiResult<ApiCharacter>(
        code: 1,
        status: 'status',
        copyright: 'copyright',
        attributionText: 'attributionText',
        attributionHTML: 'attributionHTML',
        etag: 'etag',
        data: ApiData<ApiCharacter>(),
      );

      test('toDataResult', () {
        expect(
          apiResult.toResultCharacter(),
          isA<DataResult<Character>>()
              .having((e) => e.code, 'code', 1)
              .having((e) => e.status, 'status', 'status')
              .having((e) => e.copyright, 'copyright', 'copyright')
              .having(
                (e) => e.attributionText,
                'attributionText',
                'attributionText',
              )
              .having(
                (e) => e.attributionHTML,
                'attributionHTML',
                'attributionHTML',
              )
              .having((e) => e.etag, 'etag', 'etag')
              .having((e) => e.data, 'data', isA<Data<Character>>()),
        );
      });
    });

    group('on ApiData', () {
      const apiData = ApiData<ApiCharacter>(
        offset: 1,
        limit: 2,
        total: 3,
        count: 4,
        results: [
          ApiCharacter(),
        ],
      );

      test('toDataCharacter', () {
        expect(
          apiData.toDataCharacter(),
          isA<Data<Character>>()
              .having((e) => e.offset, 'offset', 1)
              .having((e) => e.limit, 'limit', 2)
              .having((e) => e.total, 'total', 3)
              .having((e) => e.count, 'count', 4)
              .having((e) => e.results, 'results', isA<List<Character>>())
              .having((e) => e.results, 'results', isNotEmpty),
        );
      });
    });

    group('on ApiThumbnail', () {
      const apiThumbnail = ApiThumbnail(
        path: 'path',
        extension: 'extension',
      );

      test('toThumbnail', () {
        expect(
          apiThumbnail.toThumbnail(),
          isA<Thumbnail>()
              .having((e) => e.path, 'path', 'path')
              .having((e) => e.extension, 'extension', 'extension'),
        );
      });
    });

    group('on ApiCharacterUrl', () {
      const apiCharacterUrl = ApiCharacterUrl(type: 'type', url: 'url');

      test('toCharacterUrl', () {
        expect(
          apiCharacterUrl.toCharacterUrl(),
          isA<CharacterUrl>()
              .having((e) => e.type, 'type', 'type')
              .having((e) => e.url, 'url', 'url'),
        );
      });
    });

    group('on ApiCharacter', () {
      const apiCharacter = ApiCharacter(
        id: 1,
        name: 'name',
        description: 'description',
        modified: 'modified',
        resourceURI: 'resourceURI',
        urls: [
          ApiCharacterUrl(),
        ],
        thumbnail: ApiThumbnail(),
      );

      test('toCharacter', () {
        expect(
          apiCharacter.toCharacter(),
          isA<Character>()
              .having((e) => e.id, 'id', 1)
              .having((e) => e.name, 'name', 'name')
              .having((e) => e.description, 'description', 'description')
              .having((e) => e.modified, 'modified', 'modified')
              .having((e) => e.resourceURI, 'resourceURI', 'resourceURI')
              .having((e) => e.urls, 'urls', isA<List<CharacterUrl>>())
              .having((e) => e.thumbnail, 'thumbnail', isA<Thumbnail>()),
        );
      });
    });

    group('on String', () {
      test('parseDate return parsed date if correct format', () {
        expect(
          '2014-04-29T14:18:17-0400'.parseDate(),
          equals('2014-04-29 18:18 PM'),
        );

        expect(
          '2020-04-29T06:34:19-0300'.parseDate(),
          equals('2020-04-29 09:34 AM'),
        );
      });

      test('parseDate return empty if null', () {
        expect(
          null.parseDate(),
          equals(''),
        );
      });

      test('parseDate return this if wrong format', () {
        expect(
          'not a date'.parseDate(),
          equals('not a date'),
        );
      });
    });
  });
}
