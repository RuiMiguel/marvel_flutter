import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/bloc/authentication_bloc.dart';
import 'package:marvel/bloc/login_bloc.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/commons/custom_appbar.dart';
import 'package:marvel/ui/login/authenticated_buttons_view.dart';
import 'package:marvel/ui/login/authenticated_description_view.dart';
import 'package:marvel/ui/login/login_textinput__view.dart';
import 'package:marvel/ui/login/unauthenticated_buttons_view.dart';
import 'package:marvel/ui/login/unauthenticated_description_view.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  late LoginBloc loginBloc;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(color: Theme.of(context).primaryColor);

    loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            String privateKey = "";
            String publicKey = "";

            if (authState is Authenticated) {
              privateKey = authState.privateKey;
              publicKey = authState.publicKey;
            }
            if (authState is AuthenticationFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.login_fail),
                ),
              );
            }

            return SafeArea(
              child: Scaffold(
                appBar: CustomAppBar(),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(context).shadowColor,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (authState is Authenticated)
                                    AuthenticatedDescription(),
                                  if (authState is UnAuthenticated)
                                    UnauthenticatedDescription(),
                                  const SizedBox(height: 20),
                                  Form(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        LoginTextInput(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .private_key,
                                          text: privateKey,
                                          submit: (value) {
                                            loginBloc.add(SetPrivateKey(value));
                                          },
                                        ),
                                        const SizedBox(height: 30),
                                        LoginTextInput(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .public_key,
                                          text: publicKey,
                                          submit: (value) {
                                            loginBloc.add(SetPublicKey(value));
                                          },
                                        ),
                                        const SizedBox(height: 80),
                                        if (authState is Authenticated)
                                          AuthenticatedButtons(
                                            onLogin: (context) async {
                                              loginBloc.add(Login());
                                              if (loginState is LoggedIn) {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            onLogout: (context) {
                                              loginBloc.add(Logout());
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        if (authState is UnAuthenticated)
                                          UnauthenticatedButtons(
                                            onUpdate: (context) async {
                                              loginBloc.add(Login());
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
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
      },
    );
  }
}
