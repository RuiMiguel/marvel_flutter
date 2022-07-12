import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/webview/webview_page.dart';

class UnauthenticatedDescription extends StatelessWidget {
  const UnauthenticatedDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Linkify(
      text: l10n.add_your_developer_credentials_to_login,
      style: Theme.of(context).textTheme.bodyText1,
      linkStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 24,
            color: red,
          ),
      onOpen: (link) {
        Navigator.of(context).push<void>(
          WebViewPage.page(link.url),
        );
      },
    );
  }
}
