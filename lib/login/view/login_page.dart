import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/home/widget/widget.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/login.dart';
import 'package:marvel/styles/styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static PageRoute page() =>
      MaterialPageRoute<void>(builder: (_) => const LoginPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
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
      builder: (context, state) {
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
                              if (state.status ==
                                  AuthenticationStatus.authenticated)
                                const AuthenticatedDescription(),
                              if (state.status ==
                                  AuthenticationStatus.unauthenticated)
                                const UnauthenticatedDescription(),
                              const SizedBox(height: 20),
                              const LoginForm(),
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
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final loginBloc = context.read<LoginBloc>();

    final authState = context.watch<AuthenticationBloc>().state;

    var privateKey = authState.user?.privateKey ?? '';
    var publicKey = authState.user?.publicKey ?? '';

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.login_fail),
          ),
        );
      },
      listenWhen: (previous, current) => current.status == LoginStatus.failure,
      buildWhen: (previous, current) => current.status != LoginStatus.initial,
      builder: (context, state) {
        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginTextInput(
                labelText: l10n.private_key,
                text: privateKey,
                submit: (value) {
                  loginBloc.add(SetPrivateKey(value));
                },
              ),
              const SizedBox(height: 30),
              LoginTextInput(
                labelText: l10n.public_key,
                text: publicKey,
                submit: (value) {
                  loginBloc.add(SetPublicKey(value));
                },
              ),
              const SizedBox(height: 80),
              if (authState.status == AuthenticationStatus.authenticated)
                AuthenticatedButtons(
                  onLogin: () async {
                    loginBloc.add(Login());
                  },
                  onLogout: () {
                    loginBloc.add(Logout());
                  },
                ),
              if (authState.status == AuthenticationStatus.unauthenticated)
                UnauthenticatedButtons(
                  onUpdate: () async {
                    loginBloc.add(Login());
                  },
                ),
              const SizedBox(height: 80),
              if (state.status == LoginStatus.loading)
                const CircularProgressIndicator(
                  color: red,
                ),
            ],
          ),
        );
      },
    );
  }
}
