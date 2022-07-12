import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorage extends Mock implements Storage {}

Storage _buildMockStorage() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final storage = _MockStorage();
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  return storage;
}

T mockHydratedStorage<T>(T Function() body, {Storage? storage}) {
  return HydratedBlocOverrides.runZoned(
    body,
    storage: storage ?? _buildMockStorage(),
  );
}

FutureOr<void> mockHydratedStorageAsync<T>(
  FutureOr<T> Function() body, {
  Storage? storage,
}) async {
  await HydratedBlocOverrides.runZoned(
    () async => await body(),
    storage: storage ?? _buildMockStorage(),
  );
}
