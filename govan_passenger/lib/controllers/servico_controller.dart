import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:govan/controllers/api_controller.dart';
import 'package:govan/helper/api_helper.dart';
import 'package:govan/models/servico_model.dart';
import 'package:hive/hive.dart';

class ServicoController {
  ServicosModel? servicos;

  Future<ServicosModel> fetchServicos({required BuildContext context}) async {
    final Box<dynamic> box = Hive.box('jwt');

    var response = await ApiHelper()
        .get(
      api: '/servico/',
      token: box.get('token'),
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
      throw Exception("Something gone wrong");
    } else {
      // REQUEST SUCESS
      var responseJson = json.decode(response);

      var servicos = ServicosModel.fromJson(responseJson);
      return servicos;
    }
  }

  Future<ServicosModel> fetchMeusServicos(
      {required BuildContext context}) async {
    final Box<dynamic> box = Hive.box('jwt');

    var response = await ApiHelper()
        .get(
      api: '/servico/passageiro/',
      token: box.get('token'),
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
      throw Exception("Something gone wrong");
    } else {
      // REQUEST SUCESS
      var responseJson = json.decode(response);

      var servicos = ServicosModel.fromJson(responseJson);
      return servicos;
    }
  }

  Future<ServicosModel> fetchServicosSearch({
    required BuildContext context,
    required String input,
  }) async {
    final Box<dynamic> box = Hive.box('jwt');
    var request = <String, String>{
      'input': input,
    };

    var response = await ApiHelper()
        .post(
      api: '/servico/search',
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
      throw Exception("Something gone wrong");
    } else {
      // REQUEST SUCESS
      var responseJson = json.decode(response);

      var servicos = ServicosModel.fromJson(responseJson);
      return servicos;
    }
  }
}
