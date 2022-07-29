// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/app/bloc/authentication_bloc.dart';
import 'package:marvel/common/widget/heroes_app_bar.dart';
import 'package:marvel/login/view/login_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  late AuthenticationRepository authenticationRepository;
  late AuthenticationBloc authenticationBloc;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    authenticationRepository = _MockAuthenticationRepository();
    authenticationBloc = _MockAuthenticationBloc();
  });

  group('HeroesAppBar', () {
    testWidgets(
      'renders correctly without actions',
      (tester) async {
        await tester.pumpApp(
          Scaffold(
            appBar: HeroesAppBar(
              withActions: false,
            ),
            body: Container(),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.actions, isEmpty);
        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets(
      'renders correctly with actions',
      (tester) async {
        await tester.pumpApp(
          Scaffold(
            appBar: HeroesAppBar(
              withActions: true,
            ),
            body: Container(),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.actions?.length, 1);
        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets(
      'navigates to LoginPage when action is pressed',
      (tester) async {
        whenListen(
          authenticationBloc,
          Stream.value(AuthenticationState.unauthenticated()),
          initialState: AuthenticationState.unauthenticated(),
        );

        await tester.pumpApp(
          Scaffold(
            appBar: HeroesAppBar(
              withActions: true,
            ),
            body: Container(),
          ),
          authenticationRepository: authenticationRepository,
          authenticationBloc: authenticationBloc,
        );

        (tester.widget<AppBar>(find.byType(AppBar)).actions?.first
                as IconButton?)
            ?.onPressed!();

        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
      },
    );
  });
}
