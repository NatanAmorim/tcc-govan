import 'package:dio/dio.dart';
import 'package:govan/models/login_model.dart';

void login({required LoginModel loginJson}) async {
  var dio = Dio();
  final response =
      await dio.post('http://10.0.2.2:3000/login', data: loginJson);
  print(response.statusCode);
  print(response.data);
}
