import 'dart:convert';
import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/interceptor/interceptor.dart';
import 'package:dio/dio.dart';

/// Parse success function typedef
typedef Success<T> = T Function(Map<String, dynamic>);

/// Parse failure function typedef
typedef Failure<T> = T Function(int?, Map<String, dynamic>);

/// {@template dio_api_client}
/// Simple API client implemented with [Dio].
/// {@endtemplate}
class DioApiClient {
  /// {@macro dio_api_client}
  DioApiClient({
    required Dio dio,
    LoggingInterceptor? loggingInterceptor,
  }) : _dio = dio {
    if (loggingInterceptor != null) {
      _dio.interceptors.add(loggingInterceptor);
    }
  }

  late final Dio _dio;

  ///
  Future<T> get<T>(
    Uri url,
    Success<T> onSuccess,
    Failure<T> onError, {
    Map<String, String>? headers,
  }) async {
    return _makeCall(
      _dio.get<Map<String, dynamic>>(
        url.toString(),
        queryParameters: headers,
      ),
      onSuccess,
      onError,
    );
  }

  ///
  Future<T> post<T>(
    Uri url,
    Success<T> onSuccess,
    Failure<T> onError, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _makeCall(
      _dio.post<Map<String, dynamic>>(
        url.toString(),
        data: body,
      ),
      onSuccess,
      onError,
    );
  }

  Future<T> _makeCall<T>(
    Future<Response> call,
    Success<T> parseSuccess,
    Failure<T> parseError,
  ) async {
    Response result;
    try {
      result = await call;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        NetworkException(error),
        error is DioError ? error.stackTrace ?? stackTrace : stackTrace,
      );
    }
    return _parseResponse(result, parseSuccess, parseError);
  }

  T _parseResponse<T>(
    Response response,
    Success<T> parseSuccess,
    Failure<T> parseError,
  ) {
    if (_isSuccessful(response)) {
      return _parseResponseSuccess(response, parseSuccess);
    } else {
      return _parseResponseError(response, parseError);
    }
  }

  bool _isSuccessful(Response response) {
    return (response.statusCode == 200) ||
        (response.statusCode == 204 && response.data == null);
  }

  T _parseResponseSuccess<T>(
    Response response,
    Success<T> parseSuccess,
  ) {
    try {
      return parseSuccess(response.data as Map<String, dynamic>);
    } catch (error, stackTrace) {
      throw DeserializationException(error, stackTrace);
    }
  }

  T _parseResponseError<T>(
    Response response,
    Failure<T> parseError,
  ) {
    try {
      return parseError(
        response.statusCode,
        response.data as Map<String, dynamic>,
      );
    } catch (error, stackTrace) {
      throw DeserializationException(error, stackTrace);
    }
  }
}
