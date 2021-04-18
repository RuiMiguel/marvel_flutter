import 'dart:io';

import 'package:marvel/data/base/error/data_failure.dart';

abstract class BaseApiClient {
  Future<T> makeCall<T>(
    dynamic call,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
    T Function(dynamic) manageException,
  ) async {
    try {
      return parseResponse(await call, parseSuccess, parseError);
    } on SocketException {
      return manageException(SocketFailure());
    } on HttpException {
      return manageException(HttpFailure());
    } on FormatException {
      return manageException(FormatFailure());
    }
  }

  T parseResponse<T, R>(
    R response,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
  ) {
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
