import 'package:flutter/material.dart';
import 'package:govan/views/login_page.dart';

import 'app_themes.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "goVan",
      theme: lightTheme, //TODO: SWICH between light and dark theme
      home: LoginPage(),
    );
  }
}
