// ignore_for_file: prefer_const_constructors
import 'package:api_client/api_client.dart';
import 'package:character_repository/src/character_repository.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCharacterService extends Mock implements CharacterService {}

void main() {
  late CharacterService characterService;
  late CharacterRepository characterRepository;

  group('CharacterRepository', () {
    setUp(() {
      characterService = _MockCharacterService();
    });

    test('can be instantiated', () {
      expect(CharacterRepository(characterService), isNotNull);
    });

    group('getCharactersResult', () {
      setUp(() {
        characterRepository = CharacterRepository(characterService);
      });

      test('throws Exception when characterService fails', () async {
        when(
          () => characterService.getCharactersResult(any(), any()),
        ).thenThrow(Exception());

        expect(
          characterRepository.getCharactersResult(1, 1),
          throwsA(isA<Exception>()),
        );
      });

      test(
        'returns DataResult<Character> '
        'when characterService responses ApiResult<ApiCharacter>',
        () async {
          when(
            () => characterService.getCharactersResult(any(), any()),
          ).thenAnswer((_) async => ApiResult<ApiCharacter>());

          expect(
            await characterRepository.getCharactersResult(1, 1),
            isA<DataResult<Character>>(),
          );
        },
      );
    });
  });
}
