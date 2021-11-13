import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:govan/controllers/api_controller.dart';
import 'package:govan/helper/api_helper.dart';
import 'package:govan/models/login_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginController {
  late bool isObscurePassword;
  late bool isLoggingIn;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController senhaController;

  Future<bool> login({
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    final Map<String, dynamic> request = LoginModel(
      email: emailController.text,
      senha: senhaController.text,
    ).toJson();

    final response = await ApiHelper()
        .post(
      api: '/auth/login',
      payloadObject: request,
    )
        .catchError((dynamic error, dynamic stack) {
      print(error);
      print(stack);
      handleErrorLogin(
        error: error,
        context: context,
      );
    });
    if (response == null) {
      return false;
    } else {
      // LOGIN SUCESS, now get the response
      final Map<String, dynamic> responseJson = json.decode(response);
      // Store JWT token on HiveDB
      final Box<dynamic> loggedUserBox = Hive.box('jwt');

      await loggedUserBox.put(
        'token',
        responseJson['token'],
      );

      return true;
    }
  }
}
