import 'dart:convert';

import 'package:core_data_network/src/error/data_failure.dart';
import 'package:core_data_network/src/interceptor/logging_interceptor.dart';
import 'package:core_data_network/src/service/base_api_client.dart';
import 'package:dio/dio.dart';

abstract class BaseApiClientDio extends BaseApiClient {
  late final Dio _dio;

  BaseApiClientDio({Dio? dio, bool logEnabled = false}) {
    _dio = dio ??
        Dio(
          BaseOptions(
            connectTimeout: 15000,
            receiveTimeout: 15000,
          ),
        )
      ..interceptors.add(LogginInterceptor(logEnabled));
  }

  Future<T> requestGet<T>(
    Uri url,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
    T Function(dynamic) manageException, {
    Map<String, String>? headers,
  }) async {
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
  T processException<T>(
    error,
    T Function(dynamic) manageException,
  ) {
    if (error is DioError) {
      if (error.type == DioErrorType.response) {
        return manageException(
          ServerFailure(
            code: error.type.toString(),
            message: error.response.toString(),
          ),
        );
      } else {
        return manageException(
          ServerFailure(
            code: error.type.toString(),
            message: error.message,
          ),
        );
      }
    } else {
      return super.processException(error, manageException);
    }
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
