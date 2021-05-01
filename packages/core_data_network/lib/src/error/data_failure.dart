import 'package:core_domain/core_domain.dart';

abstract class NetworkFailure extends Failure {}

class ServerFailure extends NetworkFailure {
  ServerFailure({this.code = "0", this.message = ""});
  final String code;
  final String message;
}

class SocketFailure extends NetworkFailure {}

class HttpFailure extends NetworkFailure {}

class FormatFailure extends NetworkFailure {}
