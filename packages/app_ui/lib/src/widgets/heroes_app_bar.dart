import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class HeroesAppBar extends StatelessWidget with PreferredSizeWidget {
  const HeroesAppBar({
    required this.withActions,
    required this.onLoginPressed,
    super.key,
  });

  final bool withActions;
  final VoidCallback onLoginPressed;

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
          color: AppColors.red,
        ),
      ),
      centerTitle: true,
      title: Assets.images.placeholder.image(
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
        LoginActionButton(onLoginPressed: onLoginPressed),
      ];
    }
    return list;
  }
}

@visibleForTesting
class LoginActionButton extends StatelessWidget {
  const LoginActionButton({
    required this.onLoginPressed,
    super.key,
  });

  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onLoginPressed,
      icon: const Icon(Icons.verified_user),
    );
  }
}
