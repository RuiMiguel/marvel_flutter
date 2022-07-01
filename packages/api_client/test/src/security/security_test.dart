import 'package:api_client/src/security/security.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage/secure_storage.dart';

class _MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  const privateKey = 'privateKey';
  const publicKey = 'publicKey';

  late SecureStorage storage;
  late Security security;

  setUpAll(() {
    storage = _MockSecureStorage();
    when(() => storage.privateKey()).thenAnswer((_) async => privateKey);
    when(() => storage.publicKey()).thenAnswer((_) async => publicKey);
    security = Security(storage: storage);
  });

  group('Security', () {
    test('returns a Map with timestamp and hash', () async {
      final hashTimestamp = await security.hashTimestamp();

      expect(hashTimestamp['timestamp'], isNotNull);
      expect(hashTimestamp['hash'], isNotNull);
    });

    test('generate md5 from an input', () {
      const input = 'Lorem ipsum dolor sit amet';
      const expected = 'fea80f2db003d4ebc4536023814aa885';

      expect(security.generateMd5(input), equals(expected));
    });
  });
}
