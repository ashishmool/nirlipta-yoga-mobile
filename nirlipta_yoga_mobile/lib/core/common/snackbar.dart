import 'package:flutter/material.dart';

final successColor = const Color(0xFF9B6763); // Primary color
final errorColor = const Color(0xFFB8978C); // Secondary color

// show SnackBar
showMySnackbar(BuildContext context, String message, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: color ?? successColor,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
