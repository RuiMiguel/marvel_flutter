import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      bottom: PreferredSize(
        child: Container(
          height: 2,
          color: Theme.of(context).accentColor,
        ),
        preferredSize: Size.fromHeight(2),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.contain,
            height: 120,
          ),
        ],
      ),
    );
  }
}
