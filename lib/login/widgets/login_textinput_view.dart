import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class LoginTextInput extends StatefulWidget {
  const LoginTextInput({
    required this.labelText,
    required this.onChanged,
    this.hint = '*****',
    this.text = '',
    this.enabled = true,
    super.key,
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
    final theme = Theme.of(context);

    return TextFormField(
      controller: _textController,
      autocorrect: false,
      cursorColor: theme.textTheme.bodyLarge!.color,
      style: theme.textTheme.bodyMedium,
      enabled: widget.enabled,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.labelText,
        hintStyle: theme.textTheme.titleMedium,
        labelStyle: theme.textTheme.titleMedium,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
        ),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
