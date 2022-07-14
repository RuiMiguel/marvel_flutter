import 'package:api_client/api_client.dart';
import 'package:character_repository/src/mapper/mapper.dart';
import 'package:domain/domain.dart';

/// {@template character_repository}
/// Repository to get [Character] data and keep it in memory.
/// {@endtemplate}
class CharacterRepository {
  /// {@macro character_repository}
  CharacterRepository(CharacterService characterService)
      : _characterService = characterService;

  final CharacterService _characterService;

  /// Gets [DataResult] of [Character] and cache data.
  Future<DataResult<Character>> getCharactersResult({
    required int limit,
    required int offset,
  }) async {
    final result = await _characterService.getCharactersResult(limit, offset);
    return result.toResultCharacter();
  }
}
