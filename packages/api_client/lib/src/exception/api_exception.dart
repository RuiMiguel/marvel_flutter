abstract class ApiException implements Exception {
  const ApiException(this.error);

  final Object error;
}

class NetworkException extends ApiException {
  const NetworkException(Object error) : super(error);

  @override
  String toString() => '[NetworkException] $error';
}

class ServerException extends ApiException {
  const ServerException(Object error) : super(error);

  @override
  String toString() => '[ServerException] $error';
}

class DeserializationException extends ApiException {
  const DeserializationException(Object error) : super(error);

  const DeserializationException.emptyResponseBody()
      : super('Empty response body');

  @override
  String toString() => '[DeserializationException] $error';
}
