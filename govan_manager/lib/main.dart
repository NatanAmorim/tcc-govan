import 'package:flutter/material.dart';
import 'package:govan/constants/app_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('jwt');

  runApp(AppWidget());
}
