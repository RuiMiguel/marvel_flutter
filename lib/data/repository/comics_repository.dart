import 'package:marvel/core/model/comic.dart';
import 'package:marvel/core/model/data_result.dart';
import 'package:marvel/data/mapper/data2domain_mapper.dart';
import 'package:marvel/data/service/comic_api_client.dart';

class ComicsRepository {
  final ComicsApiClient _comicApiClient;

  ComicsRepository(this._comicApiClient);

  Future<DataResult<Comic>> getComicsResult(
    int limit,
    int offset,
  ) async {
    final apiResult = await _comicApiClient.getComicsResult(limit, offset);
    return apiResult.toResultComic();
  }
}
