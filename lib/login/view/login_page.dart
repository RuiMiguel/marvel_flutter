import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/common/widget/widget.dart';
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

@visibleForTesting
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context).setStatusBarTheme(color: Theme.of(context).primaryColor);

    final authState = context.watch<AuthenticationBloc>().state;
    final loginBloc = context.read<LoginBloc>();

    final privateKey = authState.user?.privateKey ?? '';
    final publicKey = authState.user?.publicKey ?? '';

    loginBloc
      ..add(PrivateKeySetted(privateKey))
      ..add(PublicKeySetted(publicKey));

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          context.showErrorMessage(context.l10n.login_fail);
        }
        if (state.status == LoginStatus.success) {
          context.showSuccessMessage(context.l10n.success);
        }
      },
      listenWhen: (previous, current) => current.status != LoginStatus.loading,
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
                              if (authState.status ==
                                  AuthenticationStatus.authenticated)
                                _AuthenticatedLoginForm(
                                  privateKey: privateKey,
                                  publicKey: publicKey,
                                ),
                              if (authState.status ==
                                  AuthenticationStatus.unauthenticated)
                                const _UnauthenticatedLoginForm(),
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

class _AuthenticatedLoginForm extends StatelessWidget {
  const _AuthenticatedLoginForm({
    required this.privateKey,
    required this.publicKey,
  });

  final String privateKey;
  final String publicKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        final loginBloc = context.read<LoginBloc>();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AuthenticatedDescription(),
            const SizedBox(height: 20),
            LoginTextInput(
              labelText: l10n.private_key,
              text: privateKey,
              enabled: !state.status.isLoading,
              onChanged: (value) => loginBloc.add(PrivateKeySetted(value)),
            ),
            const SizedBox(height: 30),
            LoginTextInput(
              labelText: l10n.public_key,
              text: publicKey,
              enabled: !state.status.isLoading,
              onChanged: (value) => loginBloc.add(PublicKeySetted(value)),
            ),
            const SizedBox(height: 80),
            AuthenticatedButtons(
              onSave: () => loginBloc.add(Login()),
              onLogout: () => loginBloc.add(Logout()),
              enabled: !state.status.isLoading,
            ),
            const SizedBox(height: 80),
            if (state.status.isLoading)
              const CircularProgressIndicator(
                color: red,
              ),
          ],
        );
      },
    );
  }
}

class _UnauthenticatedLoginForm extends StatelessWidget {
  const _UnauthenticatedLoginForm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        final loginBloc = context.read<LoginBloc>();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UnauthenticatedDescription(),
            const SizedBox(height: 20),
            LoginTextInput(
              labelText: l10n.private_key,
              enabled: !state.status.isLoading,
              onChanged: (value) => loginBloc.add(PrivateKeySetted(value)),
            ),
            const SizedBox(height: 30),
            LoginTextInput(
              labelText: l10n.public_key,
              enabled: !state.status.isLoading,
              onChanged: (value) => loginBloc.add(PublicKeySetted(value)),
            ),
            const SizedBox(height: 80),
            UnauthenticatedButtons(
              onLogin: () => loginBloc.add(Login()),
              enabled: !state.status.isLoading,
            ),
            const SizedBox(height: 80),
            if (state.status.isLoading)
              const CircularProgressIndicator(
                color: red,
              ),
          ],
        );
      },
    );
  }
}
