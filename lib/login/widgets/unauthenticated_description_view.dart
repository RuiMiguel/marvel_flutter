import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/webview/webview_page.dart';

class UnauthenticatedDescription extends StatelessWidget {
  const UnauthenticatedDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Linkify(
      text: l10n.add_your_developer_credentials_to_login,
      style: theme.textTheme.bodyText1,
      linkStyle: theme.textTheme.bodyText1!.copyWith(
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
