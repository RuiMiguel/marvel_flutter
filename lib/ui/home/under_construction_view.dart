import 'package:flutter/material.dart';
import 'package:marvel/core/controllers/under_construction_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnderConstructionView extends StatelessWidget {
  const UnderConstructionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.read<UnderConstructionController>();

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).shadowColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        AppLocalizations.of(context)!.under_construction,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Image.asset(
                      "assets/images/Deadpool-wait.jpeg",
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        controller.getSentence(context),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
