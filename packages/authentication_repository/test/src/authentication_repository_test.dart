// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:test/test.dart';

class _MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  const privateKey = 'privateKey';
  const publicKey = 'publicKey';

  late SecureStorage storage;
  late AuthenticationRepository authenticationRepository;

  setUpAll(() {
    storage = _MockSecureStorage();
    when(() => storage.privateKey()).thenAnswer((_) async => privateKey);
    when(() => storage.publicKey()).thenAnswer((_) async => publicKey);
  });

  group('AuthenticationRepository', () {
    test('can be instantiated', () {
      expect(AuthenticationRepository(storage), isNotNull);
    });
  });
}
