// ignore_for_file: public_member_api_docs

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
  final List<ApiUrl>? urls;
  final ApiThumbnail? thumbnail;
}
