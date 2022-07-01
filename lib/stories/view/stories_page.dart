import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/under_construction/widget/under_construction_view.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StoriesView();
  }
}

class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(l10n.menu_stories),
              const UnderConstructionView(),
            ],
          ),
        ),
      ],
    );
  }
}
