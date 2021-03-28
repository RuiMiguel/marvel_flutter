import 'package:marvel/core/model/comic.dart';
import 'package:marvel/data/mapper/data2domain_mapper.dart';
import 'package:marvel/data/service/comic_api_client.dart';

class ComicsRepository {
  final ComicsApiClient _comicApiClient;

  ComicsRepository(this._comicApiClient);

  Future<List<Comic>> getComics() async {
    final apiComics = await _comicApiClient.getComics();
    return apiComics.toComics();
  }
}
