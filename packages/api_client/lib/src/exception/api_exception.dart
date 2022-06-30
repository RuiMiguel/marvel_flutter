// ignore_for_file: public_member_api_docs

abstract class ApiException implements Exception {
  const ApiException(this.error);

  final Object error;
}

class NetworkException extends ApiException {
  const NetworkException(super.error);

  @override
  String toString() => '[NetworkException] $error';
}

class ServerException extends ApiException {
  const ServerException(super.error);

  @override
  String toString() => '[ServerException] $error';
}

class DeserializationException extends ApiException {
  const DeserializationException(super.error);

  const DeserializationException.emptyResponseBody()
      : super('Empty response body');

  @override
  String toString() => '[DeserializationException] $error';
}
