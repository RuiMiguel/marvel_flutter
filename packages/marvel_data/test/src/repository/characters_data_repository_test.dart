import 'package:core_data_network/core_data_network.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_data/src/model/api_character.dart';
import 'package:marvel_data/src/model/api_result.dart';
import 'package:marvel_data/src/repository/characters_data_repository.dart';
import 'package:marvel_data/src/service/character_api_client.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:mocktail/mocktail.dart';
import '../utils/either.dart';

class MockCharacterApiClient extends Mock implements CharacterApiClient {}

void main() {
  var charactersApiClient = MockCharacterApiClient();
  late CharactersDataRepository charactersDataRepository;
  group('CharactersDataRepository', () {
    setUp(() {
      charactersDataRepository = CharactersDataRepository(charactersApiClient);
    });

    group('getCharactersResult', () {
      test('returns NetworkFailure when apiclient fails', () async {
        int _limit = 100;
        int _offset = 50;
        Either<NetworkFailure, ApiResult<ApiCharacter>> expected =
            Left(ServerFailure());

        when(() => charactersApiClient.getCharactersResult(any(), any()))
            .thenAnswer((_) async => expected);

        var either =
            await charactersDataRepository.getCharactersResult(_limit, _offset);

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var left = either.l();
        expect(left, isA<NetworkFailure>());
      });

      test('returns successfull DataResult when apiclient returns ApiResult',
          () async {
        int _limit = 100;
        int _offset = 50;
        Either<NetworkFailure, ApiResult<ApiCharacter>> expected =
            Right(ApiResult());

        when(() => charactersApiClient.getCharactersResult(any(), any()))
            .thenAnswer((_) async => expected);

        var either =
            await charactersDataRepository.getCharactersResult(_limit, _offset);

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var right = either.r();
        expect(right, isA<DataResult>());
      });
    });
  });
}
