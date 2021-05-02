import 'dart:io';

import 'package:core_data_network/src/error/data_failure.dart';

abstract class BaseApiClient {
  Future<T> makeCall<T>(
    dynamic call,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
    T Function(dynamic) manageException,
  ) async {
    try {
      return parseResponse(await call, parseSuccess, parseError);
    } catch (exception) {
      return processException(exception, manageException);
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

  T processException<T>(
    error,
    T Function(dynamic) manageException,
  ) {
    if (error is SocketException) {
      return manageException(SocketFailure());
    } else if (error is HttpException) {
      return manageException(HttpFailure());
    } else if (error is FormatException) {
      return manageException(FormatFailure());
    } else {
      return manageException(
        ServerFailure(code: "99", message: "ERROR: $error"),
      );
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
