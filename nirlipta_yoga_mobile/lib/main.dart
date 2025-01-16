import 'package:flutter/cupertino.dart';
import 'package:nirlipta_yoga_mobile/app/app.dart';
import 'package:nirlipta_yoga_mobile/app/di/di.dart';

import 'core/network/hive_service.dart';

// Initialize once in the very beginning
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive Database
  await HiveService().init();
  await initDependencies(); // Initialize dependencies
  runApp(
    App(),
  );
}
