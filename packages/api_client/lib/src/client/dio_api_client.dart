import 'package:api_client/src/exception/api_exception.dart';
import 'package:api_client/src/interceptor/interceptor.dart';
import 'package:dio/dio.dart';

/// {@template dio_api_client}
/// Simple API client implemented with [Dio].
/// {@endtemplate}
class DioApiClient {
  /// {@macro dio_api_client}
  DioApiClient({
    required Dio dio,
    LoggingInterceptor? loggingInterceptor,
    AuthInterceptor? authInterceptor,
  }) : _dio = dio {
    if (loggingInterceptor != null) {
      _dio.interceptors.add(loggingInterceptor);
    }
    if (authInterceptor != null) {
      _dio.interceptors.add(authInterceptor);
    }
  }

  late final Dio _dio;

  ///
  Future<Map<String, dynamic>> get(
    Uri url, {
    Map<String, String>? queryParameters,
  }) async =>
      _makeCall(
        _dio.get<Map<String, dynamic>>(
          url.toString(),
          queryParameters: queryParameters,
        ),
      );

  ///
  Future<Map<String, dynamic>> post(
    Uri url, {
    Map<String, String>? queryParameters,
    Object? body,
  }) async =>
      _makeCall(
        _dio.post<Map<String, dynamic>>(
          url.toString(),
          data: body,
          queryParameters: queryParameters,
        ),
      );

  Future<Map<String, dynamic>> _makeCall(
    Future<Response<Map<String, dynamic>>> call,
  ) async {
    late final Response<Map<String, dynamic>> response;
    try {
      response = await call;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        NetworkException(error),
        (error is DioError) ? error.stackTrace ?? stackTrace : stackTrace,
      );
    }

    final data = response.data;
    if (_isSuccessful(response)) {
      return data ?? <String, dynamic>{};
    } else {
      throw const DeserializationException.emptyResponseBody();
    }
  }

  bool _isSuccessful(Response response) {
    return (response.statusCode == 200 && response.data != null) ||
        (response.statusCode == 204 && response.data == null);
  }
}
