// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/characters/characters.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/under_construction/widget/under_construction_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockCharactersBloc extends Mock implements CharactersBloc {}

void main() {
  late CharactersBloc charactersBloc;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    charactersBloc = _MockCharactersBloc();
  });

  group('CharactersPage', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets(
      'renders correctly',
      (tester) async {
        await tester.pumpApp(
          CharactersPage(),
        );

        expect(find.byType(CharactersView), findsOneWidget);
      },
    );

    group('CharactersView', () {
      testWidgets(
        'renders correctly',
        (tester) async {
          final l10n = await AppLocalizations.delegate.load(const Locale('en'));

          whenListen(
            charactersBloc,
            Stream.value(CharactersState.initial()),
            initialState: CharactersState.initial(),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: charactersBloc,
              child: CharactersView(),
            ),
          );
        },
      );
    });
  });
}
