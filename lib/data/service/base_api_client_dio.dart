import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:marvel/data/service/base_api_client.dart';

abstract class BaseApiClientDio extends BaseApiClient {
  late final Dio _dio;

  BaseApiClientDio(bool _logEnabled) {
    var options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
    _dio.interceptors.add(LogginInterceptor(_logEnabled));
  }

  @override
  Future<T> requestGet<T>(Uri url, T Function(dynamic) parseSuccess,
      T Function(int, dynamic) parseError,
      {Map<String, String>? headers}) async {
    final response = await _dio.get(
      url.toString(),
      queryParameters: headers,
    );
    return parseResponse(response, parseSuccess, parseError);
  }

  @override
  Future<T> requestPost<T>(Uri url, T Function(dynamic) parseSuccess,
      T Function(int, dynamic) parseError,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await _dio.post(url.toString(), data: body);
    return parseResponse(response, parseSuccess, parseError);
  }

  @override
  bool isSuccessfull(dynamic response) {
    return (response.statusCode == 200) ||
        (response.statusCode == 204 && response.data.isEmpty);
  }

  @override
  T parseResponseSuccess<T>(
    dynamic response,
    T Function(dynamic) parseSuccess,
  ) {
    return parseSuccess(response.data);
  }

  @override
  T parseResponseError<T>(
    dynamic response,
    T Function(int, dynamic) parseError,
  ) {
    var errorCode = response.statusCode;
    return parseError(errorCode ?? -1, response.data);
  }
}

class LogginInterceptor extends Interceptor {
  final bool _logEnabled;

  LogginInterceptor(this._logEnabled);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_logEnabled)
      print(
          "[Dio] HTTP Request - ${options.method} ${options.baseUrl}${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_logEnabled)
      print("[Dio] HTTP Response - ${response.statusCode} ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    if (_logEnabled) print("[Dio] HTTP Error - [${error.type}] ${error.error}");
    super.onError(error, handler);
  }
}
