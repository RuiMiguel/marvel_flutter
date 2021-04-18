import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              backgroundColor: red,
            ),
          ),
        ],
      ),
    );
  }
}
