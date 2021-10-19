import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:govan/controllers/api_controller.dart';
import 'package:govan/helper/api_helper.dart';
import 'package:hive/hive.dart';

class LoginController {
  late bool isObscurePassword;
  late bool isLoggingIn;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  Future<bool> login({
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    final Map<String, String> request = <String, String>{
      "email": emailController.text,
      "senha": passwordController.text,
    };

    var response = await ApiHelper()
        .post(
      api: '/api/auth/login',
      payloadObject: request,
    )
        .catchError(
      (dynamic error, dynamic stack) {
        print(error);
        print(stack);
        handleErrorLogin(
          error: error,
          context: context,
        );
      },
    );
    if (response == null) {
      return false;
    } else {
      final Map<String, dynamic> responseJson = json.decode(response);
      final Box<dynamic> box = Hive.box('jwt');

      await box.put(
        'token',
        responseJson['token'],
      );

      return true;
    }
  }
}
