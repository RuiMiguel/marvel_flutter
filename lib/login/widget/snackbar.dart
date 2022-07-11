import 'package:flutter/material.dart';
import 'package:marvel/styles/styles.dart';

extension BuildContextX on BuildContext {
  void showErrorMessage(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: red,
          content: Text(message),
        ),
      );

  void showSuccessMessage(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: green,
          content: Text(message),
        ),
      );
}
