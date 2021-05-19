import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticatedDescription extends StatelessWidget {
  const AuthenticatedDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.your_current_credentials,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
