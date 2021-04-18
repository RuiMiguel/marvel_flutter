import 'dart:convert';

abstract class BaseApiClient {
  Future<T> requestGet<T>(Uri url, T Function(dynamic) parseSuccess,
      T Function(int, dynamic) parseError,
      {Map<String, String>? headers});

  Future<T> requestPost<T>(Uri url, T Function(dynamic) parseSuccess,
      T Function(int, dynamic) parseError,
      {Map<String, String>? headers, Object? body, Encoding? encoding});

  Future<T> parseResponse<T, R>(R response, T Function(dynamic) parseSuccess,
      T Function(int, dynamic) parseError) async {
    if (isSuccessfull(response)) {
      return parseResponseSuccess(response, parseSuccess);
    } else {
      return parseResponseError(response, parseError);
    }
  }

  bool isSuccessfull(dynamic response);

  T parseResponseSuccess<T>(
    dynamic response,
    T Function(dynamic) parseSuccess,
  );

  T parseResponseError<T>(
    dynamic response,
    T Function(int, dynamic) parseError,
  );
}
