// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
part 'api_result.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)
class ApiResult<T> {
  const ApiResult({
    this.code,
    this.status,
    this.copyright,
    this.attributionText,
    this.attributionHTML,
    this.data,
    this.etag,
  });

  factory ApiResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResultToJson(this, toJsonT);

  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'copyright')
  final String? copyright;

  @JsonKey(name: 'attributionText')
  final String? attributionText;

  @JsonKey(name: 'attributionHTML')
  final String? attributionHTML;

  @JsonKey(name: 'data')
  final ApiData<T>? data;

  @JsonKey(name: 'etag')
  final String? etag;
}

@JsonSerializable(
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)
class ApiData<T> {
  const ApiData({
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  });

  factory ApiData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiDataToJson(this, toJsonT);

  @JsonKey(name: 'offset')
  final int? offset;

  @JsonKey(name: 'limit')
  final int? limit;

  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'results')
  final List<T>? results;
}

@JsonSerializable()
class ApiThumbnail {
  const ApiThumbnail({
    this.path,
    this.extension,
  });

  factory ApiThumbnail.fromJson(Map<String, dynamic> json) =>
      _$ApiThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ApiThumbnailToJson(this);

  @JsonKey(name: 'path')
  final String? path;

  @JsonKey(name: 'extension')
  final String? extension;
}
