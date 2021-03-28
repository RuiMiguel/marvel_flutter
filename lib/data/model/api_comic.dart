import 'package:json_annotation/json_annotation.dart';
import 'api_result.dart';
part 'api_comic.g.dart';

@JsonSerializable()
class ApiComic {
  const ApiComic({
    required this.id,
    required this.digitalId,
    required this.title,
    required this.issueNumber,
    required this.variantDescription,
    required this.description,
    required this.modified,
    required this.isbn,
    required this.upc,
    required this.diamondCode,
    required this.ean,
    required this.issn,
    required this.format,
    required this.pageCount,
    required this.textObjects,
    required this.resourceURI,
    required this.urls,
    required this.prices,
    required this.thumbnail,
    required this.images,
  });

  factory ApiComic.fromJson(Map<String, dynamic> json) =>
      _$ApiComicFromJson(json);

  final String id;
  final String digitalId;
  final String title;
  final String issueNumber;
  final String variantDescription;
  final String description;
  final String modified;
  final String isbn;
  final String upc;
  final String diamondCode;
  final String ean;
  final String issn;
  final String format;
  final String pageCount;
  final List<ApiTextObject> textObjects;
  final String resourceURI;
  final List<ApiUrl> urls;
  final List<ApiPrice> prices;
  final ApiThumbnail thumbnail;
  final List<ApiImage> images;
}

@JsonSerializable()
class ApiTextObject {
  const ApiTextObject({
    required this.type,
    required this.language,
    required this.text,
  });

  factory ApiTextObject.fromJson(Map<String, dynamic> json) =>
      _$ApiTextObjectsFromJson(json);

  final String type;
  final String language;
  final String text;
}

@JsonSerializable()
class ApiUrl {
  const ApiUrl({
    required this.type,
    required this.url,
  });

  factory ApiUrl.fromJson(Map<String, dynamic> json) => _$ApiUrlsFromJson(json);

  final String type;
  final String url;
}

@JsonSerializable()
class ApiPrice {
  const ApiPrice({
    required this.type,
    required this.price,
  });

  factory ApiPrice.fromJson(Map<String, dynamic> json) =>
      _$ApiPricesFromJson(json);

  final String type;
  final String price;
}

@JsonSerializable()
class ApiImage {
  const ApiImage({
    required this.path,
    required this.extension,
  });

  factory ApiImage.fromJson(Map<String, dynamic> json) =>
      _$ApiImagesFromJson(json);

  final String path;
  final String extension;
}
