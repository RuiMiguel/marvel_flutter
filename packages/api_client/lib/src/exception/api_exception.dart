// ignore_for_file: public_member_api_docs

abstract class ApiException implements Exception {
  const ApiException(this.error, [this.stackTrace]);

  final Object error;

  final StackTrace? stackTrace;
}

class NetworkException extends ApiException {
  const NetworkException(super.error, [super.stackTrace]);

  @override
  String toString() => '[NetworkException] $error';
}

class ServerException extends ApiException {
  const ServerException(super.error, [super.stackTrace]);

  @override
  String toString() => '[ServerException] $error';
}

class AuthenticationException extends ApiException {
  const AuthenticationException(super.error, [super.stackTrace]);

  @override
  String toString() => '[AuthenticationException] $error';
}

class DeserializationException extends ApiException {
  const DeserializationException(super.error, [super.stackTrace]);

  const DeserializationException.emptyResponseBody()
      : super('Empty response body');

  @override
  String toString() => '[DeserializationException] $error';
}
