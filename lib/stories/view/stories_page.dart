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

@visibleForTesting
class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
