import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/ui/login/login_screen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  const CustomAppBar({Key? key, this.userActions = false}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final bool userActions;

  @override
  Widget build(BuildContext context) {
    if (userActions) {
      return _authenticatedAppBar(context);
    } else {
      return _unauthenticatedAppBar(context);
    }
  }

  AppBar _authenticatedAppBar(BuildContext context) {
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
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          },
          icon: const Icon(Icons.verified_user),
        ),
      ],
    );
  }

  AppBar _unauthenticatedAppBar(BuildContext context) {
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
    );
  }
}
