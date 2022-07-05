import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class UnauthenticatedButtons extends StatelessWidget {
  const UnauthenticatedButtons({super.key, required this.onUpdate});

  final Function() onUpdate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: onUpdate,
      child: Text(
        l10n.login,
      ),
    );
  }
}
