import 'package:flutter/material.dart';
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
      // TODO(ruimiguel): show actions if user authenticated, if not then empty.
      actions: _actions(),
    );
  }

  List<Widget> _actions() {
    var list = <Widget>[];
    if (withActions) {
      list = [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
          onPressed: () {
            // TODO(ruimiguel): navigate to Login.
          },
          icon: const Icon(Icons.verified_user),
        ),
      ];
    }
    return list;
  }
}
