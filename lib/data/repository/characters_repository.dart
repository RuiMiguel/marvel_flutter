import 'package:marvel/core/model/character.dart';
import 'package:marvel/data/service/character_api_client.dart';

class CharactersRepository {
  final CharacterApiClient _characterApiClient;

  CharactersRepository(this._characterApiClient);

  Future<List<Character>> getCharacters() async {
    final characters = await _characterApiClient.getCharacters();
    return characters;
  }
}
