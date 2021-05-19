import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnauthenticatedButtons extends StatelessWidget {
  final Function(BuildContext) onUpdate;

  const UnauthenticatedButtons({Key? key, required this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: () {
        onUpdate(context);
      },
      child: Text(
        AppLocalizations.of(context)!.login,
      ),
    );
  }
}
