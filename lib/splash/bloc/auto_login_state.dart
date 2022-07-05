part of 'auto_login_bloc.dart';

enum AutoLoginStatus {
  initial,
  loading,
  success,
  error,
}

class AutoLoginState extends Equatable {
  const AutoLoginState({required this.status});

  const AutoLoginState.initial() : status = AutoLoginStatus.initial;

  final AutoLoginStatus status;

  @override
  List<Object?> get props => [status];

  AutoLoginState copyWith({
    AutoLoginStatus? status,
  }) {
    return AutoLoginState(
      status: status ?? this.status,
    );
  }
}
