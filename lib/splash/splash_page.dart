import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/characters/widget/loading_view.dart';
import 'package:marvel/home/home.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/login.dart';
import 'package:marvel/splash/bloc/auto_login_bloc.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Page page() => const MaterialPage<void>(child: SplashPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AutoLoginBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      )..add(const AutoLogin()),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    Theme.of(context).setStatusBarTheme(color: red);

    return BlocConsumer<AutoLoginBloc, AutoLoginState>(
      listener: (context, state) {
        if (state.status == AutoLoginStatus.success) {
          Navigator.of(context).pushAndRemoveUntil<void>(
            HomePage.page(),
            (_) => false,
          );
        }

        if (state.status == AutoLoginStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.auto_login_fail),
            ),
          );

          Navigator.of(context).pushAndRemoveUntil<void>(
            LoginPage.page(),
            (_) => false,
          );
        }
      },
      builder: (context, state) {
        return ColoredBox(
          color: red,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Center(
                child: Image.asset('assets/images/placeholder.png'),
              ),
              if (state.status == AutoLoginStatus.loading)
                const Positioned(
                  bottom: 80,
                  child: LoadingView(
                    height: 150,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
/*
Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/placeholder.png'),
                if (state.status == AutoLoginStatus.loading)
                  const LoadingView(),
              ],
            )
*/

