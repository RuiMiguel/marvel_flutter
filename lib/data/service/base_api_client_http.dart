import 'dart:convert';

import 'package:http/http.dart';
import 'package:marvel/data/service/base_api_client.dart';

abstract class BaseApiClientHttp extends BaseApiClient {
  final bool _logEnabled;

  final Client _httpClient = Client();

  BaseApiClientHttp(this._logEnabled);

  @override
  Future<T> requestGet<T>(Uri url, T Function(dynamic) parseSuccess,
      T Function(int, dynamic) parseError,
      {Map<String, String>? headers}) async {
    if (_logEnabled) print("[Http] HTTP Request - GET $url");

    final response = await _httpClient.get(
      url,
      headers: headers,
    );
    return parseResponse(response, parseSuccess, parseError);
  }

  @override
  Future<T> requestPost<T>(Uri url, T Function(dynamic) parseSuccess,
      T Function(int, dynamic) parseError,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    if (_logEnabled) print("[Http] HTTP Request - POST $url");

    final response = await _httpClient.post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return parseResponse(response, parseSuccess, parseError);
  }

  @override
  bool isSuccessfull(dynamic response) {
    return (response.statusCode == 200) ||
        (response.statusCode == 204 && response.body.isEmpty);
  }

  @override
  T parseResponseSuccess<T>(
    dynamic response,
    T Function(dynamic) parseSuccess,
  ) {
    if (_logEnabled) print("[Http] HTTP Response - ${response.body}");

    var json = jsonDecode(response.body);
    return parseSuccess(json);
  }

  @override
  T parseResponseError<T>(
    dynamic response,
    T Function(int, dynamic) parseError,
  ) {
    if (_logEnabled)
      print(
          "[Http] HTTP Error - ${response.statusCode} ${response.reasonPhrase}");

    var json = jsonDecode(response.body);
    var errorCode = response.statusCode;
    return parseError(errorCode, json);
  }
}
