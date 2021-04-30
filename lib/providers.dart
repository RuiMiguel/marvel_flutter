import 'package:flutter/material.dart';
import 'package:marvel/controllers/characters_controller.dart';
import 'package:marvel/controllers/comics_controller.dart';
import 'package:marvel/controllers/login_controller.dart';
import 'package:marvel/controllers/under_construction_controller.dart';
import 'package:marvel_data/marvel_data.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

MultiProvider buildMultiProvider({
  required SharedPreferences preferences,
  required Widget widget,
}) {
  return _buildDataProvider(
    preferences: preferences,
    widget: _buildControllerProvider(
      widget: widget,
    ),
  );
}

MultiProvider _buildDataProvider({
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
        create: (context) =>
            DatastoreManager(context.read<SharedPreferences>()),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginController(context.read<DatastoreManager>()),
      ),
      Provider(
        create: (context) => CharacterApiClient(
          _baseUrl,
          context.read<DatastoreManager>(),
          _logEnabled,
        ),
      ),
      Provider<CharactersRepository>(
        create: (context) =>
            CharactersDataRepository(context.read<CharacterApiClient>()),
      ),
      Provider(
        create: (context) => ComicsApiClient(
          _baseUrl,
          context.read<DatastoreManager>(),
          _logEnabled,
          _connectTimeout,
          _receiveTimeout,
        ),
      ),
      Provider<ComicsRepository>(
        create: (context) =>
            ComicsDataRepository(context.read<ComicsApiClient>()),
      ),
    ],
    child: widget,
  );
}

MultiProvider _buildControllerProvider({
  required Widget widget,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UnderConstructionController(),
      ),
      ChangeNotifierProvider(
        create: (context) => ComicsController(
          context.read<ComicsRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => CharactersController(
          context.read<CharactersRepository>(),
        ),
      )
    ],
    child: widget,
  );
}
