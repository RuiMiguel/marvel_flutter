// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/login/bloc/login_bloc.dart';
import 'package:marvel/login/view/login_page.dart';
import 'package:marvel/login/widgets/authenticated_buttons_view.dart';
import 'package:marvel/login/widgets/authenticated_description_view.dart';
import 'package:marvel/login/widgets/login_textinput_view.dart';
import 'package:marvel/login/widgets/unauthenticated_buttons_view.dart';
import 'package:marvel/login/widgets/unauthenticated_description_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockLoginBloc extends Mock implements LoginBloc {}

class _MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  const privateKey = 'privateKey';
  const publicKey = 'publicKey';

  late LoginBloc loginBloc;
  late AuthenticationBloc authenticationBloc;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    loginBloc = _MockLoginBloc();
    authenticationBloc = _MockAuthenticationBloc();
  });

  group('LoginPage', () {
    test('is routable', () {
      expect(LoginPage.page(), isA<MaterialPageRoute>());
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        authenticationBloc = _MockAuthenticationBloc();

        whenListen(
          authenticationBloc,
          Stream.value(AuthenticationState.unauthenticated()),
          initialState: AuthenticationState.unauthenticated(),
        );

        await tester.pumpApp(
          LoginPage(),
          authenticationBloc: authenticationBloc,
        );

        expect(find.byType(LoginView), findsOneWidget);
      },
    );

    group('LoginView', () {
      testWidgets(
        'shows error message if login fails',
        (tester) async {
          authenticationBloc = _MockAuthenticationBloc();
          whenListen(
            authenticationBloc,
            Stream.value(AuthenticationState.unauthenticated()),
            initialState: AuthenticationState.unauthenticated(),
          );

          final loginBlocController = StreamController<LoginState>();
          whenListen(
            loginBloc,
            loginBlocController.stream,
            initialState: LoginState(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: loginBloc,
              child: LoginView(),
            ),
            authenticationBloc: authenticationBloc,
          );

          loginBlocController.add(LoginState(status: LoginStatus.failure));
          await tester.pumpAndSettle();

          expect(find.byType(SnackBar), findsOneWidget);
        },
      );

      testWidgets(
        'shows success message if login is successful',
        (tester) async {
          authenticationBloc = _MockAuthenticationBloc();
          whenListen(
            authenticationBloc,
            Stream.value(AuthenticationState.unauthenticated()),
            initialState: AuthenticationState.unauthenticated(),
          );

          final loginBlocController = StreamController<LoginState>();
          whenListen(
            loginBloc,
            loginBlocController.stream,
            initialState: LoginState(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: loginBloc,
              child: LoginView(),
            ),
            authenticationBloc: authenticationBloc,
          );

          loginBlocController.add(LoginState(status: LoginStatus.success));
          await tester.pumpAndSettle();

          expect(find.byType(SnackBar), findsOneWidget);
        },
      );

      group('on authenticated', () {
        final user = User(
          privateKey: privateKey,
          publicKey: publicKey,
        );

        setUp(() {
          authenticationBloc = _MockAuthenticationBloc();
          whenListen(
            authenticationBloc,
            Stream.value(AuthenticationState.authenticated(user)),
            initialState: AuthenticationState.authenticated(user),
          );
        });

        testWidgets(
          'renders correctly',
          (tester) async {
            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            expect(find.byType(HeroesAppBar), findsOneWidget);
            expect(find.byType(AuthenticatedDescription), findsOneWidget);
            expect(find.byType(AuthenticatedButtons), findsOneWidget);
          },
        );

        testWidgets(
          'shows progress indicator while is loading',
          (tester) async {
            final loginBlocController = StreamController<LoginState>();
            whenListen(
              loginBloc,
              loginBlocController.stream,
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            loginBlocController.add(LoginState(status: LoginStatus.loading));
            await tester.pump();
            await tester.pump();

            expect(find.byType(CircularProgressIndicator), findsOneWidget);
          },
        );

        testWidgets(
          'adds PrivateKeySetted event when private key changes',
          (tester) async {
            final l10n =
                await AppLocalizations.delegate.load(const Locale('en'));
            const text = 'key';

            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            tester
                .widget<LoginTextInput>(
                  find.byWidgetPredicate(
                    (widget) =>
                        widget is LoginTextInput &&
                        widget.labelText == l10n.private_key,
                  ),
                )
                .onChanged(text);

            verify(() => loginBloc.add(PrivateKeySetted(text))).called(1);
          },
        );

        testWidgets(
          'adds PublicKeySetted event when public key changes',
          (tester) async {
            final l10n =
                await AppLocalizations.delegate.load(const Locale('en'));
            const text = 'key';

            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            tester
                .widget<LoginTextInput>(
                  find.byWidgetPredicate(
                    (widget) =>
                        widget is LoginTextInput &&
                        widget.labelText == l10n.public_key,
                  ),
                )
                .onChanged(text);

            verify(() => loginBloc.add(PublicKeySetted(text))).called(1);
          },
        );

        testWidgets(
          'adds Login event when save is clicked',
          (tester) async {
            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            tester
                .widget<AuthenticatedButtons>(
                  find.byType(AuthenticatedButtons),
                )
                .onSave();

            verify(() => loginBloc.add(Login())).called(1);
          },
        );

        testWidgets(
          'adds Logout event when logout is clicked',
          (tester) async {
            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            tester
                .widget<AuthenticatedButtons>(
                  find.byType(AuthenticatedButtons),
                )
                .onLogout();

            verify(() => loginBloc.add(Logout())).called(1);
          },
        );
      });

      group('on unauthenticated', () {
        setUp(() {
          authenticationBloc = _MockAuthenticationBloc();
          whenListen(
            authenticationBloc,
            Stream.value(AuthenticationState.unauthenticated()),
            initialState: AuthenticationState.unauthenticated(),
          );
        });

        testWidgets(
          'renders correctly',
          (tester) async {
            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            expect(find.byType(HeroesAppBar), findsOneWidget);
            expect(find.byType(UnauthenticatedDescription), findsOneWidget);
            expect(find.byType(UnauthenticatedButtons), findsOneWidget);
          },
        );

        testWidgets(
          'shows progress indicator while is loading',
          (tester) async {
            final loginBlocController = StreamController<LoginState>();
            whenListen(
              loginBloc,
              loginBlocController.stream,
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            loginBlocController.add(LoginState(status: LoginStatus.loading));
            await tester.pump();
            await tester.pump();

            expect(find.byType(CircularProgressIndicator), findsOneWidget);
          },
        );

        testWidgets(
          'adds Login event when login is clicked',
          (tester) async {
            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            tester
                .widget<UnauthenticatedButtons>(
                  find.byType(UnauthenticatedButtons),
                )
                .onLogin();

            verify(() => loginBloc.add(Login())).called(1);
          },
        );

        testWidgets(
          'adds PrivateKeySetted event when private key changes',
          (tester) async {
            final l10n =
                await AppLocalizations.delegate.load(const Locale('en'));
            const text = 'key';

            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            tester
                .widget<LoginTextInput>(
                  find.byWidgetPredicate(
                    (widget) =>
                        widget is LoginTextInput &&
                        widget.labelText == l10n.private_key,
                  ),
                )
                .onChanged(text);

            verify(() => loginBloc.add(PrivateKeySetted(text))).called(1);
          },
        );

        testWidgets(
          'adds PublicKeySetted event when public key changes',
          (tester) async {
            final l10n =
                await AppLocalizations.delegate.load(const Locale('en'));
            const text = 'key';

            whenListen(
              loginBloc,
              Stream.value(LoginState()),
              initialState: LoginState(),
            );

            await tester.pumpApp(
              BlocProvider.value(
                value: loginBloc,
                child: LoginView(),
              ),
              authenticationBloc: authenticationBloc,
            );

            tester
                .widget<LoginTextInput>(
                  find.byWidgetPredicate(
                    (widget) =>
                        widget is LoginTextInput &&
                        widget.labelText == l10n.public_key,
                  ),
                )
                .onChanged(text);

            verify(() => loginBloc.add(PublicKeySetted(text))).called(1);
          },
        );
      });
    });
  });
}
