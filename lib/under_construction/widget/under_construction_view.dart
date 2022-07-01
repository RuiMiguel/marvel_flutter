import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/under_construction/cubit/under_construction_cubit.dart';

class UnderConstructionView extends StatelessWidget {
  const UnderConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UnderConstructionCubit(),
      child: const UnderConstructionContent(),
    );
  }
}

class UnderConstructionContent extends StatelessWidget {
  const UnderConstructionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    context.read<UnderConstructionCubit>().getSentence(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                l10n.under_construction,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Image.asset(
              'assets/images/wait.jpeg',
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: BlocBuilder<UnderConstructionCubit, String>(
                builder: (context, state) {
                  return Text(
                    state,
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
