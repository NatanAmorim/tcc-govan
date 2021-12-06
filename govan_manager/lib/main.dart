import 'package:flutter/material.dart';
import 'package:govan/constants/app_widget.dart';
import 'package:here_sdk/core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('jwt');

  // Ensure that all widgets, including MyApp, have a MaterialLocalizations object available.
  SdkContext.init(IsolateOrigin.main);

  runApp(AppWidget());
}
