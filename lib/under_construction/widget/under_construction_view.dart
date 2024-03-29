import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';

class UnderConstructionView extends StatelessWidget {
  const UnderConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                l10n.under_construction,
                style: theme.textTheme.displayLarge,
              ),
            ),
            MarvelIcons.wait.image(fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                key: const Key('UnderConstructionSentence'),
                _getSentence(l10n),
                style: theme.textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getSentence(AppLocalizations l10n) {
    final _sentences = <String>[
      l10n.deadpool_message1,
      l10n.deadpool_message2,
      l10n.deadpool_message3,
      l10n.deadpool_message4,
      l10n.deadpool_message5,
      l10n.deadpool_message6,
      l10n.deadpool_message7,
      l10n.deadpool_message8,
      l10n.deadpool_message9,
      l10n.deadpool_message10,
      l10n.deadpool_message11,
      l10n.deadpool_message12,
      l10n.deadpool_message13,
      l10n.deadpool_message14,
      l10n.deadpool_message15,
      l10n.deadpool_message16,
      l10n.deadpool_message17,
      l10n.deadpool_message18,
      l10n.deadpool_message19,
      l10n.deadpool_message20,
      l10n.deadpool_message21,
      l10n.deadpool_message22,
      l10n.deadpool_message23,
      l10n.deadpool_message24,
      l10n.deadpool_message25,
      l10n.deadpool_message26,
      l10n.deadpool_message27,
      l10n.deadpool_message28,
      l10n.deadpool_message29,
      l10n.deadpool_message30,
    ];

    final index = Random().nextInt(_sentences.length);
    return _sentences[index];
  }
}
