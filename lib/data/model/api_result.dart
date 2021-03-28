import 'package:json_annotation/json_annotation.dart';
part 'api_result.g.dart';

@JsonSerializable(
    genericArgumentFactories: true, fieldRename: FieldRename.snake)
class ApiResult<T> {
  const ApiResult({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHTML,
    required this.data,
    required this.etag,
  });

  factory ApiResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResultToJson(this, toJsonT);

  @JsonKey(name: "code")
  final int code;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "copyright")
  final String copyright;

  @JsonKey(name: "attributionText")
  final String attributionText;

  @JsonKey(name: "attributionHTML")
  final String attributionHTML;

  @JsonKey(name: "data")
  final ApiData<T> data;

  @JsonKey(name: "etag")
  final String etag;
}

@JsonSerializable(
    genericArgumentFactories: true, fieldRename: FieldRename.snake)
class ApiData<T> {
  const ApiData({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory ApiData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiDataToJson(this, toJsonT);

  @JsonKey(name: "offset")
  final int offset;

  @JsonKey(name: "limit")
  final int limit;

  @JsonKey(name: "total")
  final int total;

  @JsonKey(name: "count")
  final int count;

  @JsonKey(name: "results")
  final List<T> results;
}

@JsonSerializable()
class ApiThumbnail {
  const ApiThumbnail({
    required this.path,
    required this.extension,
  });

  factory ApiThumbnail.fromJson(Map<String, dynamic> json) =>
      _$ApiThumbnailFromJson(json);

  @JsonKey(name: "path")
  final String path;

  @JsonKey(name: "extension")
  final String extension;
}
