import 'package:json_annotation/json_annotation.dart';
part 'api_character.g.dart';

@JsonSerializable()
class ApiResult {
  const ApiResult({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHTML,
    required this.data,
    required this.etag,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) =>
      _$ApiResultFromJson(json);

  final String code;
  final String status;
  final String copyright;
  final String attributionText;
  final String attributionHTML;
  final ApiData data;
  final String etag;
}

@JsonSerializable()
class ApiData {
  const ApiData({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) =>
      _$ApiDataFromJson(json);

  final String offset;
  final String limit;
  final String total;
  final String count;
  final List<ApiCharacter> results;
}

@JsonSerializable()
class ApiCharacter {
  const ApiCharacter({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.resourceURI,
    required this.urls,
    required this.thumbnail,
  });

  factory ApiCharacter.fromJson(Map<String, dynamic> json) =>
      _$ApiCharacterFromJson(json);

  final String id;
  final String name;
  final String description;
  final String modified;
  final String resourceURI;
  final List<ApiCharacterUrl> urls;
  final ApiCharacterThumbnail thumbnail;
}

@JsonSerializable()
class ApiCharacterUrl {
  const ApiCharacterUrl({
    required this.type,
    required this.url,
  });

  factory ApiCharacterUrl.fromJson(Map<String, dynamic> json) =>
      _$ApiCharacterUrlFromJson(json);

  final String type;
  final String url;
}

@JsonSerializable()
class ApiCharacterThumbnail {
  const ApiCharacterThumbnail({
    required this.path,
    required this.extension,
  });

  factory ApiCharacterThumbnail.fromJson(Map<String, dynamic> json) =>
      _$ApiCharacterThumbnailFromJson(json);

  final String path;
  final String extension;
}
