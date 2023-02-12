import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({
    required this.legal,
    required this.counter,
    super.key,
  });

  final String legal;
  final String counter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 35,
      color: theme.shadowColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Container(
              height: 1,
              color: AppColors.red,
            ),
          ),
          Center(
            child: Text(
              legal,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Positioned(
            right: 5,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                counter,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
