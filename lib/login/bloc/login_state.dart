part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.privateKey = '',
    this.publicKey = '',
  });

  final LoginStatus status;
  final String privateKey;
  final String publicKey;

  @override
  List<Object> get props => [status, privateKey, publicKey];

  LoginState copyWith({
    LoginStatus? status,
    String? privateKey,
    String? publicKey,
  }) {
    return LoginState(
      status: status ?? this.status,
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
    );
  }
}
