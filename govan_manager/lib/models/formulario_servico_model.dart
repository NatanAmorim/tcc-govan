import 'package:flutter/material.dart';

class FormularioServicoModel {
  FormularioServicoModel({
    required this.titulo,
    required this.descricao,
    required this.valorCobrado,
    required this.vagasDisponiveis,
    required this.veiculos,
    required this.trajeto,
    required this.contrato,
  });

  TextEditingController titulo;
  TextEditingController descricao;
  TextEditingController valorCobrado;
  int vagasDisponiveis;
  List<FormularioServicoVeiculoModel> veiculos;
  FormularioServicoTrajetoModel trajeto;
  FormularioServicoContratoModel contrato;
}

class FormularioServicoContratoModel {
  FormularioServicoContratoModel({
    required this.urlPdf,
    required this.descricao,
    required this.politicaCancelamento,
  });
  String urlPdf;
  TextEditingController descricao;
  FormularioServicoContratoPoliticaCancelamentoModel politicaCancelamento;
}

class FormularioServicoContratoPoliticaCancelamentoModel {
  FormularioServicoContratoPoliticaCancelamentoModel({
    this.isRequerido = false,
    required this.mesesMinimo,
  });
  bool isRequerido;
  TextEditingController mesesMinimo;
}

class FormularioServicoTrajetoModel {
  FormularioServicoTrajetoModel({
    required this.descricao,
    required this.pontoInicio,
    required this.faculdades,
  });

  TextEditingController descricao;
  FormularioServicoTrajetoPontoInicioModel pontoInicio;
  List<FormularioServicoTrajetoFaculdadeModel> faculdades;
}

class FormularioServicoTrajetoPontoInicioModel {
  FormularioServicoTrajetoPontoInicioModel({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;
}

class FormularioServicoTrajetoFaculdadeModel {
  FormularioServicoTrajetoFaculdadeModel({
    required this.nome,
    required this.horarioChegada,
    required this.localizacao,
  });

  TextEditingController nome;
  TextEditingController horarioChegada;
  FormularioServicoTrajetoFaculdadeLocalizacaoModel localizacao;
}

class FormularioServicoTrajetoFaculdadeLocalizacaoModel {
  FormularioServicoTrajetoFaculdadeLocalizacaoModel({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;
}

class FormularioServicoVeiculoModel {
  FormularioServicoVeiculoModel({
    required this.placa,
    required this.nome,
    required this.cor,
    required this.urlFoto,
  });

  TextEditingController placa;
  TextEditingController nome;
  TextEditingController cor;
  TextEditingController urlFoto;
}
