import 'package:flutter/material.dart';
import 'package:marvel/controllers/characters_controller.dart';
import 'package:marvel/controllers/comics_controller.dart';
import 'package:marvel/controllers/login_controller.dart';
import 'package:marvel/controllers/under_construction_controller.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

MultiProvider buildTestMultiProvider({
  required SharedPreferences preferences,
  required Widget widget,
}) {
  return _buildTestDataProvider(
    preferences: preferences,
    widget: _buildTestControllerProvider(
      widget: widget,
    ),
  );
}

MultiProvider _buildTestDataProvider({
  required SharedPreferences preferences,
  required Widget widget,
}) {
  final _baseUrl = "gateway.marvel.com:443";
  final _logEnabled = true;
  final _connectTimeout = 30000;
  final _receiveTimeout = 30000;

  return MultiProvider(
    providers: [
      Provider(
        create: (context) => preferences,
      ),
      Provider(
        create: (context) async {
          var fakePrivateKey = "FAKE_PRIVATE_KEY";
          var fakePublicKey = "FAKE_PUBLIC_KEY";
          SharedPreferences.setMockInitialValues(
            {
              DatastoreManager.PRIVATE_KEY: fakePrivateKey,
              DatastoreManager.PUBLICK_KEY: fakePublicKey,
            },
          );
          return await SharedPreferences.getInstance();
        },
      ),
      Provider(
        create: (context) =>
            DatastoreManager(context.read<SharedPreferences>()),
      ),
    ],
    builder: (context, child) => widget,
  );
}

class MockLoginController extends Mock implements LoginController {
  @override
  Future<bool> login({required String privateKey, required String publicKey}) {
    return Future.value(true);
  }
}

class MockComicsController extends Mock implements ComicsController {
  @override
  Future<void> loadComicsResult() {
    return Future.value();
  }
}

class MockCharactersController extends Mock implements CharactersController {
  @override
  Future<void> loadCharactersResult() {
    return Future.value();
  }
}

MultiProvider _buildTestControllerProvider({
  required Widget widget,
}) {
  return MultiProvider(
    providers: [
      Provider(
        create: (context) => UnderConstructionController(),
      ),
      ChangeNotifierProvider(
        create: (context) => MockLoginController(),
      ),
      ChangeNotifierProvider(
        create: (context) => MockComicsController(),
      ),
      ChangeNotifierProvider(
        create: (context) => MockCharactersController(),
      ),
    ],
    child: widget,
  );
}
