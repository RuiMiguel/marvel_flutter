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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FakeAuthenticationState extends Fake implements AuthenticationState {}

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class FakeLoginEvent extends Fake implements LoginEvent {}

class FakeLoginState extends Fake implements LoginState {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockBuildContext extends Mock implements BuildContext {
  AppLocalizations get l10n => MockAppLocalizations();
}

class MockAppLocalizations extends Mock implements AppLocalizations {
  String get login_fail => "login_fail";
  String get private_key => "private_key";
  String get public_key => "public_key";
  String get login => "login";
  String get logout => "logout";
  String get save => "save";
  String get add_your_developer_credentials_to_login =>
      "add_your_developer_credentials_to_login";
  String get under_construction => "under_construction";
}

void main() {
  setUpAll(() {
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<LoginState>(FakeLoginState());
    registerFallbackValue<LoginEvent>(FakeLoginEvent());
  });

  group("AuthScreen", () {
    late AuthenticationBloc authenticationBloc;
    late LoginBloc loginBloc;
    late AppLocalizations localizations;

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      loginBloc = MockLoginBloc();
      localizations = MockAppLocalizations();
    });

    testWidgets('renders SplashScreen for Authentication UnInitialized',
        (tester) async {
      when(() => authenticationBloc.state).thenReturn(UnInitialized());

      await tester.pumpWidget(
        BlocProvider.value(
          value: authenticationBloc,
          child: MaterialApp(
            home: AuthScreen(),
          ),
        ),
      );
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('renders LoginScreen for Authentication UnAuthenticated',
        (tester) async {
      when(() => loginBloc.state).thenReturn(LoggedOut());
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
          child: MaterialApp(
            home: AuthScreen(),
          ),
        ),
      );
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('renders HomeScreen for Authentication Authenticated',
        (tester) async {
      when(() => loginBloc.state).thenReturn(LoggedIn());
      when(() => authenticationBloc.state).thenReturn(
        Authenticated(
          privateKey: "FAKE_PRIVATE_KEY",
          publicKey: "FAKE_PUBLIC_KEY",
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
          child: MaterialApp(
            home: AuthScreen(),
          ),
        ),
      );
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
