import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/core/base/error/failure.dart';
import 'package:marvel/styles/colors.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, this.failure}) : super(key: key);

  final Failure? failure;

  contentBox(context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/close.png',
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {
              print("CLOOOSING");
            },
          ),
          Center(
            child: Text(
              AppLocalizations.of(context)!.generic_error,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.retry,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 10,
      backgroundColor: grey,
      child: contentBox(context),
    );
  }
}
