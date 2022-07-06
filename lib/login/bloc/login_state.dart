part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  LoginState({
    this.status = LoginStatus.initial,
    this.privateKey = '',
    this.publicKey = '',
  });

  final LoginStatus status;
  String privateKey;
  String publicKey;

  @override
  List<Object> get props => [status, privateKey, publicKey];

  LoginState copyWith({
    LoginStatus? status,
    String? privateKey,
    String? publicKey,
  }) {
    return LoginState(
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
    );
  }
}
