import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/characters_controller.dart';
import 'package:marvel/core/controllers/comics_controller.dart';
import 'package:marvel/core/controllers/under_construction_controller.dart';
import 'package:marvel/data/repository/characters_repository.dart';
import 'package:marvel/data/repository/comics_repository.dart';
import 'package:marvel/data/service/character_api_client.dart';
import 'package:marvel/data/service/comic_api_client.dart';
import 'package:provider/provider.dart';

MultiProvider buildMultiProvider({
  required BuildContext context,
  required Widget widget,
}) {
  return _buildDataProvider(
    context: context,
    widget: _buildControllerProvider(
      context: context,
      widget: widget,
    ),
  );
}

MultiProvider _buildDataProvider({
  required BuildContext context,
  required Widget widget,
}) {
  return MultiProvider(
    providers: [
      Provider(
        create: (context) => CharacterApiClient(),
      ),
      Provider(
        create: (context) =>
            CharactersRepository(context.read<CharacterApiClient>()),
      ),
      Provider(
        create: (context) => ComicsApiClient(),
      ),
      Provider(
        create: (context) => ComicsRepository(context.read<ComicsApiClient>()),
      ),
    ],
    child: widget,
  );
}

MultiProvider _buildControllerProvider({
  required BuildContext context,
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
