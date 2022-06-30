// ignore_for_file: prefer_const_constructors
import 'package:api_client/api_client.dart';
import 'package:comic_repository/src/comic_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockComicService extends Mock implements ComicService {}

void main() {
  late ComicService comicService;
  late ComicRepository comicRepository;

  setUpAll(() {
    comicService = _MockComicService();
  });

  group('ComicRepository', () {
    test('can be instantiated', () {
      expect(ComicRepository(comicService), isNotNull);
    });

    group('getComicsResult', () {
      setUp(() {
        comicRepository = ComicRepository(comicService);
      });

      test('throws Exception when comicService fails', () async {
        when(
          () => comicService.getComicsResult(any(), any()),
        ).thenThrow(Exception());

        expect(
          comicRepository.getComicsResult(1, 1),
          throwsA(isA<Exception>()),
        );
      });

      test(
        'returns DataResult<Comic> '
        'when comicService responses ApiResult<ApiComic>',
        () async {
          when(
            () => comicService.getComicsResult(any(), any()),
          ).thenAnswer((_) async => ApiResult<ApiComic>());

          expect(
            await comicRepository.getComicsResult(1, 1),
            isA<DataResult<Comic>>(),
          );
        },
      );
    });
  });
}
