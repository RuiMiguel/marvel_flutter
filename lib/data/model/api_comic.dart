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
  final List<ApiTextObjects> textObjects;
  final String resourceURI;
  final List<ApiUrls> urls;
  final List<ApiPrices> prices;
  final ApiThumbnail thumbnail;
  final List<ApiImages> images;
}

@JsonSerializable()
class ApiTextObjects {
  const ApiTextObjects({
    required this.type,
    required this.language,
    required this.text,
  });

  factory ApiTextObjects.fromJson(Map<String, dynamic> json) =>
      _$ApiTextObjectsFromJson(json);

  final String type;
  final String language;
  final String text;
}

@JsonSerializable()
class ApiUrls {
  const ApiUrls({
    required this.type,
    required this.url,
  });

  factory ApiUrls.fromJson(Map<String, dynamic> json) =>
      _$ApiUrlsFromJson(json);

  final String type;
  final String url;
}

@JsonSerializable()
class ApiPrices {
  const ApiPrices({
    required this.type,
    required this.price,
  });

  factory ApiPrices.fromJson(Map<String, dynamic> json) =>
      _$ApiPricesFromJson(json);

  final String type;
  final String price;
}

@JsonSerializable()
class ApiImages {
  const ApiImages({
    required this.path,
    required this.extension,
  });

  factory ApiImages.fromJson(Map<String, dynamic> json) =>
      _$ApiImagesFromJson(json);

  final String path;
  final String extension;
}
