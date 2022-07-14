import 'dart:math' as math;
import 'package:flutter/material.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween<double>(
      begin: 2 * math.pi,
      end: 0,
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Transform.rotate(
          angle: animation.value,
          child: Image.asset(
            'assets/images/mjolnir.png',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
