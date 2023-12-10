import 'package:flutter/material.dart';

class CustomSnackBar {
  void getSnackBar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.deepPurple,
      content: Text(message),
    ));
  }
}
