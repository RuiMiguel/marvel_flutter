part of 'auto_login_bloc.dart';

abstract class AutoLoginEvent extends Equatable {
  const AutoLoginEvent();
}

class AutoLogin extends AutoLoginEvent {
  const AutoLogin();

  @override
  List<Object> get props => [];
}
