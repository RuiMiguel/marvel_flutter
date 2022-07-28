// ignore_for_file: avoid_print

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

/// {@template auth_interceptor}
/// Interceptor for authenticate requests at [Dio] client.
/// {@endtemplate}
class AuthInterceptor extends Interceptor {
  /// {@macro auth_interceptor}
  AuthInterceptor({required Security security}) : _security = security;

  final Security _security;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final hashTimestamp = await _security.hashTimestamp();
    String publicKey;

    try {
      publicKey = await _security.publicKey;
    } catch (error, stackTrace) {
      throw AuthenticationException(error, stackTrace);
    }

    options.queryParameters.addAll(<String, String>{
      'ts': hashTimestamp['timestamp']!,
      'hash': hashTimestamp['hash']!,
      'apikey': publicKey,
    });

    return super.onRequest(options, handler);
  }
}
