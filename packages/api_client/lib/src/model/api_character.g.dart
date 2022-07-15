// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiCharacter _$ApiCharacterFromJson(Map<String, dynamic> json) => ApiCharacter(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      modified: json['modified'] as String?,
      resourceURI: json['resourceURI'] as String?,
      urls: (json['urls'] as List<dynamic>?)
          ?.map((dynamic e) =>
              ApiCharacterUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnail: json['thumbnail'] == null
          ? null
          : ApiThumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

ApiCharacterUrl _$ApiCharacterUrlFromJson(Map<String, dynamic> json) =>
    ApiCharacterUrl(
      type: json['type'] as String?,
      url: json['url'] as String?,
    );
