import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/bloc/authentication/authentication_bloc.dart';
import 'package:marvel/bloc/login/login_bloc.dart';
import 'package:marvel/ui/auth_screen.dart';
import 'package:marvel/ui/commons/splash_screen.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:marvel/ui/login/login_screen.dart';
import 'package:mocktail/mocktail.dart';

class FakeAuthenticationState extends Fake implements AuthenticationState {}

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class FakeLoginEvent extends Fake implements LoginEvent {}

class FakeLoginState extends Fake implements LoginState {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<LoginState>(FakeLoginState());
    registerFallbackValue<LoginEvent>(FakeLoginEvent());
  });

  group('AuthScreen', () {
    late AuthenticationBloc authenticationBloc;
    late LoginBloc loginBloc;

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      loginBloc = MockLoginBloc();
    });

    testWidgets('renders SplashScreen for Authentication UnInitialized',
        (tester) async {
      when(() => authenticationBloc.state).thenReturn(UnInitialized());

      await tester.pumpWidget(
        BlocProvider.value(
          value: authenticationBloc,
          child: const MaterialApp(
            home: AuthScreen(),
          ),
        ),
      );
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('renders LoginScreen for Authentication UnAuthenticated',
        (tester) async {
      when(() => loginBloc.state).thenReturn(const LoggedOut());
      when(() => authenticationBloc.state).thenReturn(UnAuthenticated());

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: authenticationBloc,
            ),
            BlocProvider.value(
              value: loginBloc,
            ),
          ],
          child: const MaterialApp(
            home: AuthScreen(),
          ),
        ),
      );
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('renders HomeScreen for Authentication Authenticated',
        (tester) async {
      when(() => authenticationBloc.state).thenReturn(
        const Authenticated(
          privateKey: 'FAKE_PRIVATE_KEY',
          publicKey: 'FAKE_PUBLIC_KEY',
        ),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: authenticationBloc,
            ),
            BlocProvider.value(
              value: loginBloc,
            ),
          ],
          child: const MaterialApp(
            home: AuthScreen(),
          ),
        ),
      );
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
