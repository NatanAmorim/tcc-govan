import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:govan/controllers/api_controller.dart';
import 'package:govan/helper/api_helper.dart';
import 'package:govan/models/formulario_servico_model.dart';
import 'package:govan/models/servico_model.dart';
import 'package:hive/hive.dart';

class CriarServicoController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late FormularioServicoModel formularioServico;

  Future<bool> postar({
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    final Box<dynamic> box = Hive.box('jwt');

    final ServicoModel request = ServicoModel(
      titulo: formularioServico.titulo.text,
      descricao: formularioServico.descricao.text,
      valorCobrado: formularioServico.valorCobrado.text,
      vagasDisponiveis: formularioServico.vagasDisponiveis,
      veiculos: formularioServico.veiculos
          .map(
            (FormularioServicoVeiculoModel veiculo) => Veiculo(
              placa: veiculo.placa.text,
              nome: veiculo.nome.text,
              cor: veiculo.cor.text,
            ),
          )
          .toList(),
      trajeto: Trajeto(
        descricao: formularioServico.trajeto.descricao.text,
        pontoInicio: Localizacao(
          latitude: formularioServico.trajeto.pontoInicio.latitude,
          longitude: formularioServico.trajeto.pontoInicio.longitude,
        ),
        faculdades: formularioServico.trajeto.faculdades
            .map(
                (FormularioServicoTrajetoFaculdadeModel faculdade) => Faculdade(
                      nome: faculdade.nome.text,
                      horarioChegada: faculdade.horarioChegada.text,
                      localizacao: Localizacao(
                        latitude: faculdade.localizacao.latitude,
                        longitude: faculdade.localizacao.longitude,
                      ),
                    ))
            .toList(),
      ),
      contrato: Contrato(
        descricao: formularioServico.contrato.descricao.text,
        // urlPdf: formularioServico.contrato.urlPdf,
        urlPdf: 'formularioServico.contrato.urlPdf',
        politicaCancelamento: PoliticaCancelamento(
          isRequerido:
              formularioServico.contrato.politicaCancelamento.isRequerido,
          mesesMinimo: formularioServico
                  .contrato.politicaCancelamento.mesesMinimo.text.isNotEmpty
              ? int.parse(formularioServico
                  .contrato.politicaCancelamento.mesesMinimo.text)
              : 0,
        ),
      ),
    );

    var response = await ApiHelper()
        .post(
      api: '/servico',
      payloadObject: request,
      token: box.get('token'),
    )
        .catchError(
      (dynamic error, dynamic stack) {
        print(error);
        print(stack);
        handleErrorLogin(
          error: error,
          context: context,
        );
      },
    );
    if (response == null) {
      return false;
    } else {
      final Map<String, dynamic> responseJson = json.decode(response);
      final Box<dynamic> loggedUserBox = Hive.box('jwt');

      await loggedUserBox.put(
        'token',
        responseJson['token'],
      );

      return true;
    }
  }

  Future<bool> editar({
    required String id,
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    final Box<dynamic> box = Hive.box('jwt');

    final Map<String, dynamic> request = ServicoModel(
      titulo: formularioServico.titulo.text,
      descricao: formularioServico.descricao.text,
      valorCobrado: formularioServico.valorCobrado.text,
      vagasDisponiveis: formularioServico.vagasDisponiveis,
      veiculos: formularioServico.veiculos
          .map((FormularioServicoVeiculoModel veiculo) => Veiculo(
              placa: veiculo.placa.text,
              nome: veiculo.nome.text,
              cor: veiculo.cor.text))
          .toList(),
      trajeto: Trajeto(
        descricao: formularioServico.trajeto.descricao.text,
        pontoInicio: Localizacao(
          latitude: formularioServico.trajeto.pontoInicio.latitude,
          longitude: formularioServico.trajeto.pontoInicio.longitude,
        ),
        faculdades: formularioServico.trajeto.faculdades
            .map(
              (FormularioServicoTrajetoFaculdadeModel faculdade) => Faculdade(
                nome: faculdade.nome.text,
                horarioChegada: faculdade.horarioChegada.text,
                localizacao: Localizacao(
                  latitude: faculdade.localizacao.latitude,
                  longitude: faculdade.localizacao.longitude,
                ),
              ),
            )
            .toList(),
      ),
      contrato: Contrato(
        descricao: formularioServico.contrato.descricao.text,
        // urlPdf: formularioServico.contrato.urlPdf,
        urlPdf: 'formularioServico.contrato.urlPdf',
        politicaCancelamento: PoliticaCancelamento(
          isRequerido:
              formularioServico.contrato.politicaCancelamento.isRequerido,
          mesesMinimo: formularioServico
                  .contrato.politicaCancelamento.mesesMinimo.text.isNotEmpty
              ? int.parse(formularioServico
                  .contrato.politicaCancelamento.mesesMinimo.text)
              : 0,
        ),
      ),
    ).toJson();

    request
      ..remove('_id')
      ..remove('passageiros');

    var response = await ApiHelper()
        .patch(
      api: '/servico/$id',
      payloadObject: request,
      token: box.get('token'),
    )
        .catchError(
      (dynamic error, dynamic stack) {
        print(error);
        print(stack);
        handleErrorLogin(
          error: error,
          context: context,
        );
      },
    );
    if (response == null) {
      return false;
    } else {
      final Map<String, dynamic> responseJson = json.decode(response);
      final Box<dynamic> loggedUserBox = Hive.box('jwt');

      await loggedUserBox.put(
        'token',
        responseJson['token'],
      );

      return true;
    }
  }
}
