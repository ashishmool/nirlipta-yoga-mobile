import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/app/app.dart';
import 'package:nirlipta_yoga_mobile/app/di/di.dart';

// Initialize once in the very beginning
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // Initialize dependencies
  runApp(
    App(),
  );
}
