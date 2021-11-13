import 'package:flutter/material.dart';

class FormularioServicoModel {
  FormularioServicoModel({
    required this.titulo,
    required this.descricao,
    required this.vagasDisponiveis,
    required this.veiculos,
    required this.trajeto,
    required this.contrato,
  });

  TextEditingController titulo;
  TextEditingController descricao;
  TextEditingController vagasDisponiveis;
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
    required this.pontoFim,
    required this.valorCobrado,
    required this.faculdades,
  });

  TextEditingController descricao;
  TextEditingController pontoInicio;
  TextEditingController pontoFim;
  TextEditingController valorCobrado;
  List<FormularioServicoTrajetoFaculdadeModel> faculdades;
}

class FormularioServicoTrajetoFaculdadeModel {
  FormularioServicoTrajetoFaculdadeModel({
    required this.nome,
    required this.horarioChegada,
  });

  TextEditingController nome;
  TextEditingController horarioChegada;
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
