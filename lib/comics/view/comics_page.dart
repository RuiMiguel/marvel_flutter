import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/under_construction/widget/under_construction_view.dart';

class ComicsPage extends StatelessWidget {
  const ComicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComicsView();
  }
}

class ComicsView extends StatelessWidget {
  const ComicsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(l10n.menu_comics),
              const UnderConstructionView(),
            ],
          ),
        ),
      ],
    );
  }
}
