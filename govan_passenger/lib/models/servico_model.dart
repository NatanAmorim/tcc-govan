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

class ServicoModel {
  ServicoModel({
    required this.titulo,
    required this.descricao,
    required this.vagasDisponiveis,
    required this.veiculos,
    required this.trajeto,
    required this.contrato,
    this.passageiros,
  });

  String titulo;
  String descricao;
  int vagasDisponiveis;
  List<Veiculo> veiculos;
  Trajeto trajeto;
  Contrato contrato;
  List<Passageiro>? passageiros;

  factory ServicoModel.fromJson(Map<String, dynamic> json) => ServicoModel(
        titulo: json["titulo"] == null ? null : json["titulo"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        vagasDisponiveis: json["vagas_disponiveis"] == null
            ? null
            : json["vagas_disponiveis"],
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
        "titulo": titulo == null ? null : titulo,
        "descricao": descricao == null ? null : descricao,
        "vagas_disponiveis": vagasDisponiveis == null ? null : vagasDisponiveis,
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
    required this.pessoaId,
    required this.dataInicioContrato,
    required this.dataFimContrato,
    this.mensalidade,
  });

  String pessoaId;
  String dataInicioContrato;
  String dataFimContrato;
  List<Mensalidade>? mensalidade;

  factory Passageiro.fromJson(Map<String, dynamic> json) => Passageiro(
        pessoaId: json["pessoa_id"] == null ? null : json["pessoa_id"],
        dataInicioContrato: json["data_inicio_contrato"] == null
            ? null
            : json["data_inicio_contrato"],
        dataFimContrato: json["data_fim_contrato"] == null
            ? null
            : json["data_fim_contrato"],
        mensalidade: json["mensalidade"] == null
            ? null
            : List<Mensalidade>.from(
                json["mensalidade"].map((x) => Mensalidade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pessoa_id": pessoaId == null ? null : pessoaId,
        "data_inicio_contrato":
            dataInicioContrato == null ? null : dataInicioContrato,
        "data_fim_contrato": dataFimContrato == null ? null : dataFimContrato,
        "mensalidade": mensalidade == null
            ? null
            : List<dynamic>.from(mensalidade!.map((x) => x.toJson())),
      };
}

class Mensalidade {
  Mensalidade({
    required this.dataPagamento,
    required this.pagamento,
  });

  String dataPagamento;
  List<Pagamento> pagamento;

  factory Mensalidade.fromJson(Map<String, dynamic> json) => Mensalidade(
        dataPagamento:
            json["data_pagamento"] == null ? null : json["data_pagamento"],
        pagamento: List<Pagamento>.from(
            json["pagamento"].map((x) => Pagamento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data_pagamento": dataPagamento == null ? null : dataPagamento,
        "pagamento": pagamento == null
            ? null
            : List<dynamic>.from(pagamento.map((x) => x.toJson())),
      };
}

class Pagamento {
  Pagamento({
    required this.valor,
    required this.isPago,
    required this.formaPagamento,
  });

  int valor;
  bool isPago;
  String formaPagamento;

  factory Pagamento.fromJson(Map<String, dynamic> json) => Pagamento(
        valor: json["valor"] == null ? null : json["valor"],
        isPago: json["is_pago"] == null ? null : json["is_pago"],
        formaPagamento:
            json["forma_pagamento"] == null ? null : json["forma_pagamento"],
      );

  Map<String, dynamic> toJson() => {
        "valor": valor == null ? null : valor,
        "is_pago": isPago == null ? null : isPago,
        "forma_pagamento": formaPagamento == null ? null : formaPagamento,
      };
}

class Trajeto {
  Trajeto({
    required this.descricao,
    required this.pontoInicio,
    required this.pontoFim,
    required this.valorCobrado,
    required this.faculdades,
  });

  String descricao;
  String pontoInicio;
  String pontoFim;
  String valorCobrado;
  List<Faculdade> faculdades;

  factory Trajeto.fromJson(Map<String, dynamic> json) => Trajeto(
        descricao: json["descricao"] == null ? null : json["descricao"],
        pontoInicio: json["ponto_inicio"] == null ? null : json["ponto_inicio"],
        pontoFim: json["ponto_fim"] == null ? null : json["ponto_fim"],
        valorCobrado:
            json["valor_cobrado"] == null ? null : json["valor_cobrado"],
        faculdades: List<Faculdade>.from(
            json["faculdades"].map((x) => Faculdade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "descricao": descricao == null ? null : descricao,
        "ponto_inicio": pontoInicio == null ? null : pontoInicio,
        "ponto_fim": pontoFim == null ? null : pontoFim,
        "valor_cobrado": valorCobrado == null ? null : valorCobrado,
        "faculdades": faculdades == null
            ? null
            : List<dynamic>.from(faculdades.map((x) => x.toJson())),
      };
}

class Faculdade {
  Faculdade({
    required this.nome,
    required this.horarioChegada,
  });

  String nome;
  String horarioChegada;

  factory Faculdade.fromJson(Map<String, dynamic> json) => Faculdade(
        nome: json["nome"] == null ? null : json["nome"],
        horarioChegada:
            json["horario_chegada"] == null ? null : json["horario_chegada"],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome == null ? null : nome,
        "horario_chegada": horarioChegada == null ? null : horarioChegada,
      };
}

class Veiculo {
  Veiculo({
    required this.placa,
    required this.nome,
    required this.cor,
    this.urlFoto,
  });

  String placa;
  String nome;
  String cor;
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
