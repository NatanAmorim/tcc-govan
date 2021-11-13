// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuariosModel {
  UsuariosModel({
    required this.usuarios,
  });

  List<UsuarioModel>? usuarios;

  factory UsuariosModel.fromJson(Map<String, dynamic> json) => UsuariosModel(
        usuarios: json["usuarios"] == null
            ? null
            : List<UsuarioModel>.from(
                json["usuarios"].map((x) => UsuarioModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "usuarios": usuarios == null
            ? null
            : List<dynamic>.from(usuarios!.map((x) => x.toJson())),
      };
}

class UsuarioModel {
  UsuarioModel({
    required this.pessoa,
    this.minhasVans,
    this.meusServicos,
    required this.isMotorista,
    this.id,
    required this.email,
    required this.senha,
    this.urlFoto,
    this.cnh,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Pessoa pessoa;
  List<String>? minhasVans;
  List<String>? meusServicos;
  bool isMotorista;
  String? id;
  String email;
  String senha;
  String? urlFoto;
  String? cnh;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        pessoa: Pessoa.fromJson(json["pessoa"]),
        minhasVans: json["minhas_vans"] == null
            ? null
            : List<String>.from(json["minhas_vans"].map((x) => x)),
        meusServicos: json["meus_servicos"] == null
            ? null
            : List<String>.from(json["meus_servicos"].map((x) => x)),
        isMotorista: json["is_motorista"] == null ? null : json["is_motorista"],
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        senha: json["senha"] == null ? null : json["senha"],
        cnh: json["cnh"] == null ? null : json["cnh"],
        urlFoto: json["url_foto"] == null ? null : json["url_foto"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "pessoa": pessoa == null ? null : pessoa.toJson(),
        "minhas_vans": minhasVans == null
            ? null
            : List<dynamic>.from(minhasVans!.map((x) => x)),
        "meus_servicos": meusServicos == null
            ? null
            : List<dynamic>.from(meusServicos!.map((x) => x)),
        "is_motorista": isMotorista == null ? null : isMotorista,
        "_id": id == null ? null : id,
        "email": email == null ? null : email,
        "senha": senha == null ? null : senha,
        "cnh": cnh == null ? null : cnh,
        "url_foto": urlFoto == null ? null : urlFoto,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
      };
}

class Pessoa {
  Pessoa({
    required this.endereco,
    required this.nome,
    this.apelido,
    this.telefone,
    required this.rg,
    required this.cpf,
    this.cnh,
  });

  Endereco endereco;
  String nome;
  String? apelido;
  String? telefone;
  String rg;
  String cpf;
  String? cnh;

  factory Pessoa.fromJson(Map<String, dynamic> json) => Pessoa(
        endereco: Endereco.fromJson(json["endereco"]),
        nome: json["nome"] == null ? null : json["nome"],
        apelido: json["apelido"] == null ? null : json["apelido"],
        telefone: json["telefone"] == null ? null : json["telefone"],
        rg: json["rg"] == null ? null : json["rg"],
        cpf: json["cpf"] == null ? null : json["cpf"],
        cnh: json["cnh"] == null ? null : json["cnh"],
      );

  Map<String, dynamic> toJson() => {
        "endereco": endereco == null ? null : endereco.toJson(),
        "nome": nome == null ? null : nome,
        "apelido": apelido == null ? null : apelido,
        "telefone": telefone == null ? null : telefone,
        "rg": rg == null ? null : rg,
        "cpf": cpf == null ? null : cpf,
        "cnh": cnh == null ? null : cnh,
      };
}

class Endereco {
  Endereco({
    required this.cep,
    required this.bairro,
    required this.cidade,
    this.logadouro,
    this.numero,
    this.complemento,
  });

  String cep;
  String? logadouro;
  String? numero;
  String bairro;
  String? complemento;
  String cidade;

  factory Endereco.fromJson(Map<String, dynamic> json) => Endereco(
        cep: json["cep"] == null ? null : json["cep"],
        logadouro: json["logadouro"] == null ? null : json["logadouro"],
        numero: json["numero"] == null ? null : json["numero"],
        bairro: json["bairro"] == null ? null : json["bairro"],
        complemento: json["complemento"] == null ? null : json["complemento"],
        cidade: json["cidade"] == null ? null : json["cidade"],
      );

  Map<String, dynamic> toJson() => {
        "cep": cep == null ? null : cep,
        "logadouro": logadouro == null ? null : logadouro,
        "numero": numero == null ? null : numero,
        "bairro": bairro == null ? null : bairro,
        "complemento": complemento == null ? null : complemento,
        "cidade": cidade == null ? null : cidade,
      };
}
