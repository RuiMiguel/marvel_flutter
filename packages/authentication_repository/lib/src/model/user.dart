import 'package:equatable/equatable.dart';

/// {@template user}
/// User with credentials.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.privateKey,
    required this.publicKey,
  });

  /// Not logged / anonymous user
  const User.anonymous()
      : privateKey = '',
        publicKey = '';

  /// Private key credential.
  final String privateKey;

  /// Public key credential.
  final String publicKey;

  @override
  List<Object?> get props => [privateKey, publicKey];
}
