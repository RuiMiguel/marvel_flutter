import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/home/home.dart';

import '../../helpers/mock_hydrated_storage.dart';

void main() {
  group('SectionCubit', () {
    test('initial state is 0', () {
      mockHydratedStorage(() {
        expect(SectionCubit().state, 0);
      });
    });

    blocTest<SectionCubit, int>(
      'description',
      build: () => mockHydratedStorage(SectionCubit.new),
      act: (bloc) => bloc.selectItem(1),
      expect: () => [1],
    );

    test('toJson and fromJson are inverse', () {
      mockHydratedStorage(() {
        for (final index in [1, 2, 3, 4]) {
          final cubit = SectionCubit();
          expect(cubit.fromJson(cubit.toJson(index)), index);
        }
      });
    });
  });
}
