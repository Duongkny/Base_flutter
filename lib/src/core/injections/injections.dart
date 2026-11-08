import 'package:get_it/get_it.dart';
import 'package:base_flutter/src/core/injections/injections.config.dart';
import 'package:injectable/injectable.dart';


final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}