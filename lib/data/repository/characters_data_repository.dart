import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/core/model/data_result.dart';
import 'package:marvel/core/repository/characters_repository.dart';
import 'package:marvel/data/mapper/data2domain_mapper.dart';
import 'package:marvel/data/service/character_api_client.dart';

class CharactersDataRepository extends CharactersRepository {
  final CharacterApiClient _characterApiClient;

  CharactersDataRepository(this._characterApiClient);

  @override
  Future<Either<Failure, DataResult<Character>>> getCharactersResult(
    int limit,
    int offset,
  ) async {
    final apiResult =
        await _characterApiClient.getCharactersResult(limit, offset);
    return apiResult.fold(
      (error) => Left(error),
      (success) => Right(success.toResultCharacter()),
    );
  }
}
