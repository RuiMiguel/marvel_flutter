import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/login_controller.dart';
import 'package:marvel/providers.dart';
import 'package:marvel/router.dart';
import 'package:marvel/styles/themes.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MarvelApp extends StatelessWidget {
  const MarvelApp({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return buildMultiProvider(
      preferences: prefs,
      widget: MarvelAppView(),
    );
  }
}

class MarvelAppView extends StatelessWidget {
  const MarvelAppView({Key? key}) : super(key: key);

  Widget getStartScreen(BuildContext context) {
    var controller = context.read<LoginController>();

    if (controller.hasCredentials()) {
      return HomeScreen();
    } else {
      return HomeScreen(); //KeysScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: getStartScreen(context),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: lightThemeData(),
        darkTheme: darkThemeData(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
