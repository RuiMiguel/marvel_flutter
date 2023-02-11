import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class AuthenticatedDescription extends StatelessWidget {
  const AuthenticatedDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Text(
      l10n.your_current_credentials,
      style: theme.textTheme.bodyText1,
    );
  }
}
