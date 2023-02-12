import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void showErrorMessage(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.red,
          content: Text(message),
        ),
      );

  void showSuccessMessage(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.green,
          content: Text(message),
        ),
      );
}
