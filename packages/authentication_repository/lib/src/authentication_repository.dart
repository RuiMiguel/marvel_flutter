import 'dart:async';

import 'package:secure_storage/secure_storage.dart';

/// {@template authentication_repository}
/// Repository to manage authentication credentials.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository(SecureStorage secureStorage)
      : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  final _credentialsController = StreamController<bool>.broadcast();

  /// Stream to keep credential status.
  Stream<bool> get credentials {
    return _credentialsController.stream.map((value) => value);
  }

  /// Do login with [privateKey] and [publicKey].
  Future<void> login({
    required String privateKey,
    required String publicKey,
  }) async {
    try {
      await _secureStorage.saveCredentials(
        privateKey: privateKey,
        publicKey: publicKey,
      );
      _credentialsController.add(true);
    } catch (e) {
      _credentialsController.add(false);
      rethrow;
    }
  }

  /// Logout and clean credentials.
  Future<void> logout() async {
    try {
      await _secureStorage.clearCredentials();
      _credentialsController.add(false);
    } catch (e) {
      _credentialsController.add(true);
      rethrow;
    }
  }

  /// Close stream controllers.
  Future<void> dispose() => _credentialsController.close();
}
