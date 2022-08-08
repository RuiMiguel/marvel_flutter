// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult<T> _$ApiResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResult<T>(
      code: json['code'] as int?,
      status: json['status'] as String?,
      copyright: json['copyright'] as String?,
      attributionText: json['attributionText'] as String?,
      attributionHTML: json['attributionHTML'] as String?,
      data: json['data'] == null
          ? null
          : ApiData<T>.fromJson(json['data'] as Map<String, dynamic>,
              (value) => fromJsonT(value)),
      etag: json['etag'] as String?,
    );

Map<String, dynamic> _$ApiResultToJson<T>(
  ApiResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'copyright': instance.copyright,
      'attributionText': instance.attributionText,
      'attributionHTML': instance.attributionHTML,
      'data': instance.data,
      'etag': instance.etag,
    };

ApiData<T> _$ApiDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiData<T>(
      offset: json['offset'] as int?,
      limit: json['limit'] as int?,
      total: json['total'] as int?,
      count: json['count'] as int?,
      results: (json['results'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ApiDataToJson<T>(
  ApiData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'offset': instance.offset,
      'limit': instance.limit,
      'total': instance.total,
      'count': instance.count,
      'results': instance.results?.map(toJsonT).toList(),
    };

ApiUrl _$ApiUrlFromJson(Map<String, dynamic> json) => ApiUrl(
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ApiUrlToJson(ApiUrl instance) => <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };

ApiThumbnail _$ApiThumbnailFromJson(Map<String, dynamic> json) => ApiThumbnail(
      path: json['path'] as String?,
      extension: json['extension'] as String?,
    );

Map<String, dynamic> _$ApiThumbnailToJson(ApiThumbnail instance) =>
    <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
