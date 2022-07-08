import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class UnauthenticatedButtons extends StatelessWidget {
  const UnauthenticatedButtons({
    super.key,
    required this.onUpdate,
    this.enabled = true,
  });

  final Function() onUpdate;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: enabled ? onUpdate : null,
      child: Text(
        l10n.login,
      ),
    );
  }
}
