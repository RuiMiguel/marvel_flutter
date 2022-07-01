// ignore_for_file: public_member_api_docs

abstract class StorageException implements Exception {
  const StorageException(this.error, [this.stackTrace]);

  final Object error;

  final StackTrace? stackTrace;
}

class ReadException extends StorageException {
  const ReadException(super.error, [super.stackTrace]);

  @override
  String toString() => '[ReadException] $error';
}

class WriteException extends StorageException {
  const WriteException(super.error, [super.stackTrace]);

  @override
  String toString() => '[WriteException] $error';
}
