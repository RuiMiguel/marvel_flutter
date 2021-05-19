import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/bloc/authentication/authentication_bloc.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:marvel/ui/login/login_screen.dart';

import 'commons/splash_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.add(HasAuthenticated());

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, AuthenticationState state) {
      switch (state.runtimeType) {
        case Authenticated:
          return HomeScreen();
        case UnAuthenticated:
          return LoginScreen();
        default:
          return SplashScreen();
      }
    });
  }
}
