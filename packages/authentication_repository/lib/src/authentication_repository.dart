import 'dart:async';

import 'package:authentication_repository/src/model/model.dart';
import 'package:secure_storage/secure_storage.dart';

/// {@template authentication_repository}
/// Repository to manage authentication credentials.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository(SecureStorage secureStorage)
      : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  final _userController = StreamController<User>();

  /// Stream to keep credential status.
  Stream<User> get user => _userController.stream.asBroadcastStream();

  /// Returns privateKey saved at storage.
  Future<String> privateKey() => _secureStorage.privateKey();

  /// Returns publicKey saved at storage.
  Future<String> publicKey() => _secureStorage.publicKey();

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
      await Future<void>.delayed(const Duration(seconds: 3));

      _syncUser(
        User(
          privateKey: privateKey,
          publicKey: publicKey,
        ),
      );
    } catch (e) {
      _syncUser(const User.anonymous());
      rethrow;
    }
  }

  /// Logout and clean credentials.
  Future<void> logout() async {
    try {
      await _secureStorage.clearCredentials();
      await Future<void>.delayed(const Duration(seconds: 2));

      _syncUser(const User.anonymous());
    } catch (e) {
      rethrow;
    }
  }

  /// Close stream controllers.
  Future<void> dispose() => _userController.close();

  void _syncUser(User user) => _userController.sink.add(user);
}
