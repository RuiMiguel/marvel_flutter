import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';

class LoginTextInput extends StatelessWidget {
  const LoginTextInput({
    Key? key,
    this.hint = '*****',
    required this.labelText,
    required this.text,
    required this.submit,
  }) : super(key: key);

  final String hint;
  final String labelText;
  final String text;
  final Function(String) submit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      autocorrect: false,
      cursorColor: Theme.of(context).textTheme.bodyText1!.color,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        hintText: hint,
        labelText: labelText,
        hintStyle: Theme.of(context).textTheme.subtitle1,
        labelStyle: Theme.of(context).textTheme.subtitle1,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: red),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: red),
        ),
        border: const UnderlineInputBorder(),
      ),
      onFieldSubmitted: (value) async => submit(value),
    );
  }
}
