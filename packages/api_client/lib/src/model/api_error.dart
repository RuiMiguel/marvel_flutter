// ignore_for_file: public_member_api_docs

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

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'message')
  final String? message;
}
