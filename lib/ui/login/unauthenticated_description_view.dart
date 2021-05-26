import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:marvel/l10n/l10n.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/ui/commons/webview_screen.dart';

class UnauthenticatedDescription extends StatelessWidget {
  const UnauthenticatedDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Linkify(
      text: context.l10n.add_your_developer_credentials_to_login,
      style: Theme.of(context).textTheme.bodyText1,
      linkStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 24,
            color: red,
          ),
      onOpen: (link) => Navigator.of(context).pushNamed(
        WebViewScreen.routeName,
        arguments: link.url,
      ),
    );
  }
}
