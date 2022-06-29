import 'package:api_client/src/security/security.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const privateKey = 'privateKey';
  const publicKey = 'publicKey';
  late Security security;

  setUpAll(() {
    security = Security(
      privateKey: privateKey,
      publicKey: publicKey,
    );
  });

  group('Security', () {
    test('returns a Map with timestamp and hash', () {
      final hashTimestamp = security.hashTimestamp();

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
