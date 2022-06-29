/* #region Result */
import 'package:api_client/api_client.dart';
import 'package:domain/domain.dart';

extension DataResultMapper on ApiResult {
  DataResult<Character> toResultCharacter() {
    return new DataResult<Character>(
      code: this.code ?? 0,
      status: this.status ?? "",
      copyright: this.copyright ?? "",
      attributionText: this.attributionText ?? "",
      attributionHTML: this.attributionHTML ?? "",
      data: this.data.toDataCharacter(),
      etag: this.etag ?? "",
    );
  }

  DataResult<Comic> toResultComic() {
    return new DataResult<Comic>(
      code: this.code ?? 0,
      status: this.status ?? "",
      copyright: this.copyright ?? "",
      attributionText: this.attributionText ?? "",
      attributionHTML: this.attributionHTML ?? "",
      data: this.data.toDataComic(),
      etag: this.etag ?? "",
    );
  }
}

extension DataMapper on ApiData? {
  Data<Character> toDataCharacter() {
    return new Data<Character>(
      offset: this?.offset ?? 0,
      limit: this?.limit ?? 0,
      total: this?.total ?? 0,
      count: this?.count ?? 0,
      results: this
              ?.results
              ?.map((element) => (element as ApiCharacter).toCharacter())
              .toList() ??
          List.empty(),
    );
  }

  Data<Comic> toDataComic() {
    return new Data<Comic>(
      offset: this?.offset ?? 0,
      limit: this?.limit ?? 0,
      total: this?.total ?? 0,
      count: this?.count ?? 0,
      results: this
              ?.results
              ?.map((element) => (element as ApiComic).toComic())
              .toList() ??
          List.empty(),
    );
  }
}

extension ThumbnailMapper on ApiThumbnail? {
  Thumbnail toThumbnail() {
    return new Thumbnail(
      path: this?.path ?? "",
      extension: this?.extension ?? "",
    );
  }
}
/* #endregion */

/* #region Character */
extension CharacterListMapper on List<ApiCharacter> {
  List<Character> toCharacters() {
    return map((element) {
      return element.toCharacter();
    }).toList();
  }
}

extension CharacterMapper on ApiCharacter {
  Character toCharacter() {
    return new Character(
      id: id ?? 0,
      name: name ?? "",
      description: description ?? "",
      modified: modified ?? "",
      resourceURI: resourceURI ?? "",
      urls: urls?.toCharactersUrl() ?? List.empty(),
      thumbnail: thumbnail.toThumbnail(),
    );
  }
}

extension CharacterListUrlMapper on List<ApiCharacterUrl> {
  List<CharacterUrl> toCharactersUrl() {
    return map((element) => element.toCharacterUrl()).toList();
  }
}

extension CharacterUrlMapper on ApiCharacterUrl {
  CharacterUrl toCharacterUrl() {
    return new CharacterUrl(
      type: type ?? "",
      url: url ?? "",
    );
  }
}
/* #endregion */

/* #region Comics */
extension ComicListMapper on List<ApiComic> {
  List<Comic> toComics() {
    return map((element) {
      return element.toComic();
    }).toList();
  }
}

extension ComicMapper on ApiComic {
  Comic toComic() {
    return new Comic(
      id: id ?? 0,
      digitalId: digitalId ?? 0,
      title: title ?? "",
      issueNumber: issueNumber ?? 0,
      variantDescription: variantDescription ?? "",
      description: description ?? "",
      modified: modified ?? "",
      isbn: isbn ?? "",
      upc: upc ?? "",
      diamondCode: diamondCode ?? "",
      ean: ean ?? "",
      issn: issn ?? "",
      format: format ?? "",
      pageCount: pageCount ?? 0,
      textObjects: textObjects?.toTextObjects() ?? List.empty(),
      resourceURI: resourceURI ?? "",
      urls: urls?.toUrls() ?? List.empty(),
      prices: prices?.toPrices() ?? List.empty(),
      thumbnail: thumbnail.toThumbnail(),
      images: images?.toImages() ?? List.empty(),
    );
  }
}

extension TextObjectListMapper on List<ApiTextObject> {
  List<TextObject> toTextObjects() {
    return map((element) {
      return element.toTextObject();
    }).toList();
  }
}

extension TextObjectMapper on ApiTextObject {
  TextObject toTextObject() {
    return new TextObject(
      type: type ?? "",
      language: language ?? "",
      text: text ?? "",
    );
  }
}

extension UrlListMapper on List<ApiUrl> {
  List<Url> toUrls() {
    return map((element) {
      return element.toUrl();
    }).toList();
  }
}

extension UrlMapper on ApiUrl {
  Url toUrl() {
    return new Url(
      type: type ?? "",
      url: url ?? "",
    );
  }
}

extension PriceListMapper on List<ApiPrice> {
  List<Price> toPrices() {
    return map((element) {
      return element.toPrice();
    }).toList();
  }
}

extension PriceMapper on ApiPrice {
  Price toPrice() {
    return new Price(
      type: type ?? "",
      price: price ?? 0,
    );
  }
}

extension ImageListMapper on List<ApiImage> {
  List<Image> toImages() {
    return map((element) {
      return element.toImage();
    }).toList();
  }
}

extension ImageMapper on ApiImage {
  Image toImage() {
    return new Image(
      path: path ?? "",
      extension: extension ?? "",
    );
  }
}
/* #endregion */
