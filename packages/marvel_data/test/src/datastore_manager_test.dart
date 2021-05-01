import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late DatastoreManager datastoreManager;

  void initSharedPreferences(SharedPreferences sharedPreferences) {
    datastoreManager = DatastoreManager(sharedPreferences);
  }

  group('DatastoreManager', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      initSharedPreferences(await SharedPreferences.getInstance());
    });

    group('PrivateKey', () {
      group('getPrivateKey', () {
        test('returns private key when there is a value in preferences',
            () async {
          var expected = "FAKE_PRIVATE_KEY";
          SharedPreferences.setMockInitialValues(
            {DatastoreManager.PRIVATE_KEY: expected},
          );
          initSharedPreferences(await SharedPreferences.getInstance());

          var result = datastoreManager.getPrivateKey();
          expect(result, equals(expected));
        });

        test(
            'returns empty value when there is not a value for private key in preferences',
            () {
          var result = datastoreManager.getPrivateKey();
          expect(result, isEmpty);
        });
      });

      group('setPrivateKey', () {
        test('successfully saves private key in preferences', () async {
          var privateKey = "FAKE_PRIVATE_KEY";

          var result = await datastoreManager.setPrivateKey(privateKey);
          expect(result, isTrue);

          var confirm = datastoreManager.getPrivateKey();
          expect(confirm, equals(privateKey));
        });

        test(
            'returns false when tries to save empty private key in preferences',
            () async {
          var privateKey = "";

          var result = await datastoreManager.setPrivateKey(privateKey);
          expect(result, isFalse);
        });
      });

      group('clearPrivateKey', () {
        test('successfully clears private key in preferences', () async {
          var privateKey = "FAKE_PRIVATE_KEY";
          SharedPreferences.setMockInitialValues(
            {DatastoreManager.PRIVATE_KEY: privateKey},
          );
          initSharedPreferences(await SharedPreferences.getInstance());

          var result = await datastoreManager.clearPrivateKey();
          expect(result, isTrue);

          var confirm = datastoreManager.getPrivateKey();
          expect(confirm, isEmpty);
        });
      });
    });

    group('PublicKey', () {
      group('getPublicKey', () {
        test('returns public key when there is a value in preferences',
            () async {
          var expected = "FAKE_PUBLIC_KEY";
          SharedPreferences.setMockInitialValues(
            {DatastoreManager.PUBLICK_KEY: expected},
          );
          initSharedPreferences(await SharedPreferences.getInstance());

          var result = datastoreManager.getPublicKey();
          expect(result, equals(expected));
        });

        test(
            'returns empty value when there is not a value for public key in preferences',
            () {
          var result = datastoreManager.getPublicKey();
          expect(result, isEmpty);
        });
      });

      group('setPublicKey', () {
        test('successfully saves public key in preferences', () async {
          var publicKey = "FAKE_PUBLIC_KEY";

          var result = await datastoreManager.setPublicKey(publicKey);
          expect(result, isTrue);

          var confirm = datastoreManager.getPublicKey();
          expect(confirm, equals(publicKey));
        });

        test('returns false when tries to save empty public key in preferences',
            () async {
          var publicKey = "";

          var result = await datastoreManager.setPublicKey(publicKey);
          expect(result, isFalse);
        });
      });

      group('clearPublicKey', () {
        test('successfully clears public key in preferences', () async {
          var publicKey = "FAKE_PUBLICK_KEY";
          SharedPreferences.setMockInitialValues(
            {DatastoreManager.PUBLICK_KEY: publicKey},
          );
          initSharedPreferences(await SharedPreferences.getInstance());

          var result = await datastoreManager.clearPublicKey();
          expect(result, isTrue);

          var confirm = datastoreManager.getPublicKey();
          expect(confirm, isEmpty);
        });
      });
    });
  });
}
