import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:govan/models/servico_model.dart';
import 'package:govan/services/app_exception_service.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const int TIME_OUT_DURATION = 5;
  // final String _baseUrl = 'http://10.0.2.2:1337/api';
  final String _baseUrl = 'http://192.168.15.4:1337/api';

  Future<dynamic> get({
    required String api,
    String? baseURL,
    String? token,
  }) async {
    var responseJson;
    try {
      final Uri uri = Uri.parse(baseURL ?? _baseUrl + api);

      final http.Response response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: TIME_OUT_DURATION),
      );

      responseJson = _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        message: 'Não foi possível conectar',
      );
    } on TimeoutException {
      throw ApiNotRespondingAppException(
        message:
            'Tempo esgotado, o servidor não respondeu dentro do tempo limite',
      );
    }
    return responseJson;
  }

  Future<dynamic> post({
    required String api,
    required dynamic payloadObject,
    String? baseURL,
    String? token,
  }) async {
    dynamic responseJson;
    try {
      final Uri uri = Uri.parse(baseURL ?? _baseUrl + api);
      final Object payload = json.encode(payloadObject);

      final http.Response response = await http.post(
        uri,
        body: payload,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: TIME_OUT_DURATION),
      );

      responseJson = _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        message: 'Não foi possível conectar',
      );
    } on TimeoutException {
      throw ApiNotRespondingAppException(
        message:
            'Tempo esgotado, o servidor não respondeu dentro do tempo limite',
      );
    }
    return responseJson;
  }

  Future<dynamic> patch({
    required String api,
    required dynamic payloadObject,
    String? baseURL,
    String? token,
  }) async {
    dynamic responseJson;
    try {
      final Uri uri = Uri.parse(baseURL ?? _baseUrl + api);
      final Object payload = json.encode(payloadObject);

      final http.Response response = await http.patch(
        uri,
        body: payload,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: TIME_OUT_DURATION),
      );

      responseJson = _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        message: 'Não foi possível conectar',
      );
    } on TimeoutException {
      throw ApiNotRespondingAppException(
        message:
            'Tempo esgotado, o servidor não respondeu dentro do tempo limite',
      );
    }
    return responseJson;
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 204:
        return true;
      case 400:
        throw BadRequestException(
          message: utf8.decode(response.bodyBytes),
        );
      case 401:
        throw UnAuthorizedException(
          message: utf8.decode(response.bodyBytes),
        );
      case 403:
        throw ForbiddenRequestException(
          message: utf8.decode(response.bodyBytes),
        );
      case 409:
        throw ConflictException(
          message: utf8.decode(response.bodyBytes),
        );
      case 500:
        throw InternalServerErrorException(
          message: utf8.decode(response.bodyBytes),
        );
      default:
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final String responseJson = utf8.decode(response.bodyBytes);
          return responseJson;
        } else {
          throw FetchDataException(
            message: 'Ocorreu um erro! status code: ${response.statusCode}.',
          );
        }
    }
  }
}
