import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:govan/controllers/api_controller.dart';
import 'package:govan/helper/api_helper.dart';
import 'package:hive/hive.dart';

class ExplorarServicosDetalhesController {
  baixarContrato(BuildContext context) {
    print('object2');
  }

  Future<bool> contratarVan({
    required BuildContext context,
    required String servicoId,
  }) async {
    final Box<dynamic> box = Hive.box('jwt');

    final Map<String, dynamic> request = <String, dynamic>{
      'data_inicio_contrato': DateTime.now().toIso8601String(),
      'data_fim_contrato': DateTime.now().toIso8601String(),
    };

    final response = await ApiHelper()
        .put(
      api: '/servico/contratar/$servicoId',
      token: box.get('token'),
      payloadObject: request,
    )
        .catchError((dynamic error, dynamic stack) {
      print(error);
      print(stack);
      handleError(
        error: error,
        context: context,
      );
    });
    if (response == null) {
      return false;
    } else {
      final Map<String, dynamic> responseJson = json.decode(response);

      return true;
    }
  }
}
