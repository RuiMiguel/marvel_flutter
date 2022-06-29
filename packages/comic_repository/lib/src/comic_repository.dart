import 'package:api_client/api_client.dart';
import 'package:comic_repository/src/mapper/data2domain_mapper.dart';
import 'package:domain/domain.dart';

/// {@template comic_repository}
/// Repository to get [Comic] data and keep it in memory.
/// {@endtemplate}
class ComicRepository {
  /// {@macro comic_repository}
  ComicRepository(ComicService comicService) : _comicService = comicService {
    _cache = DataResult.empty();
  }

  final ComicService _comicService;

  late DataResult<Comic> _cache;

  /// Gets [DataResult] of [Comic] and cache data.
  Future<DataResult<Comic>> getComicsResult(
    int limit,
    int offset,
  ) async {
    final result = await _comicService.getComicsResult(limit, offset);
    _updateCache(result.toResultComic());
    return _cache;
  }

  void _updateCache(DataResult<Comic> dataResult) {
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
