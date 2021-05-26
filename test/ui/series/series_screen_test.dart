import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/cubit/underconstruction_cubit.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/ui/home/under_construction_view.dart';
import 'package:marvel/ui/series/series_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockUnderConstructionCubit extends MockCubit<String>
    implements UnderConstructionCubit {}

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
  group("SeriesScreen", () {
    late AppLocalizations localizations;
    late BuildContext buildContext;
    late UnderConstructionCubit underconstructionCubit;

    setUp(() {
      localizations = MockAppLocalizations();
      buildContext = MockBuildContext();
      underconstructionCubit = MockUnderConstructionCubit();
    });

    testWidgets('series screen ...', (tester) async {
      when(() => AppLocalizations.of(buildContext)).thenReturn(localizations);
      //when(() => underconstructionCubit.state).thenReturn(UnInitialized());

      await tester.pumpWidget(
        BlocProvider.value(
          value: underconstructionCubit,
          child: MaterialApp(
            home: SeriesScreen(),
          ),
        ),
      );
      expect(find.byType(UnderConstructionView), findsOneWidget);
    });
  });
}
