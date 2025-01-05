import 'package:flutter/material.dart';

final successColor = const Color(0xFF9B6763); // Primary color
final errorColor = const Color(0xFFB8978C); // Secondary color

showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
