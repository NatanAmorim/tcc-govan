import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController usernameController, passwordController;

  bool isObscurePassword = true;

  bool isLoggingIn = false;

  Future<dynamic> login() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    var userBox = Hive.box('logged_user');

    // userBox.put('token', responseJson["token"]);
    // userBox.put('usuario_id', responseJson["usuario_id"]);
    // userBox.put(
    //     'usuario_nome_completo', responseJson["usuario_nome_completo"]);
    // userBox.put('usuario_role', responseJson["usuario_role"]);
  }
}
