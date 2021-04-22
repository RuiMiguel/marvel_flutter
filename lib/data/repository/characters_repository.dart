import 'package:dartz/dartz.dart';
import 'package:marvel/core/base/error/failure.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/core/model/data_result.dart';
import 'package:marvel/data/mapper/data2domain_mapper.dart';
import 'package:marvel/data/service/character_api_client.dart';

class CharactersRepository {
  final CharacterApiClient _characterApiClient;

  CharactersRepository(this._characterApiClient);

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
