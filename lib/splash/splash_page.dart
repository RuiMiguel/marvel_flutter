import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/styles/themes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme(color: red);

    return ColoredBox(
      color: red,
      child: Center(
        child: Image.asset('assets/images/placeholder.png'),
      ),
    );
  }
}
