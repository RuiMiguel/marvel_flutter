import 'package:api_client/src/model/api_comic.dart';
import 'package:api_client/src/model/api_result.dart';
import 'package:comic_repository/src/mapper/mapper.dart';
import 'package:domain/src/model/comic.dart';
import 'package:domain/src/model/data_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Mapper', () {
    group('on ApiResult', () {
      const apiResult = ApiResult<ApiComic>(
        code: 1,
        status: 'status',
        copyright: 'copyright',
        attributionText: 'attributionText',
        attributionHTML: 'attributionHTML',
        etag: 'etag',
        data: ApiData<ApiComic>(),
      );

      test('toDataResult', () {
        expect(
          apiResult.toResultComic(),
          isA<DataResult<Comic>>()
            ..having((e) => e.code, 'code', 1)
            ..having((e) => e.status, 'status', 'status')
            ..having((e) => e.copyright, 'copyright', 'copyright')
            ..having(
              (e) => e.attributionText,
              'attributionText',
              'attributionText',
            )
            ..having(
              (e) => e.attributionHTML,
              'attributionHTML',
              'attributionHTML',
            )
            ..having((e) => e.etag, 'etag', 'etag')
            ..having((e) => e.data, 'data', isA<Data<Comic>>()),
        );
      });
    });

    group('on ApiData', () {
      const apiData = ApiData<ApiComic>(
        offset: 1,
        limit: 2,
        total: 3,
        count: 4,
        results: [
          ApiComic(),
        ],
      );

      test('toDataComic', () {
        expect(
          apiData.toDataComic(),
          isA<Data<Comic>>()
            ..having((e) => e.offset, 'offset', 1)
            ..having((e) => e.limit, 'limit', 2)
            ..having((e) => e.total, 'total', 3)
            ..having((e) => e.count, 'count', 4)
            ..having((e) => e.results, 'results', isA<List<Comic>>())
            ..having((e) => e.results, 'results', isNotEmpty),
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
            ..having((e) => e.path, 'path', 'path')
            ..having((e) => e.extension, 'extension', 'extension'),
        );
      });
    });

    group('on ApiTextObject', () {
      const apiTextObject = ApiTextObject(
        type: 'type',
        language: 'language',
        text: 'text',
      );

      test('toTextObject', () {
        expect(
          apiTextObject.toTextObject(),
          isA<TextObject>()
            ..having((e) => e.type, 'type', 'type')
            ..having((e) => e.language, 'language', 'language')
            ..having((e) => e.text, 'text', 'text'),
        );
      });
    });

    group('on ApiComicUrl', () {
      test('toComicUrl', () {
        const apiComicUrl = ApiComicUrl(type: 'type', url: 'url');

        expect(
          apiComicUrl.toComicUrl(),
          isA<ComicUrl>()
            ..having((e) => e.type, 'type', 'type')
            ..having((e) => e.url, 'url', 'url'),
        );
      });
    });

    group('on ApiPrice', () {
      test('toPrice', () {
        const apiPrice = ApiPrice(type: 'type', price: 9.99);

        expect(
          apiPrice.toPrice(),
          isA<Price>()
            ..having((e) => e.type, 'type', 'type')
            ..having((e) => e.price, 'price', 9.99),
        );
      });
    });

    group('on ApiComicImage', () {
      const apiImage = ApiComicImage(path: 'path', extension: 'extension');

      test('toComicImage', () {
        expect(
          apiImage.toComicImage(),
          isA<ComicImage>()
            ..having((e) => e.path, 'path', 'path')
            ..having((e) => e.extension, 'extension', 'extension'),
        );
      });
    });

    group('on ApiComic', () {
      const apiComic = ApiComic(
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
        pageCount: 4,
        textObjects: [
          ApiTextObject(),
        ],
        urls: [
          ApiComicUrl(),
        ],
        prices: [
          ApiPrice(),
        ],
        thumbnail: ApiThumbnail(),
        images: [
          ApiComicImage(),
        ],
      );

      test('toComic', () {
        expect(
          apiComic.toComic(),
          isA<Comic>()
            ..having((e) => e.id, 'id', 1)
            ..having((e) => e.digitalId, 'digitalId', 2)
            ..having((e) => e.title, 'title', 'title')
            ..having((e) => e.issueNumber, 'issueNumber', 3)
            ..having(
              (e) => e.variantDescription,
              'variantDescription',
              'variantDescription',
            )
            ..having((e) => e.description, 'description', 'description')
            ..having((e) => e.modified, 'modified', 'modified')
            ..having((e) => e.isbn, 'isbn', 'isbn')
            ..having((e) => e.upc, 'upc', 'upc')
            ..having((e) => e.diamondCode, 'diamondCode', 'diamondCode')
            ..having((e) => e.ean, 'ean', 'ean')
            ..having((e) => e.issn, 'issn', 'issn')
            ..having((e) => e.format, 'format', 'format')
            ..having((e) => e.pageCount, 'pageCount', 4)
            ..having(
              (e) => e.textObjects,
              'textObjects',
              isA<List<TextObject>>(),
            )
            ..having((e) => e.urls, 'urls', isA<List<ComicUrl>>())
            ..having((e) => e.prices, 'prices', isA<List<Price>>())
            ..having((e) => e.thumbnail, 'thumbnail', isA<ComicImage>())
            ..having((e) => e.images, 'images', isA<ComicImage>()),
        );
      });
    });
  });
}
