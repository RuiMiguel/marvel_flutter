import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class AuthenticatedButtons extends StatelessWidget {
  const AuthenticatedButtons({
    super.key,
    required this.onSave,
    required this.onLogout,
    this.enabled = true,
  });

  final Function() onSave;
  final Function() onLogout;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          key: const Key('save_button'),
          style: theme.elevatedButtonTheme.style,
          onPressed: enabled ? onSave : null,
          child: Text(
            l10n.save,
          ),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          key: const Key('logout_button'),
          onPressed: enabled ? onLogout : null,
          child: Text(
            l10n.logout,
          ),
        ),
      ],
    );
  }
}
