import 'package:api_client/api_client.dart';
import 'package:domain/domain.dart';

extension DataResultMapper on ApiResult {
  DataResult<Character> toResultCharacter() {
    return DataResult<Character>(
      code: code ?? 0,
      status: status ?? '',
      copyright: copyright ?? '',
      attributionText: attributionText ?? '',
      attributionHTML: attributionHTML ?? '',
      data: data.toDataCharacter(),
      etag: etag ?? '',
    );
  }
}

extension DataMapper on ApiData? {
  Data<Character> toDataCharacter() {
    return Data<Character>(
      offset: this?.offset ?? 0,
      limit: this?.limit ?? 0,
      total: this?.total ?? 0,
      count: this?.count ?? 0,
      results: this
              ?.results
              ?.map((dynamic e) => (e as ApiCharacter).toCharacter())
              .toList() ??
          List.empty(),
    );
  }
}

extension ThumbnailMapper on ApiThumbnail? {
  Thumbnail toThumbnail() {
    return Thumbnail(
      path: this?.path ?? '',
      extension: this?.extension ?? '',
    );
  }
}

extension CharacterMapper on ApiCharacter {
  Character toCharacter() {
    return Character(
      id: id ?? 0,
      name: name ?? '',
      description: description ?? '',
      modified: modified ?? '',
      resourceURI: resourceURI ?? '',
      urls: urls.toCharactersUrl(),
      thumbnail: thumbnail.toThumbnail(),
    );
  }
}

extension CharacterListUrlMapper on List<ApiCharacterUrl>? {
  List<CharacterUrl> toCharactersUrl() {
    return this?.map((element) => element.toCharacterUrl()).toList() ??
        List.empty();
  }
}

extension CharacterUrlMapper on ApiCharacterUrl {
  CharacterUrl toCharacterUrl() {
    return CharacterUrl(
      type: type ?? '',
      url: url ?? '',
    );
  }
}
