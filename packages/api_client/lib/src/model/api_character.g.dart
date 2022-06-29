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

Map<String, dynamic> _$ApiCharacterToJson(ApiCharacter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'modified': instance.modified,
      'resourceURI': instance.resourceURI,
      'urls': instance.urls,
      'thumbnail': instance.thumbnail,
    };

ApiCharacterUrl _$ApiCharacterUrlFromJson(Map<String, dynamic> json) =>
    ApiCharacterUrl(
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ApiCharacterUrlToJson(ApiCharacterUrl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };
