import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:govan/controllers/api_controller.dart';
import 'package:govan/helper/api_helper.dart';
import 'package:hive/hive.dart';

class PagamentosController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController formaPagamentoTextEditingController =
      TextEditingController();

  Future<bool> marcarPago({
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    return true;
  }

  Future<bool> editar({
    required String servicoId,
    required String passageiroId,
    required String dataVencimento,
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    final Box<dynamic> box = Hive.box('jwt');

    final Map<String, dynamic> request = {
      'passageiro_id': passageiroId,
      'data_vencimento': dataVencimento,
      'forma_pagamento': formaPagamentoTextEditingController.text
    };

    var response = await ApiHelper()
        .patch(
      api: '/servico/pagamento/$servicoId',
      payloadObject: request,
      token: box.get('token'),
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
      return true;
    }
  }
}
