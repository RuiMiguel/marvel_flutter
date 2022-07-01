import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorage extends Mock implements Storage {}

Storage createMockStorage() {
  final storage = _MockStorage();
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  return storage;
}

T mockHydratedStorage<T>(T Function() body, {Storage? storage}) {
  return HydratedBlocOverrides.runZoned(
    body,
    storage: storage ?? createMockStorage(),
  );
}
