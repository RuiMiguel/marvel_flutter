import 'package:flutter/material.dart';
import 'package:marvel/controllers/login_controller.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:marvel/ui/login/login_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();

    switch (controller.currentAuthStatus) {
      case AuthStatus.AUTHENTICATED:
        return HomeScreen();
      default:
        return LoginScreen();
    }
  }
}
