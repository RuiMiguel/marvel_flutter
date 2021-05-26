import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/bloc/comics/comics_bloc.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:mocktail/mocktail.dart';

class MockComicsRepository extends Mock implements ComicsRepository {}

void main() {
  group('ComicsBloc', () {
    late ComicsRepository comicsRepository;

    setUp(() {
      comicsRepository = MockComicsRepository();
    });

    group(
      "LoadComics",
      () {
        blocTest<ComicsBloc, ComicsState>(
          "emits state ComicsLoading when LoadComics event is called",
          build: () => ComicsBloc(comicsRepository),
          seed: () => ComicsInitial(),
          act: (bloc) => bloc.add(LoadComics()),
          expect: () => [
            isA<ComicsLoading>(),
          ],
        );

        blocTest<ComicsBloc, ComicsState>(
          "state [ComicsLoading, ComicsError] when LoadComics event fails",
          build: () {
            var expected = _fakeServerFailure("Fake error message");
            when(() => comicsRepository.getComicsResult(any(), any()))
                .thenAnswer((_) async => Left(expected));
            return ComicsBloc(comicsRepository);
          },
          act: (bloc) => bloc.add(LoadComics()),
          expect: () => [
            isA<ComicsLoading>(),
            isA<ComicsError>()
                .having(
                  (state) => state.error,
                  "Error",
                  isA<ServerFailure>(),
                )
                .having(
                  (state) => (state.error as ServerFailure).message,
                  "Error message",
                  equals("Fake error message"),
                ),
          ],
        );

        blocTest<ComicsBloc, ComicsState>(
          "state [ComicsLoading, ComicsSuccess] when LoadComics event success",
          build: () {
            var expected = _fakeDataResult(
              count: 10,
              limit: 10,
              offset: 0,
              total: 10,
            );
            when(() => comicsRepository.getComicsResult(any(), any()))
                .thenAnswer((_) async => Right(expected));
            return ComicsBloc(comicsRepository);
          },
          act: (bloc) => bloc.add(LoadComics()),
          expect: () => [
            isA<ComicsLoading>(),
            isA<ComicsSuccess>()
                .having(
                  (state) => state.comics,
                  "Sucess",
                  isA<List>(),
                )
                .having(
                  (state) => state.comics.length,
                  "Sucess comics length",
                  10,
                )
                .having(
                  (state) => state.total,
                  "Sucess total",
                  10,
                )
                .having(
                  (state) => state.count,
                  "Sucess count",
                  10,
                ),
          ],
        );
      },
    );

    group(
      "GetMore",
      () {
        blocTest<ComicsBloc, ComicsState>(
          "state [ComicsLoading, ComicsError] when GetMore event fails",
          build: () {
            var expected = _fakeServerFailure("Fake error message");
            when(() => comicsRepository.getComicsResult(any(), any()))
                .thenAnswer((_) async => Left(expected));
            return ComicsBloc(comicsRepository);
          },
          act: (bloc) => bloc.add(GetMore()),
          expect: () => [
            isA<ComicsLoading>(),
            isA<ComicsError>()
                .having(
                  (state) => state.error,
                  "Error",
                  isA<ServerFailure>(),
                )
                .having(
                  (state) => (state.error as ServerFailure).message,
                  "Error message",
                  equals("Fake error message"),
                ),
          ],
        );

        blocTest<ComicsBloc, ComicsState>(
          "state [ComicsLoading, ComicsSuccess] when GetMore event success",
          build: () {
            var expected = _fakeDataResult(
              count: 10,
              limit: 10,
              offset: 0,
              total: 10,
            );
            when(() => comicsRepository.getComicsResult(any(), any()))
                .thenAnswer((_) async => Right(expected));
            return ComicsBloc(comicsRepository);
          },
          act: (bloc) => bloc.add(GetMore()),
          expect: () => [
            isA<ComicsLoading>(),
            isA<ComicsSuccess>()
                .having(
                  (state) => state.comics,
                  "Sucess",
                  isA<List>(),
                )
                .having(
                  (state) => state.comics.length,
                  "Sucess comics length",
                  10,
                )
                .having(
                  (state) => state.total,
                  "Sucess total",
                  0,
                )
                .having(
                  (state) => state.count,
                  "Sucess count",
                  10,
                ),
          ],
        );
      },
    );
  });
}

ServerFailure _fakeServerFailure(String _msg) {
  return ServerFailure(message: _msg);
}

DataResult<Comic> _fakeDataResult({
  required int count,
  required int limit,
  required int offset,
  required int total,
}) {
  return DataResult<Comic>(
    code: 1,
    status: "status",
    copyright: "copyright",
    attributionText: "attributionText",
    attributionHTML: "attributionHTML",
    data: Data<Comic>(
      count: count,
      limit: limit,
      offset: offset,
      total: total,
      results: List.generate(
        count,
        (index) => Comic(
          id: index,
          title: "title",
          description: "description",
          modified: "modified",
          resourceURI: "resourceURI",
          variantDescription: "variantDescription",
          format: "format",
          ean: "ean",
          isbn: "isbn",
          issn: "issn",
          diamondCode: "diamondCode",
          upc: "upc",
          issueNumber: 0,
          pageCount: 0,
          digitalId: 0,
          textObjects: List.empty(),
          images: List.empty(),
          prices: List.empty(),
          urls: List.empty(),
          thumbnail: Thumbnail(path: "path", extension: "extension"),
        ),
      ),
    ),
    etag: "etag",
  );
}
