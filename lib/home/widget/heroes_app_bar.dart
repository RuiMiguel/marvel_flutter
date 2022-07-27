import 'package:flutter/material.dart';
import 'package:marvel/login/login.dart';
import 'package:marvel/styles/colors.dart';

class HeroesAppBar extends StatelessWidget with PreferredSizeWidget {
  const HeroesAppBar({super.key, required this.withActions});

  final bool withActions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 2,
          color: red,
        ),
      ),
      centerTitle: true,
      title: Image.asset(
        'assets/images/placeholder.png',
        fit: BoxFit.contain,
        height: 120,
      ),
      actions: _actions(context),
    );
  }

  List<Widget> _actions(BuildContext context) {
    var list = <Widget>[];
    if (withActions) {
      list = [
        IconButton(
          key: const Key('login_icon_button_key'),
          onPressed: () {
            Navigator.of(context).push<void>(
              LoginPage.page(),
            );
          },
          icon: const Icon(Icons.verified_user),
        ),
      ];
    }
    return list;
  }
}
