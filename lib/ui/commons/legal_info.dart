import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/themes.dart';

class LegalInfo extends StatelessWidget {
  final String legal;
  final int count;
  final int total;

  const LegalInfo({Key? key, this.legal = "", this.count = 0, this.total = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      color: grey,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Container(
              height: 1,
              color: Theme.of(context).accentColor,
            ),
          ),
          Center(
            child: Container(
              child: Text(
                legal,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                "$count ${AppLocalizations.of(context)!.of_message} $total",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
