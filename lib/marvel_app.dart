import 'package:flutter/material.dart';
import 'package:marvel/router.dart';
import 'package:marvel/ui/home_screen.dart';

class MarvelApp extends StatelessWidget {
  const MarvelApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.red,
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
