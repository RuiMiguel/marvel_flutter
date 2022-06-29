import 'package:api_client/api_client.dart';
import 'package:character_repository/src/mapper/data2domain_mapper.dart';
import 'package:domain/domain.dart';

/// {@template character_repository}
/// Repository to get [Character] data and keep it in memory.
/// {@endtemplate}
class CharacterRepository {
  /// {@macro character_repository}
  CharacterRepository(CharacterService characterService)
      : _characterService = characterService {
    _cache = DataResult.empty();
  }

  final CharacterService _characterService;

  late DataResult<Character> _cache;

  /// Gets [DataResult] of [Character] and cache data.
  Future<DataResult<Character>> getCharactersResult(
    int limit,
    int offset,
  ) async {
    final result = await _characterService.getCharactersResult(limit, offset);
    _updateCache(result.toResultCharacter());
    return _cache;
  }

  void _updateCache(DataResult<Character> dataResult) {
    _cache = DataResult(
      code: dataResult.code,
      status: dataResult.status,
      copyright: dataResult.copyright,
      attributionText: dataResult.attributionText,
      attributionHTML: dataResult.attributionHTML,
      data: Data(
        offset: dataResult.data.offset,
        limit: dataResult.data.limit,
        total: dataResult.data.total,
        count: dataResult.data.count,
        results: [..._cache.data.results, ...dataResult.data.results],
      ),
      etag: dataResult.etag,
    );
  }
}
