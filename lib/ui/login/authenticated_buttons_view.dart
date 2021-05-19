import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticatedButtons extends StatelessWidget {
  final Function(BuildContext) onLogin;
  final Function(BuildContext) onLogout;

  const AuthenticatedButtons(
      {Key? key, required this.onLogin, required this.onLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () {
            onLogin(context);
          },
          child: Text(
            AppLocalizations.of(context)!.save,
          ),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () {
            onLogout(context);
          },
          child: Text(
            AppLocalizations.of(context)!.logout,
          ),
        ),
      ],
    );
  }
}
