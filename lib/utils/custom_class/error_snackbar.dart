import 'package:flutter/material.dart';

class ErrorSnackBar extends StatelessWidget {
  final String message;

  const ErrorSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 16.0, color: Colors.white)),
      backgroundColor: Colors.red,
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
    );
  }
}
