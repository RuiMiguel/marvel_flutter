abstract class BaseApiClient {
  Future<T> makeCall<T>(
    dynamic call,
    T Function(dynamic) parseSuccess,
    T Function(int, dynamic) parseError,
  ) async {
    return parseResponse(await call, parseSuccess, parseError);
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
