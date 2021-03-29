import 'package:marvel/core/model/character.dart';
import 'package:marvel/core/model/result.dart';
import 'package:marvel/data/mapper/data2domain_mapper.dart';
import 'package:marvel/data/service/character_api_client.dart';

class CharactersRepository {
  final CharacterApiClient _characterApiClient;

  CharactersRepository(this._characterApiClient);

  Future<DataResult<Character>> getCharactersResult(
    int limit,
    int offset,
  ) async {
    final apiResult =
        await _characterApiClient.getCharactersResult(limit, offset);
    return apiResult.toResultCharacter();
  }
}
