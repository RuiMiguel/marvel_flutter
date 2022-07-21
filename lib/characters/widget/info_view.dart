import 'package:flutter/material.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/styles/styles.dart';

class InfoView extends StatelessWidget {
  const InfoView({
    super.key,
    required this.legal,
    required this.count,
    required this.total,
  });

  final String legal;
  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      height: 35,
      color: Theme.of(context).shadowColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Container(
              height: 1,
              color: red,
            ),
          ),
          Center(
            child: Text(
              legal,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Positioned(
            right: 5,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                '$count ${l10n.of_message} $total',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
