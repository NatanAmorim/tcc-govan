import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.email,
    required this.senhaHash,
  });

  String email;
  String senhaHash;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        senhaHash: json["senhaHash"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "senhaHash": senhaHash,
      };
}
