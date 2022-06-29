import 'package:api_client/src/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_character.g.dart';

@JsonSerializable()
class ApiCharacter {
  const ApiCharacter({
    this.id,
    this.name,
    this.description,
    this.modified,
    this.resourceURI,
    this.urls,
    this.thumbnail,
  });

  factory ApiCharacter.fromJson(Map<String, dynamic> json) =>
      _$ApiCharacterFromJson(json);

  final int? id;
  final String? name;
  final String? description;
  final String? modified;
  final String? resourceURI;
  final List<ApiCharacterUrl>? urls;
  final ApiThumbnail? thumbnail;
}

@JsonSerializable()
class ApiCharacterUrl {
  const ApiCharacterUrl({
    this.type,
    this.url,
  });

  factory ApiCharacterUrl.fromJson(Map<String, dynamic> json) =>
      _$ApiCharacterUrlFromJson(json);

  final String? type;
  final String? url;
}
