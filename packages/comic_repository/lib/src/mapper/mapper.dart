import 'package:api_client/api_client.dart';
import 'package:domain/domain.dart';

extension DataResultMapper on ApiResult {
  DataResult<Comic> toResultComic() {
    return DataResult<Comic>(
      code: code ?? 0,
      status: status ?? '',
      copyright: copyright ?? '',
      attributionText: attributionText ?? '',
      attributionHTML: attributionHTML ?? '',
      data: data.toDataComic(),
      etag: etag ?? '',
    );
  }
}

extension DataMapper on ApiData? {
  Data<Comic> toDataComic() {
    return Data<Comic>(
      offset: this?.offset ?? 0,
      limit: this?.limit ?? 0,
      total: this?.total ?? 0,
      count: this?.count ?? 0,
      results: this
              ?.results
              ?.map((dynamic element) => (element as ApiComic).toComic())
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

extension ComicMapper on ApiComic {
  Comic toComic() {
    return Comic(
      id: id ?? 0,
      digitalId: digitalId ?? 0,
      title: title ?? '',
      issueNumber: issueNumber ?? 0,
      variantDescription: variantDescription ?? '',
      description: description ?? '',
      modified: modified ?? '',
      isbn: isbn ?? '',
      upc: upc ?? '',
      diamondCode: diamondCode ?? '',
      ean: ean ?? '',
      issn: issn ?? '',
      format: format ?? '',
      pageCount: pageCount ?? 0,
      textObjects: textObjects.toTextObjects(),
      resourceURI: resourceURI ?? '',
      urls: urls.toComicsUrl(),
      prices: prices.toPrices(),
      thumbnail: thumbnail.toThumbnail(),
      images: images.toComicImages(),
    );
  }
}

extension TextObjectListMapper on List<ApiTextObject>? {
  List<TextObject> toTextObjects() {
    return this?.map((element) {
          return element.toTextObject();
        }).toList() ??
        List.empty();
  }
}

extension TextObjectMapper on ApiTextObject {
  TextObject toTextObject() {
    return TextObject(
      type: type ?? '',
      language: language ?? '',
      text: text ?? '',
    );
  }
}

extension ComicUrlListMapper on List<ApiComicUrl>? {
  List<ComicUrl> toComicsUrl() {
    return this?.map((element) {
          return element.toComicUrl();
        }).toList() ??
        List.empty();
  }
}

extension ComicUrlMapper on ApiComicUrl {
  ComicUrl toComicUrl() {
    return ComicUrl(
      type: type ?? '',
      url: url ?? '',
    );
  }
}

extension PriceListMapper on List<ApiPrice>? {
  List<Price> toPrices() {
    return this?.map((element) {
          return element.toPrice();
        }).toList() ??
        List.empty();
  }
}

extension PriceMapper on ApiPrice {
  Price toPrice() {
    return Price(
      type: type ?? '',
      price: price ?? 0,
    );
  }
}

extension ComicImageListMapper on List<ApiComicImage>? {
  List<ComicImage> toComicImages() {
    return this?.map((element) {
          return element.toComicImage();
        }).toList() ??
        List.empty();
  }
}

extension ComicImageMapper on ApiComicImage {
  ComicImage toComicImage() {
    return ComicImage(
      path: path ?? '',
      extension: extension ?? '',
    );
  }
}
