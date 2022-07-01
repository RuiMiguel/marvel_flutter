import 'package:secure_storage/secure_storage.dart';

/// {@template authentication_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  const AuthenticationRepository(SecureStorage secureStorage)
      : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;
}
