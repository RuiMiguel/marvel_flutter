import 'package:flutter/material.dart';
import 'package:marvel/router.dart';
import 'package:marvel/themes.dart';
import 'package:marvel/ui/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarvelApp extends StatelessWidget {
  const MarvelApp({Key key, this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      onGenerateRoute: generateRoute,
    );
  }
}
