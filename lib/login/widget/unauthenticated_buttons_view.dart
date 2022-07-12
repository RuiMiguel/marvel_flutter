import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class UnauthenticatedButtons extends StatelessWidget {
  const UnauthenticatedButtons({
    super.key,
    required this.onLogin,
    this.enabled = true,
  });

  final Function() onLogin;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: enabled ? onLogin : null,
      child: Text(
        l10n.login,
      ),
    );
  }
}
