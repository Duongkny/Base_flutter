import 'package:flutter/material.dart';
import 'package:base_flutter/src/constant/enviroment.dart';
import 'package:base_flutter/src/core/local_storage/app_local_storage.dart';

import 'src/core/app/my_app.dart';
import 'src/core/injections/injections.dart';

const String environment = String.fromEnvironment(
  'ENV',
  defaultValue: 'development',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Validate Environment
  if (environment != 'development' &&
      environment != 'production') {
    throw StateError(
      'Unsupported environment: $environment',
    );
  }

  // 2. Initialize Environment
  await Environment.initialize();

  // 3. Initialize Local Storage (Hive CE & Boxes)
  await AppLocalStorage().initLocalStorage();

  // 4. Dependency Injection
  await configureDependencies();

  // 5. Run Application
  runApp(const MyApp());
}
