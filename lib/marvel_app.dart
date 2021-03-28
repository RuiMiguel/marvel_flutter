import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/characters_controller.dart';
import 'package:marvel/core/controllers/comics_controller.dart';
import 'package:marvel/data/repository/characters_repository.dart';
import 'package:marvel/data/repository/comics_repository.dart';
import 'package:marvel/data/service/character_api_client.dart';
import 'package:marvel/data/service/comic_api_client.dart';
import 'package:marvel/router.dart';
import 'package:marvel/themes.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarvelApp extends StatelessWidget {
  const MarvelApp({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ComicsController(
            ComicsRepository(
              ComicsApiClient(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CharactersController(
            CharactersRepository(
              CharacterApiClient(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(),
        darkTheme: darkThemeData(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
