import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/characters_controller.dart';
import 'package:marvel/core/controllers/comics_controller.dart';
import 'package:marvel/core/controllers/login_controller.dart';
import 'package:marvel/core/controllers/under_construction_controller.dart';
import 'package:marvel/data/datastore_manager.dart';
import 'package:marvel/data/repository/characters_repository.dart';
import 'package:marvel/data/repository/comics_repository.dart';
import 'package:marvel/data/service/character_api_client.dart';
import 'package:marvel/data/service/comic_api_client.dart';
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
      Provider(
        create: (context) =>
            CharactersRepository(context.read<CharacterApiClient>()),
      ),
      Provider(
        create: (context) => ComicsApiClient(
          _baseUrl,
          context.read<DatastoreManager>(),
          _logEnabled,
        ),
      ),
      Provider(
        create: (context) => ComicsRepository(context.read<ComicsApiClient>()),
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
