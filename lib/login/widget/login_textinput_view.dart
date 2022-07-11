import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';

class LoginTextInput extends StatelessWidget {
  const LoginTextInput({
    super.key,
    this.hint = '*****',
    required this.labelText,
    this.text = '',
    required this.onChanged,
    this.enabled = true,
  });

  final String hint;
  final String labelText;
  final String text;
  final bool enabled;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      autocorrect: false,
      cursorColor: Theme.of(context).textTheme.bodyText1!.color,
      style: Theme.of(context).textTheme.bodyText2,
      enabled: enabled,
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
      onChanged: (value) async => onChanged(value),
    );
  }
}
