import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/cubit/underconstruction_cubit.dart';
import 'package:marvel/ui/home/under_construction_view.dart';
import 'package:marvel/ui/series/series_screen.dart';

class MockUnderConstructionCubit extends MockCubit<String>
    implements UnderConstructionCubit {}

void main() {
  group('SeriesScreen', () {
    late UnderConstructionCubit underconstructionCubit;

    setUp(() {
      underconstructionCubit = MockUnderConstructionCubit();
    });

    testWidgets('series screen ...', (tester) async {
      //when(() => underconstructionCubit.state).thenReturn(UnInitialized());

      await tester.pumpWidget(
        BlocProvider.value(
          value: underconstructionCubit,
          child: const MaterialApp(
            home: SeriesScreen(),
          ),
        ),
      );
      expect(find.byType(UnderConstructionView), findsOneWidget);
    });
  });
}
