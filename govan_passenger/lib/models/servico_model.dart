import 'dart:convert';

ServicosModel servicosModelFromJson(String str) =>
    ServicosModel.fromJson(json.decode(str));

String servicosModelToJson(ServicosModel data) => json.encode(data.toJson());

class ServicosModel {
  ServicosModel({
    this.servicos,
  });

  List<ServicoModel>? servicos;

  factory ServicosModel.fromJson(Map<String, dynamic> json) => ServicosModel(
        servicos: json["servicos"] == null
            ? null
            : List<ServicoModel>.from(
                json["servicos"].map((x) => ServicoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "servicos": servicos == null
            ? null
            : List<dynamic>.from(servicos!.map((x) => x.toJson())),
      };
}

ServicoModel servicoModelFromJson(String str) =>
    ServicoModel.fromJson(json.decode(str));

String servicoModelToJson(ServicoModel data) => json.encode(data.toJson());

class ServicoModel {
  ServicoModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.vagasDisponiveis,
    required this.valorCobrado,
    required this.veiculos,
    required this.trajeto,
    required this.contrato,
    this.passageiros,
  });

  String? id;
  String titulo;
  String descricao;
  int vagasDisponiveis;
  String valorCobrado;
  List<Veiculo> veiculos;
  Trajeto trajeto;
  Contrato contrato;
  List<Passageiro>? passageiros;

