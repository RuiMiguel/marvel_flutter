// ignore_for_file: prefer_const_constructors

import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:character_repository/character_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/bloc/characters_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  final exception = ServerException('error');

  DataResult<Character> _fakeDataResult({
    required int count,
    required int limit,
    required int offset,
    required int total,
  }) {
    return DataResult<Character>(
      code: 1,
      status: 'status',
      copyright: 'copyright',
      attributionText: 'attributionText',
      attributionHTML: 'attributionHTML',
      data: Data<Character>(
        count: count,
        limit: limit,
        offset: offset,
        total: total,
        results: List.generate(
          count,
          (index) => Character(
            id: index,
            name: 'name',
            description: 'description',
            modified: 'modified',
            resourceURI: 'resourceURI',
            urls: List.empty(),
            thumbnail: const Thumbnail(path: 'path', extension: 'extension'),
          ),
        ),
      ),
      etag: 'etag',
    );
  }

  group('CharactersBloc', () {
    late CharacterRepository characterRepository;

    setUp(() {
      characterRepository = _MockCharacterRepository();
    });

    group('CharactersLoaded', () {
      final dataCharacter = _fakeDataResult(
        count: 50,
        limit: 50,
        offset: 0,
        total: 100,
      );

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, success] '
        'when getCharactersResult succeeded',
        setUp: () {
          when(
            () => characterRepository.getCharactersResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => dataCharacter);
        },
        build: () => CharactersBloc(
          characterRepository: characterRepository,
        ),
        act: (bloc) => bloc.add(CharactersLoaded()),
        expect: () => [
          isA<CharactersState>()
            ..having(
              (element) => element.status,
              'status',
              CharactersStatus.loading,
            ),
          isA<CharactersState>()
            ..having(
              (element) => element.status,
              'status',
              CharactersStatus.success,
            )
            ..having(
              (element) => element.count,
              'count',
              dataCharacter.data.count,
            )
            ..having(
              (element) => element.total,
              'total',
              dataCharacter.data.total,
            )
            ..having(
              (element) => element.offset,
              'offset',
              dataCharacter.data.offset,
            )
            ..having(
              (element) => element.legal,
              'legal',
              dataCharacter.attributionText,
            ),
        ],
      );

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, error] '
        'when getCharactersResult fails',
        setUp: () {
          when(
            () => characterRepository.getCharactersResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenThrow(exception);
        },
        build: () => CharactersBloc(
          characterRepository: characterRepository,
        ),
        act: (bloc) => bloc.add(CharactersLoaded()),
        expect: () => [
          isA<CharactersState>()
            ..having(
              (element) => element.status,
              'status',
              CharactersStatus.loading,
            ),
          isA<CharactersState>()
            ..having(
              (element) => element.status,
              'status',
              CharactersStatus.error,
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

    group('CharactersGotMore', () {
      final dataCharacter = _fakeDataResult(
        offset: 50,
        limit: 50,
        count: 50,
        total: 130,
      );
      final newDataCharacter = _fakeDataResult(
        offset: 100,
        limit: 50,
        count: 30,
        total: 130,
      );

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, success] '
        'when getCharactersResult succeeded',
        setUp: () {
          when(
            () => characterRepository.getCharactersResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => newDataCharacter);
        },
        build: () => CharactersBloc(
          characterRepository: characterRepository,
        ),
        act: (bloc) => bloc.add(CharactersGotMore()),
        seed: () => CharactersState(
          status: CharactersStatus.success,
          characters: dataCharacter.data.results,
          count: dataCharacter.data.count,
          total: dataCharacter.data.total,
          offset: dataCharacter.data.offset,
          legal: dataCharacter.attributionText,
        ),
        expect: () => [
          isA<CharactersState>().having(
            (element) => element.status,
            'status',
            CharactersStatus.loading,
          ),
          isA<CharactersState>()
              .having(
                (element) => element.status,
                'status',
                CharactersStatus.success,
              )
              .having(
                (element) => element.count,
                'count',
                newDataCharacter.data.count + newDataCharacter.data.offset,
              )
              .having(
                (element) => element.total,
                'total',
                newDataCharacter.data.total,
              )
              .having(
                (element) => element.offset,
                'offset',
                newDataCharacter.data.offset,
              )
              .having(
                (element) => element.legal,
                'legal',
                equals(newDataCharacter.attributionText),
              ),
        ],
      );

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, error] '
        'when getCharactersResult fails',
        setUp: () {
          when(
            () => characterRepository.getCharactersResult(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenThrow(exception);
        },
        build: () => CharactersBloc(
          characterRepository: characterRepository,
        ),
        act: (bloc) => bloc.add(CharactersGotMore()),
        expect: () => [
          isA<CharactersState>()
            ..having(
              (element) => element.status,
              'status',
              CharactersStatus.loading,
            ),
          isA<CharactersState>()
            ..having(
              (element) => element.status,
              'status',
              CharactersStatus.error,
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
