import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticatedDescription extends StatelessWidget {
  const AuthenticatedDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Text(
      l10n.your_current_credentials,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
