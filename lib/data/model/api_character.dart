import 'package:json_annotation/json_annotation.dart';

import 'api_result.dart';
part 'api_character.g.dart';

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

  final int id;
  final String name;
  final String description;
  final String modified;
  final String resourceURI;
  final List<ApiCharacterUrl> urls;
  final ApiThumbnail thumbnail;
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
