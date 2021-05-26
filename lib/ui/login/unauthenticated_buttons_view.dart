import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class UnauthenticatedButtons extends StatelessWidget {
  final Function(BuildContext) onUpdate;

  const UnauthenticatedButtons({Key? key, required this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: () {
        onUpdate(context);
      },
      child: Text(
        context.l10n.login,
      ),
    );
  }
}
