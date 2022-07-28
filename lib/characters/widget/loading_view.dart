import 'package:flutter/material.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key, this.height});

  final double? height;

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: RotationTransition(
          turns: _animationController,
          child: Image.asset(
            'assets/images/mjolnir.png',
            fit: BoxFit.fill,
            height: widget.height ?? 300,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
