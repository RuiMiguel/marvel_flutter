import 'package:flutter/material.dart';
import 'package:marvel/styles/colors.dart';

class LoginTextInput extends StatefulWidget {
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
  State<LoginTextInput> createState() => _LoginTextInputState();
}

class _LoginTextInputState extends State<LoginTextInput> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController
      ..addListener(
        () => widget.onChanged(_textController.text),
      )
      ..text = widget.text;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      autocorrect: false,
      cursorColor: Theme.of(context).textTheme.bodyText1!.color,
      style: Theme.of(context).textTheme.bodyText2,
      enabled: widget.enabled,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.labelText,
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
    );
  }
}
