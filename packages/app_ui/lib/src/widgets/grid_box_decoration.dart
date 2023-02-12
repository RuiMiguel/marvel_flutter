import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class GridBoxDecoratedCell extends StatelessWidget {
  const GridBoxDecoratedCell({
    required this.index,
    required this.gridViewCrossAxisCount,
    required this.child,
    this.color,
    super.key,
  });

  final int index;
  final int gridViewCrossAxisCount;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderColor = color ?? AppColors.red;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: index % gridViewCrossAxisCount != 0
                ? borderColor
                : Colors.transparent,
            width: 1.5,
          ),
          top: BorderSide(
            color: index > gridViewCrossAxisCount
                ? borderColor
                : Colors.transparent,
            width: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 1.5,
          left: 1.5,
        ),
        child: child,
      ),
    );
  }
}
