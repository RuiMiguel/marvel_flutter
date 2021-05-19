import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';

class LoginTextInput extends StatelessWidget {
  final String hint;
  final String labelText;
  final String text;
  final Function(String) submit;

  const LoginTextInput({
    Key? key,
    this.hint = "*****",
    required this.labelText,
    required this.text,
    required this.submit,
  }) : super(key: key);

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
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: red),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: red),
        ),
        border: UnderlineInputBorder(),
      ),
      onFieldSubmitted: (value) => submit(value),
    );
  }
}
