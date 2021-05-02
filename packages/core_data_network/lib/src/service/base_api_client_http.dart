import 'dart:convert';

import 'package:core_data_network/core_data_network.dart';
import 'package:http/http.dart';

abstract class BaseApiClientHttp extends BaseApiClient {
  final bool logEnabled;
  late Client _httpClient = Client();

  BaseApiClientHttp({Client? httpClient, this.logEnabled = false}) {
    _httpClient = httpClient ?? Client();
  }

  Future<T> requestGet<T>(
    Uri url,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
    T Function(dynamic) manageException, {
    Map<String, String>? headers,
  }) {
    if (logEnabled) {
      print("[Http] HTTP Request - GET $url");
      print("[Http] headers - ${json.encode(headers)}");
    }

    return makeCall(
      _httpClient.get(
        url,
        headers: headers,
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
    if (logEnabled) {
      print("[Http] HTTP Request - POST $url");
      print("[Http] headers - ${json.encode(headers)}");
    }

    return makeCall(
      _httpClient.post(
        url,
        headers: headers,
        body: body,
        encoding: encoding,
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
    print("[Http] HTTP Error - $error");
    return super.processException(error, manageException);
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
    if (logEnabled)
      print("[Http] HTTP Response - ${response.statusCode} ${response.body}");

    var json = jsonDecode(response.body);
    return parseSuccess(json);
  }

  @override
  T parseResponseError<T>(
    dynamic response,
    T Function(int, dynamic) parseError,
  ) {
    if (logEnabled)
      print(
          "[Http] HTTP Error - ${response.statusCode} ${response.reasonPhrase}");

    var json = jsonDecode(response.body);
    var errorCode = response.statusCode;
    return parseError(errorCode, json);
  }
}
