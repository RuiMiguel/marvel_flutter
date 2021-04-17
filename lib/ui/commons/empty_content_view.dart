import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyContentView extends StatelessWidget {
  const EmptyContentView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.no_content,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
