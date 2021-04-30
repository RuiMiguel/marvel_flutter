import 'package:core_base/core_base.dart';

abstract class NetworkFailure extends Failure {}

class ServerFailure extends NetworkFailure {
  ServerFailure({required this.code, required this.message});
  final String code;
  final String message;
}

class SocketFailure extends NetworkFailure {}

class HttpFailure extends NetworkFailure {}

class FormatFailure extends NetworkFailure {}
