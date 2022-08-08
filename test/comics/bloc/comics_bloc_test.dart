// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:comic_repository/comic_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/comics/bloc/comics_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockComicRepository extends Mock implements ComicRepository {}

void main() {
  final exception = ServerException('error');

  DataResult<Comic> _fakeDataResult({
    required int count,
    required int limit,
    required int offset,
    required int total,
  }) {
    return DataResult<Comic>(
      code: 1,
      status: 'status',
      copyright: 'copyright',
      attributionText: 'attributionText',
      attributionHTML: 'attributionHTML',
      data: Data<Comic>(
        count: count,
        limit: limit,
        offset: offset,
        total: total,
        results: List.generate(
          count,
          (index) => Comic(
            id: index,
            digitalId: index,
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
        ),
      ),
      etag: 'etag',
    );
  }

  group('ComicsBloc', () {
    late ComicRepository comicsRepository;

    setUp(() {
      comicsRepository = _MockComicRepository();
    });

    group('ComicsLoaded', () {
      final dataComic = _fakeDataResult(
        count: 50,
        limit: 50,
        offset: 0,
        total: 100,
      );

      blocTest<ComicsBloc, ComicsState>(
        'emits [loading, success] '
        'when getComicsResult succeeded',
        setUp: () {
          when(
            () => comicsRepository.getComicsResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => dataComic);
        },
        build: () => ComicsBloc(
          comicsRepository: comicsRepository,
        ),
        act: (bloc) => bloc.add(ComicsLoaded()),
        expect: () => [
          isA<ComicsState>()
            ..having(
              (element) => element.status,
              'status',
              ComicsStatus.loading,
            ),
          isA<ComicsState>()
            ..having(
              (element) => element.status,
              'status',
              ComicsStatus.success,
            )
            ..having(
              (element) => element.count,
              'count',
              dataComic.data.count,
            )
            ..having(
              (element) => element.total,
              'total',
              dataComic.data.total,
            )
            ..having(
              (element) => element.offset,
              'offset',
              dataComic.data.offset,
            )
            ..having(
              (element) => element.legal,
              'legal',
              dataComic.attributionText,
            ),
        ],
      );

      blocTest<ComicsBloc, ComicsState>(
        'emits [loading, error] '
        'when getComicsResult fails',
        setUp: () {
          when(
            () => comicsRepository.getComicsResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenThrow(exception);
        },
        build: () => ComicsBloc(
          comicsRepository: comicsRepository,
        ),
        act: (bloc) => bloc.add(ComicsLoaded()),
        expect: () => [
          isA<ComicsState>()
            ..having(
              (element) => element.status,
              'status',
              ComicsStatus.loading,
            ),
          isA<ComicsState>()
            ..having(
              (element) => element.status,
              'status',
              ComicsStatus.error,
            )
            ..having(
              (element) => element.toString(),
              'error',
              equals('[ServerException] error'),
            ),
        ],
        errors: () => equals([exception]),
      );
    });

    group('ComicsGotMore', () {
      final dataComic = _fakeDataResult(
        offset: 50,
        limit: 50,
        count: 50,
        total: 130,
      );
      final newDataComic = _fakeDataResult(
        offset: 100,
        limit: 50,
        count: 30,
        total: 130,
      );

      blocTest<ComicsBloc, ComicsState>(
        'emits [loading, success] '
        'when getComicsResult succeeded',
        setUp: () {
          when(
            () => comicsRepository.getComicsResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => newDataComic);
        },
        build: () => ComicsBloc(
          comicsRepository: comicsRepository,
        ),
        act: (bloc) => bloc.add(ComicsGotMore()),
        seed: () => ComicsState(
          status: ComicsStatus.success,
          comics: dataComic.data.results,
          count: dataComic.data.count,
          total: dataComic.data.total,
          offset: dataComic.data.offset,
          legal: dataComic.attributionText,
        ),
        expect: () => [
          isA<ComicsState>().having(
            (element) => element.status,
            'status',
            ComicsStatus.loading,
          ),
          isA<ComicsState>()
              .having(
                (element) => element.status,
                'status',
                ComicsStatus.success,
              )
              .having(
                (element) => element.count,
                'count',
                newDataComic.data.count + newDataComic.data.offset,
              )
              .having(
                (element) => element.total,
                'total',
                newDataComic.data.total,
              )
              .having(
                (element) => element.offset,
                'offset',
                newDataComic.data.offset,
              )
              .having(
                (element) => element.legal,
                'legal',
                equals(newDataComic.attributionText),
              ),
        ],
      );

      blocTest<ComicsBloc, ComicsState>(
        'emits [loading, error] '
        'when getComicsResult fails',
        setUp: () {
          when(
            () => comicsRepository.getComicsResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenThrow(exception);
        },
        build: () => ComicsBloc(
          comicsRepository: comicsRepository,
        ),
        act: (bloc) => bloc.add(ComicsGotMore()),
        expect: () => [
          isA<ComicsState>()
            ..having(
              (element) => element.status,
              'status',
              ComicsStatus.loading,
            ),
          isA<ComicsState>()
            ..having(
              (element) => element.status,
              'status',
              ComicsStatus.error,
            )
            ..having(
              (element) => element.toString(),
              'error',
              equals('[ServerException] error'),
            ),
        ],
        errors: () => equals([exception]),
      );
    });
  });
}
