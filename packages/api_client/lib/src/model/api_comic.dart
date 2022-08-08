// ignore_for_file: public_member_api_docs

import 'package:api_client/src/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_comic.g.dart';

@JsonSerializable()
class ApiComic {
  const ApiComic({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.isbn,
    this.upc,
    this.diamondCode,
    this.ean,
    this.issn,
    this.format,
    this.pageCount,
    this.textObjects,
    this.resourceURI,
    this.urls,
    this.prices,
    this.thumbnail,
    this.images,
  });

  factory ApiComic.fromJson(Map<String, dynamic> json) =>
      _$ApiComicFromJson(json);

  final int? id;
  final int? digitalId;
  final String? title;
  final double? issueNumber;
  final String? variantDescription;
  final String? description;
  final String? modified;
  final String? isbn;
  final String? upc;
  final String? diamondCode;
  final String? ean;
  final String? issn;
  final String? format;
  final int? pageCount;
  final List<ApiTextObject>? textObjects;
  final String? resourceURI;
  final List<ApiUrl>? urls;
  final List<ApiPrice>? prices;
  final ApiThumbnail? thumbnail;
  final List<ApiComicImage>? images;
}

@JsonSerializable()
class ApiTextObject {
  const ApiTextObject({
    this.type,
    this.language,
    this.text,
  });

  factory ApiTextObject.fromJson(Map<String, dynamic> json) =>
      _$ApiTextObjectFromJson(json);

  final String? type;
  final String? language;
  final String? text;
}

@JsonSerializable()
class ApiPrice {
  const ApiPrice({
    this.type,
    this.price,
  });

  factory ApiPrice.fromJson(Map<String, dynamic> json) =>
      _$ApiPriceFromJson(json);

  final String? type;
  final double? price;
}

@JsonSerializable()
class ApiComicImage {
  const ApiComicImage({
    this.path,
    this.extension,
  });

  factory ApiComicImage.fromJson(Map<String, dynamic> json) =>
      _$ApiComicImageFromJson(json);

  final String? path;
  final String? extension;
}
