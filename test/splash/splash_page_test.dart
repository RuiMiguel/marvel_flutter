// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/home/home.dart';
import 'package:marvel/login/login.dart';
import 'package:marvel/splash/bloc/auto_login_bloc.dart';
import 'package:marvel/splash/splash_page.dart';
import 'package:marvel/styles/colors.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mock_hydrated_storage.dart';
import '../helpers/pump_app.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockAutoLoginBloc extends Mock implements AutoLoginBloc {}

class _MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  const privateKey = 'privateKey';
  const publicKey = 'publicKey';

  late AuthenticationRepository authenticationRepository;
  late AutoLoginBloc autoLoginBloc;
  late AuthenticationBloc authenticationBloc;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    authenticationRepository = _MockAuthenticationRepository();

    when(
      () => authenticationRepository.privateKey(),
    ).thenAnswer((_) async => privateKey);
    when(
      () => authenticationRepository.publicKey(),
    ).thenAnswer((_) async => publicKey);
    when(
      () => authenticationRepository.login(
        privateKey: any(named: 'privateKey'),
        publicKey: any(named: 'publicKey'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => authenticationRepository.logout(),
    ).thenAnswer((_) async {});
  });

  group('SplashPage', () {
    test('is routable', () {
      expect(SplashPage.page(), isA<MaterialPage>());
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        final authenticationBloc = _MockAuthenticationBloc();
        final authenticationBlocController =
            StreamController<AuthenticationState>();

        whenListen(
          authenticationBloc,
          authenticationBlocController.stream,
          initialState: AuthenticationState.unauthenticated(),
        );

        await mockHydratedStorageAsync(() async {
          await tester.pumpApp(
            SplashPage(),
            authenticationRepository: authenticationRepository,
            authenticationBloc: authenticationBloc,
          );
        });

        authenticationBlocController.add(
          AuthenticationState(
            status: AuthenticationStatus.unauthenticated,
            user: User.anonymous(),
          ),
        );

        expect(find.byType(SplashView), findsOneWidget);
      },
    );

    group('SplashView', () {
      testWidgets(
        'renders correctly',
        (tester) async {
          autoLoginBloc = _MockAutoLoginBloc();
          final autoLoginBlocController = StreamController<AutoLoginState>();
          whenListen(
            autoLoginBloc,
            autoLoginBlocController.stream,
            initialState: AutoLoginState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: autoLoginBloc,
              child: SplashView(),
            ),
          );

          expect(
            find.byWidgetPredicate(
              (widget) => widget is ColoredBox && widget.color == red,
            ),
            findsOneWidget,
          );
          expect(find.byType(Image), findsOneWidget);
        },
      );

      testWidgets(
        "doesn't show CircularProgressIndicator "
        'when AutoLoginStatus is not loading',
        (tester) async {
          autoLoginBloc = _MockAutoLoginBloc();
          final autoLoginBlocController = StreamController<AutoLoginState>();
          whenListen(
            autoLoginBloc,
            autoLoginBlocController.stream,
            initialState: AutoLoginState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: autoLoginBloc,
              child: SplashView(),
            ),
          );

          await tester.pump();
          await tester.pump();

          expect(find.byType(CircularProgressIndicator), findsNothing);
        },
      );

      testWidgets(
        'shows CircularProgressIndicator when AutoLoginStatus loading',
        (tester) async {
          autoLoginBloc = _MockAutoLoginBloc();
          final autoLoginBlocController = StreamController<AutoLoginState>();
          whenListen(
            autoLoginBloc,
            autoLoginBlocController.stream,
            initialState: AutoLoginState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: autoLoginBloc,
              child: SplashView(),
            ),
          );

          autoLoginBlocController.add(
            AutoLoginState(status: AutoLoginStatus.loading),
          );

          await tester.pump();
          await tester.pump();

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'navigates to HomePage when AutoLoginStatus success',
        (tester) async {
          authenticationBloc = _MockAuthenticationBloc();
          whenListen(
            authenticationBloc,
            Stream.value(
              AuthenticationState.authenticated(
                User(privateKey: privateKey, publicKey: publicKey),
              ),
            ),
            initialState: AuthenticationState.unauthenticated(),
          );

          autoLoginBloc = _MockAutoLoginBloc();
          final autoLoginBlocController = StreamController<AutoLoginState>();
          whenListen(
            autoLoginBloc,
            autoLoginBlocController.stream,
            initialState: AutoLoginState.initial(),
          );

          await mockHydratedStorage(() async {
            await tester.pumpApp(
              BlocProvider.value(
                value: autoLoginBloc,
                child: SplashView(),
              ),
              authenticationRepository: authenticationRepository,
              authenticationBloc: authenticationBloc,
            );
          });

          autoLoginBlocController.add(
            AutoLoginState(status: AutoLoginStatus.success),
          );

          await tester.pumpAndSettle();

          expect(find.byType(HomePage), findsOneWidget);
        },
      );

      testWidgets(
        'shows SnackBar when AutoLoginStatus error',
        (tester) async {
          authenticationBloc = _MockAuthenticationBloc();
          whenListen(
            authenticationBloc,
            Stream.value(AuthenticationState.unauthenticated()),
            initialState: AuthenticationState.unauthenticated(),
          );

          autoLoginBloc = _MockAutoLoginBloc();
          final autoLoginBlocController = StreamController<AutoLoginState>();
          whenListen(
            autoLoginBloc,
            autoLoginBlocController.stream,
            initialState: AutoLoginState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: autoLoginBloc,
              child: SplashView(),
            ),
            authenticationBloc: authenticationBloc,
          );

          autoLoginBlocController.add(
            AutoLoginState(status: AutoLoginStatus.error),
          );
          await tester.pumpAndSettle();

          expect(find.byType(SnackBar), findsOneWidget);
        },
      );

      testWidgets(
        'navigates to LoginPage when AutoLoginStatus error',
        (tester) async {
          authenticationBloc = _MockAuthenticationBloc();
          whenListen(
            authenticationBloc,
            Stream.value(AuthenticationState.unauthenticated()),
            initialState: AuthenticationState.unauthenticated(),
          );

          autoLoginBloc = _MockAutoLoginBloc();
          final autoLoginBlocController = StreamController<AutoLoginState>();
          whenListen(
            autoLoginBloc,
            autoLoginBlocController.stream,
            initialState: AutoLoginState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: autoLoginBloc,
              child: SplashView(),
            ),
            authenticationRepository: authenticationRepository,
            authenticationBloc: authenticationBloc,
          );

          autoLoginBlocController.add(
            AutoLoginState(status: AutoLoginStatus.error),
          );

          await tester.pumpAndSettle();

          expect(find.byType(LoginPage), findsOneWidget);
        },
      );
    });
  });
}
