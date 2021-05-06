import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/controllers/login_controller.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mockito/mockito.dart' as mockito;

class MockDatastoreManager extends Mock implements DatastoreManager {}

void main() {
  var datastore = MockDatastoreManager();
  late LoginController controller;

  void _initController({String privateKey = "", String publicKey = ""}) {
    when(() => datastore.getPrivateKey()).thenReturn(privateKey);
    when(() => datastore.getPublicKey()).thenReturn(publicKey);
    controller = LoginController(datastore);
  }

  group('LoginController', () {
    setUp(() {
      _initController();
    });

    group('hasCredentials', () {
      test(
          'Auth UNINITIALIZED when LoginController created without credentials',
          () {
        _initController();

        expect(controller.currentAuthStatus, AuthStatus.UNINITIALIZED);
      });

      test('Auth AUTHENTICATED when LoginController has credentials', () {
        _initController(privateKey: "FAKE_PRIVATE", publicKey: "FAKE_PUBLIC");
        expect(controller.currentAuthStatus, AuthStatus.AUTHENTICATED);
      });
    });

    group('getPrivateKey and getPublicKey', () {
      test('returns private key from datastore', () {
        var expected = "FAKE_PRIVATE";
        _initController(privateKey: expected);
        var privateKey = controller.getPrivateKey();

        expect(expected, privateKey);
      });

      test('returns public key from datastore', () {
        var expected = "FAKE_PUBLIC";
        _initController(publicKey: expected);
        var publicKey = controller.getPublicKey();

        expect(expected, publicKey);
      });
    });

    group('login', () {
      test('success with valid credentials', () async {
        var privateKey = "FAKE_PUBLIC";
        var publicKey = "FAKE_PRIVATE";

        _initController();
        when(() => datastore.setPrivateKey(any()))
            .thenAnswer((_) async => true);
        when(() => datastore.setPublicKey(any())).thenAnswer((_) async => true);

        bool loged = await controller.login(
          privateKey: privateKey,
          publicKey: publicKey,
        );

        expect(controller.currentAuthStatus, AuthStatus.AUTHENTICATED);
        expect(loged, equals(true));
      });

      test('failed with invalid credentials', () async {
        var privateKey = "";
        var publicKey = "";

        _initController();
        when(() => datastore.setPrivateKey(any()))
            .thenAnswer((_) async => false);
        when(() => datastore.setPublicKey(any()))
            .thenAnswer((_) async => false);

        bool loged = await controller.login(
          privateKey: privateKey,
          publicKey: publicKey,
        );

        expect(controller.currentAuthStatus, AuthStatus.UNAUTHENTICATED);
        expect(loged, isFalse);
      });
    });

    group('logout', () {
      test('success', () async {
        _initController();
        when(() => datastore.clearPrivateKey()).thenAnswer((_) async => true);
        when(() => datastore.clearPublicKey()).thenAnswer((_) async => true);

        await controller.logout();

        expect(controller.currentAuthStatus, AuthStatus.UNAUTHENTICATED);
      });
    });
  });
}
