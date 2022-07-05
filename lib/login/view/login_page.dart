import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/home/widget/widget.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/login.dart';
import 'package:marvel/styles/styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(color: Theme.of(context).primaryColor);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return SafeArea(
          child: Scaffold(
            appBar: const HeroesAppBar(withActions: false),
            body: Column(
              children: [
                Expanded(
                  child: ColoredBox(
                    color: Theme.of(context).shadowColor,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (authState.status ==
                                  AuthenticationStatus.authenticated)
                                const AuthenticatedDescription(),
                              if (authState.status ==
                                  AuthenticationStatus.unauthenticated)
                                const UnauthenticatedDescription(),
                              const SizedBox(height: 20),
                              LoginForm(authState: authState),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.authState});

  final AuthenticationState authState;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final loginBloc = context.read<LoginBloc>();

    var privateKey = '';
    var publicKey = '';

/*
            switch (authState.status) {
              case AuthenticationStatus.authenticated:
                privateKey = authState.privateKey;
                publicKey = authState.publicKey;
                break;
              case AuthenticationStatus.unauthenticated:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.l10n.login_fail),
                  ),
                );
                break;
            }
*/
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginTextInput(
                labelText: l10n.private_key,
                text: privateKey,
                submit: (value) {
                  //loginBloc.add(SetPrivateKey(value));
                },
              ),
              const SizedBox(height: 30),
              LoginTextInput(
                labelText: l10n.public_key,
                text: publicKey,
                submit: (value) {
                  //loginBloc.add(SetPublicKey(value));
                },
              ),
              const SizedBox(height: 80),
              if (authState.status == AuthenticationStatus.authenticated)
                AuthenticatedButtons(
                  onLogin: () async {
                    //loginBloc.add(Login());
                  },
                  onLogout: () {
                    //loginBloc.add(Logout());
                  },
                ),
              if (authState.status == AuthenticationStatus.unauthenticated)
                UnauthenticatedButtons(
                  onUpdate: () async {
                    //loginBloc.add(Login()),
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
