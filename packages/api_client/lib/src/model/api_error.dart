import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  const ApiError({
    this.code,
    this.message,
  });

  factory ApiError.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'message')
  final String? message;
}