  factory ServicoModel.fromJson(Map<String, dynamic> json) => ServicoModel(
        id: json["_id"] == null ? null : json["_id"],
        titulo: json["titulo"] == null ? null : json["titulo"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        vagasDisponiveis: json["vagas_disponiveis"] == null
            ? null
            : json["vagas_disponiveis"],
        valorCobrado:
            json["valor_cobrado"] == null ? null : json["valor_cobrado"],
        veiculos: List<Veiculo>.from(
            json["veiculos"].map((x) => Veiculo.fromJson(x))),
        trajeto: Trajeto.fromJson(json["trajeto"]),
        contrato: Contrato.fromJson(json["contrato"]),
        passageiros: json["passageiros"] == null
            ? null
            : List<Passageiro>.from(
                json["passageiros"].map((x) => Passageiro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "titulo": titulo == null ? null : titulo,
        "descricao": descricao == null ? null : descricao,
        "vagas_disponiveis": vagasDisponiveis == null ? null : vagasDisponiveis,
        "valor_cobrado": valorCobrado == null ? null : valorCobrado,
        "veiculos": veiculos == null
            ? null
            : List<dynamic>.from(veiculos.map((x) => x.toJson())),
        "trajeto": trajeto == null ? null : trajeto.toJson(),
        "contrato": contrato == null ? null : contrato.toJson(),
        "passageiros": passageiros == null
            ? null
            : List<dynamic>.from(passageiros!.map((x) => x.toJson())),
      };
}

class Contrato {
  Contrato({
    required this.urlPdf,
    required this.descricao,
    required this.politicaCancelamento,
  });

  String urlPdf;
  String descricao;
  PoliticaCancelamento politicaCancelamento;

  factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        urlPdf: json["url_pdf"] == null ? null : json["url_pdf"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        politicaCancelamento:
            PoliticaCancelamento.fromJson(json["politica_cancelamento"]),
      );

  Map<String, dynamic> toJson() => {
        "url_pdf": urlPdf == null ? null : urlPdf,
        "descricao": descricao == null ? null : descricao,
        "politica_cancelamento":
            politicaCancelamento == null ? null : politicaCancelamento.toJson(),
      };
}

class PoliticaCancelamento {
  PoliticaCancelamento({
    required this.isRequerido,
    this.mesesMinimo,
  });

  bool isRequerido;
  int? mesesMinimo;

  factory PoliticaCancelamento.fromJson(Map<String, dynamic> json) =>
      PoliticaCancelamento(
        isRequerido: json["is_requerido"] == null ? null : json["is_requerido"],
        mesesMinimo: json["meses_minimo"] == null ? null : json["meses_minimo"],
      );

  Map<String, dynamic> toJson() => {
        "is_requerido": isRequerido == null ? null : isRequerido,
        "meses_minimo": mesesMinimo == null ? null : mesesMinimo,
      };
}

class Passageiro {
  Passageiro({
    this.id,
    required this.pessoaId,
    required this.pessoaNome,
    required this.dataInicioContrato,
    required this.dataFimContrato,
    required this.mensalidade,
  });

  String? id;
  String pessoaId;
  String pessoaNome;
  DateTime dataInicioContrato;
  DateTime dataFimContrato;
  List<Mensalidade> mensalidade;

  factory Passageiro.fromJson(Map<String, dynamic> json) => Passageiro(
        id: json["_id"] == null ? null : json["_id"],
        pessoaId: json["pessoa_id"] == null ? null : json["pessoa_id"],
        pessoaNome: json["pessoa_nome"] == null ? null : json["pessoa_nome"],
        dataInicioContrato: DateTime.parse(json["data_inicio_contrato"]),
        dataFimContrato: DateTime.parse(json["data_fim_contrato"]),
        mensalidade: List<Mensalidade>.from(
            json["mensalidade"].map((x) => Mensalidade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "pessoa_id": pessoaId == null ? null : pessoaId,
        "pessoa_nome": pessoaNome == null ? null : pessoaNome,
        "data_inicio_contrato": dataInicioContrato == null
            ? null
            : dataInicioContrato.toIso8601String(),
        "data_fim_contrato":
            dataFimContrato == null ? null : dataFimContrato.toIso8601String(),
        "mensalidade": mensalidade == null
            ? null
            : List<dynamic>.from(mensalidade.map((x) => x.toJson())),
      };
}

class Mensalidade {
  Mensalidade({
    this.id,
    this.dataVencimento,
    this.valor,
    this.isPago,
    this.formaPagamento,
  });

  String? id;
  DateTime? dataVencimento;
  int? valor;
  bool? isPago;
  String? formaPagamento;

  factory Mensalidade.fromJson(Map<String, dynamic> json) => Mensalidade(
        id: json["_id"] == null ? null : json["_id"],
        dataVencimento: json["data_vencimento"] == null
            ? null
            : DateTime.parse(json["data_vencimento"]),
        valor: json["valor"] == null ? null : json["valor"],
        isPago: json["is_pago"] == null ? null : json["is_pago"],
        formaPagamento:
            json["forma_pagamento"] == null ? null : json["forma_pagamento"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "data_vencimento":
            dataVencimento == null ? null : dataVencimento!.toIso8601String(),
        "valor": valor == null ? null : valor,
        "is_pago": isPago == null ? null : isPago,
        "forma_pagamento": formaPagamento == null ? null : formaPagamento,
      };
}

class Trajeto {
  Trajeto({
    required this.descricao,
    required this.pontoInicio,
    required this.faculdades,
  });

  String descricao;
  Localizacao pontoInicio;
  List<Faculdade> faculdades;

  factory Trajeto.fromJson(Map<String, dynamic> json) => Trajeto(
        descricao: json["descricao"] == null ? null : json["descricao"],
        pontoInicio: Localizacao.fromJson(json["ponto_inicio"]),
        faculdades: List<Faculdade>.from(
            json["faculdades"].map((x) => Faculdade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "descricao": descricao == null ? null : descricao,
        "ponto_inicio": pontoInicio == null ? null : pontoInicio.toJson(),
        "faculdades": faculdades == null
            ? null
            : List<dynamic>.from(faculdades.map((x) => x.toJson())),
      };
}

class Faculdade {
  Faculdade({
    this.nome,
    this.horarioChegada,
    this.localizacao,
  });

  String? nome;
  String? horarioChegada;
  Localizacao? localizacao;

  factory Faculdade.fromJson(Map<String, dynamic> json) => Faculdade(
        nome: json["nome"] == null ? null : json["nome"],
        horarioChegada:
            json["horario_chegada"] == null ? null : json["horario_chegada"],
        localizacao: json["localizacao"] == null
            ? null
            : Localizacao.fromJson(json["localizacao"]),
      );

  Map<String, dynamic> toJson() => {
        "nome": nome == null ? null : nome,
        "horario_chegada": horarioChegada == null ? null : horarioChegada,
        "localizacao": localizacao == null ? null : localizacao!.toJson(),
      };
}

class Localizacao {
  Localizacao({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Localizacao.fromJson(Map<String, dynamic> json) => Localizacao(
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}

class Veiculo {
  Veiculo({
    required this.nome,
    required this.cor,
    required this.placa,
    this.urlFoto,
  });

  String nome;
  String cor;
  String placa;
  String? urlFoto;

  factory Veiculo.fromJson(Map<String, dynamic> json) => Veiculo(
        placa: json["placa"] == null ? null : json["placa"],
        nome: json["nome"] == null ? null : json["nome"],
        cor: json["cor"] == null ? null : json["cor"],
        urlFoto: json["url_foto"] == null ? null : json["url_foto"],
      );

  Map<String, dynamic> toJson() => {
        "placa": placa == null ? null : placa,
        "nome": nome == null ? null : nome,
        "cor": cor == null ? null : cor,
        "url_foto": urlFoto == null ? null : urlFoto,
      };
}
