import 'package:api_client/api_client.dart';
import 'package:comic_repository/src/mapper/mapper.dart';
import 'package:domain/domain.dart';

/// {@template comic_repository}
/// Repository to get [Comic] data and keep it in memory.
/// {@endtemplate}
class ComicRepository {
  /// {@macro comic_repository}
  ComicRepository(ComicService comicService) : _comicService = comicService;

  final ComicService _comicService;

  /// Gets [DataResult] of [Comic] and cache data.
  Future<DataResult<Comic>> getComicsResult(
    int limit,
    int offset,
  ) async {
    final result = await _comicService.getComicsResult(limit, offset);
    return result.toResultComic();
  }
}
