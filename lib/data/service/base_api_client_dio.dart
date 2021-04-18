import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:marvel/data/base/service/base_api_client.dart';

abstract class BaseApiClientDio extends BaseApiClient {
  late final Dio _dio;

  BaseApiClientDio(bool _logEnabled) {
    var options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );
    _dio = Dio(options);
    _dio.interceptors.add(LogginInterceptor(_logEnabled));
  }

  Future<T> requestGet<T>(
    Uri url,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
    T Function(dynamic) manageException, {
    Map<String, String>? headers,
  }) {
    return makeCall(
      _dio.get(
        url.toString(),
        queryParameters: headers,
      ),
      parseSuccess,
      parseError,
      manageException,
    );
  }

  Future<T> requestPost<T>(
    Uri url,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
    T Function(dynamic) manageException, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return makeCall(
      _dio.post(
        url.toString(),
        data: body,
      ),
      parseSuccess,
      parseError,
      manageException,
    );
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
