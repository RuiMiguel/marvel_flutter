import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class AuthenticatedButtons extends StatelessWidget {
  const AuthenticatedButtons({
    super.key,
    required this.onLogin,
    required this.onLogout,
    this.enabled = true,
  });

  final Function() onLogin;
  final Function() onLogout;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: enabled ? onLogin : null,
          child: Text(
            l10n.save,
          ),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: enabled ? onLogout : null,
          child: Text(
            l10n.logout,
          ),
        ),
      ],
    );
  }
}
