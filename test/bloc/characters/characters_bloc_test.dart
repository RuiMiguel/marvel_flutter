import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/bloc/characters/characters_bloc.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  group('CharactersBloc', () {
    late CharactersRepository charactersRepository;

    setUp(() {
      charactersRepository = MockCharactersRepository();
    });

    group(
      "LoadCharacters",
      () {
        blocTest<CharactersBloc, CharactersState>(
          "emits state CharactersLoading when LoadCharacters event is called",
          build: () => CharactersBloc(charactersRepository),
          seed: () => CharactersInitial(),
          act: (bloc) => bloc.add(LoadCharacters()),
          expect: () => [
            isA<CharactersLoading>(),
          ],
        );

        blocTest<CharactersBloc, CharactersState>(
          "state [CharactersLoading, CharactersError] when LoadCharacters event fails",
          build: () {
            var expected = _fakeServerFailure("Fake error message");
            when(() => charactersRepository.getCharactersResult(any(), any()))
                .thenAnswer((_) async => Left(expected));
            return CharactersBloc(charactersRepository);
          },
          seed: () => CharactersInitial(),
          act: (bloc) => bloc.add(LoadCharacters()),
          expect: () => [
            isA<CharactersLoading>(),
            isA<CharactersError>()
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

        blocTest<CharactersBloc, CharactersState>(
          "state [CharactersLoading, CharactersSuccess] when LoadCharacters event success",
          build: () {
            var expected = _fakeDataResult(
              count: 10,
              limit: 10,
              offset: 0,
              total: 10,
            );
            when(() => charactersRepository.getCharactersResult(any(), any()))
                .thenAnswer((_) async => Right(expected));
            return CharactersBloc(charactersRepository);
          },
          seed: () => CharactersInitial(),
          act: (bloc) => bloc.add(LoadCharacters()),
          expect: () => [
            isA<CharactersLoading>(),
            isA<CharactersSuccess>()
                .having(
                  (state) => state.characters,
                  "Sucess",
                  isA<List>(),
                )
                .having(
                  (state) => state.characters.length,
                  "Sucess characters length",
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
        blocTest<CharactersBloc, CharactersState>(
          "state [CharactersLoading, CharactersError] when GetMore event fails",
          build: () {
            var expected = _fakeServerFailure("Fake error message");
            when(() => charactersRepository.getCharactersResult(any(), any()))
                .thenAnswer((_) async => Left(expected));
            return CharactersBloc(charactersRepository);
          },
          act: (bloc) => bloc.add(GetMore()),
          expect: () => [
            isA<CharactersLoading>(),
            isA<CharactersError>()
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

        blocTest<CharactersBloc, CharactersState>(
          "state [CharactersLoading, CharactersSuccess] when GetMore event success",
          build: () {
            var expected = _fakeDataResult(
              count: 10,
              limit: 10,
              offset: 0,
              total: 10,
            );
            when(() => charactersRepository.getCharactersResult(any(), any()))
                .thenAnswer((_) async => Right(expected));
            return CharactersBloc(charactersRepository);
          },
          act: (bloc) => bloc.add(GetMore()),
          expect: () => [
            isA<CharactersLoading>(),
            isA<CharactersSuccess>()
                .having(
                  (state) => state.characters,
                  "Sucess",
                  isA<List>(),
                )
                .having(
                  (state) => state.characters.length,
                  "Sucess characters length",
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

DataResult<Character> _fakeDataResult({
  required int count,
  required int limit,
  required int offset,
  required int total,
}) {
  return DataResult<Character>(
    code: 1,
    status: "status",
    copyright: "copyright",
    attributionText: "attributionText",
    attributionHTML: "attributionHTML",
    data: Data<Character>(
      count: count,
      limit: limit,
      offset: offset,
      total: total,
      results: List.generate(
        count,
        (index) => Character(
          id: index,
          name: "name",
          description: "description",
          modified: "modified",
          resourceURI: "resourceURI",
          urls: List.empty(),
          thumbnail: Thumbnail(path: "path", extension: "extension"),
        ),
      ),
    ),
    etag: "etag",
  );
}
