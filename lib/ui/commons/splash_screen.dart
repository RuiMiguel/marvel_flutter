import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(color: red);

    return Container(
      color: red,
      child: Center(
        child: Image.asset('assets/images/placeholder.png'),
      ),
    );
  }
}
