import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/cubit/underconstruction_cubit.dart';
import 'package:marvel/ui/home/under_construction_view.dart';
import 'package:marvel/ui/series/series_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockAppLocalizations extends Mock implements AppLocalizations {}

class MockBuildContext extends Mock implements BuildContext {}

class MockUnderConstructionCubit extends MockCubit<String>
    implements UnderconstructionCubit {}

void main() {
  group("SeriesScreen", () {
    late AppLocalizations localizations;
    late BuildContext buildContext;
    late UnderconstructionCubit underconstructionCubit;

    setUp(() {
      localizations = MockAppLocalizations();
      buildContext = MockBuildContext();
      underconstructionCubit = MockUnderConstructionCubit();
    });

    testWidgets('series screen ...', (tester) async {
      when(() => AppLocalizations.of(buildContext)).thenReturn(localizations);
      await tester.pumpWidget(
        MaterialApp(
          home: SeriesScreen(),
        ),
      );
      expect(find.byType(UnderConstructionView), findsOneWidget);
    });
  });
}
