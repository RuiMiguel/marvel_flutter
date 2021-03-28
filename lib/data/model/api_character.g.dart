// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult _$ApiResultFromJson(Map<String, dynamic> json) {
  return ApiResult(
    code: json['code'] as int,
    status: json['status'] as String,
    copyright: json['copyright'] as String,
    attributionText: json['attributionText'] as String,
    attributionHTML: json['attributionHTML'] as String,
    data: ApiData.fromJson(json['data'] as Map<String, dynamic>),
    etag: json['etag'] as String,
  );
}

Map<String, dynamic> _$ApiResultToJson(ApiResult instance) => <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'copyright': instance.copyright,
      'attributionText': instance.attributionText,
      'attributionHTML': instance.attributionHTML,
      'data': instance.data,
      'etag': instance.etag,
    };

ApiData _$ApiDataFromJson(Map<String, dynamic> json) {
  return ApiData(
    offset: json['offset'] as int,
    limit: json['limit'] as int,
    total: json['total'] as int,
    count: json['count'] as int,
    results: (json['results'] as List<dynamic>)
        .map((e) => ApiCharacter.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ApiDataToJson(ApiData instance) => <String, dynamic>{
      'offset': instance.offset,
      'limit': instance.limit,
      'total': instance.total,
      'count': instance.count,
      'results': instance.results,
    };

ApiCharacter _$ApiCharacterFromJson(Map<String, dynamic> json) {
  return ApiCharacter(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    modified: json['modified'] as String,
    resourceURI: json['resourceURI'] as String,
    urls: (json['urls'] as List<dynamic>)
        .map((e) => ApiCharacterUrl.fromJson(e as Map<String, dynamic>))
        .toList(),
    thumbnail: ApiCharacterThumbnail.fromJson(
        json['thumbnail'] as Map<String, dynamic>),
  );
}

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

ApiCharacterUrl _$ApiCharacterUrlFromJson(Map<String, dynamic> json) {
  return ApiCharacterUrl(
    type: json['type'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ApiCharacterUrlToJson(ApiCharacterUrl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };

ApiCharacterThumbnail _$ApiCharacterThumbnailFromJson(
    Map<String, dynamic> json) {
  return ApiCharacterThumbnail(
    path: json['path'] as String,
    extension: json['extension'] as String,
  );
}

Map<String, dynamic> _$ApiCharacterThumbnailToJson(
        ApiCharacterThumbnail instance) =>
    <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
