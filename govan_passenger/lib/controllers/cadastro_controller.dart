import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:govan/controllers/api_controller.dart';
import 'package:govan/helper/api_helper.dart';
import 'package:govan/models/usuario_model.dart';
import 'package:hive/hive.dart';

class CadastroController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late TextEditingController nomeController;
  late TextEditingController rgController;
  late TextEditingController cpfController;
  late TextEditingController cepController;
  late TextEditingController bairroController;
  late TextEditingController cidadeController;
  late TextEditingController logadouroController;
  late TextEditingController numeroController;
  late TextEditingController complementoController;

  bool isObscurePassword = true;

  bool isLoggingIn = false;

  Future<bool> cadastrar({
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    final UsuarioModel request = UsuarioModel(
      email: emailController.text,
      senha: passwordController.text,
      isMotorista: false,
      pessoa: Pessoa(
        endereco: Endereco(
          cep: cepController.text,
          bairro: bairroController.text,
          cidade: cidadeController.text,
          logadouro: logadouroController.text,
          numero: numeroController.text,
          complemento: complementoController.text,
        ),
        nome: nomeController.text,
        rg: rgController.text,
        cpf: cpfController.text,
      ),
      urlFoto: '', // todo
    );

    var response = await ApiHelper()
        .post(
      api: '/usuario/',
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
      final Box<dynamic> loggedUserBox = Hive.box('jwt');

      await loggedUserBox.put(
        'token',
        responseJson['token'],
      );

      return true;
    }
  }
}
