import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class AuthenticatedButtons extends StatelessWidget {
  const AuthenticatedButtons({
    super.key,
    required this.onLogin,
    required this.onLogout,
  });

  final Function() onLogin;
  final Function() onLogout;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: onLogin,
          child: Text(
            l10n.save,
          ),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: onLogout,
          child: Text(
            l10n.logout,
          ),
        ),
      ],
    );
  }
}
