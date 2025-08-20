import 'package:flutter/material.dart';

class ThemeHelper {
  static void showMessage(BuildContext context, String message,
      {Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    showMessage(context, message, backgroundColor: Colors.red);
  }

  static void showSuccess(BuildContext context, String message) {
    showMessage(context, message, backgroundColor: Colors.green);
  }
}
