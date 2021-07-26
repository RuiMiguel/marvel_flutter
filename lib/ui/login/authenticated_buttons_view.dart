import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel/l10n/l10n.dart';

class AuthenticatedButtons extends StatelessWidget {
  const AuthenticatedButtons(
      {Key? key, required this.onLogin, required this.onLogout})
      : super(key: key);

  final Function(BuildContext) onLogin;
  final Function(BuildContext) onLogout;

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
            context.l10n.save,
          ),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            onLogout(context);
          },
          child: Text(
            context.l10n.logout,
          ),
        ),
      ],
    );
  }
}
