import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:govan/controllers/criar_servico_controller.dart';
import 'package:govan/models/formulario_servico_model.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/selecionar_localizacao_page.dart';
import 'package:govan/widgets/integer_field.dart';
import 'package:govan/widgets/text_field.dart';

class CriarServicoPage extends StatefulWidget {
  const CriarServicoPage({
    Key? key,
    this.servico,
  }) : super(key: key);

  final ServicoModel? servico;

  @override
  _CriarServicoPageState createState() => _CriarServicoPageState();
}

class _CriarServicoPageState extends State<CriarServicoPage> {
  final CriarServicoController controller = CriarServicoController();

  @override
  void initState() {
    super.initState();
    if (widget.servico != null) {
      controller.formularioServico = FormularioServicoModel(
        titulo: TextEditingController(
          text: widget.servico!.titulo,
        ),
        descricao: TextEditingController(
          text: widget.servico!.descricao,
        ),
        valorCobrado: MoneyMaskedTextController(
          initialValue: double.parse(
            widget.servico!.valorCobrado.replaceAll(r'R$ ', ''),
          ),
          decimalSeparator: '.',
          thousandSeparator: ',',
          leftSymbol: r'R$ ',
        ),
        vagasDisponiveis: widget.servico!.vagasDisponiveis,
        veiculos: widget.servico!.veiculos
            .map(
              (Veiculo veiculo) => FormularioServicoVeiculoModel(
                nome: TextEditingController(
                  text: veiculo.nome,
                ),
                cor: TextEditingController(
                  text: veiculo.cor,
                ),
                placa: TextEditingController(
                  text: veiculo.placa,
                ),
                urlFoto: TextEditingController(
                  text: veiculo.urlFoto,
                ),
              ),
            )
            .toList(),
        contrato: FormularioServicoContratoModel(
          descricao: TextEditingController(
            text: widget.servico!.contrato.descricao,
          ),
          politicaCancelamento:
              FormularioServicoContratoPoliticaCancelamentoModel(
            isRequerido:
                widget.servico!.contrato.politicaCancelamento.isRequerido,
            mesesMinimo: TextEditingController(
              text: widget.servico!.contrato.politicaCancelamento.mesesMinimo
                  .toString(),
            ),
          ),
          urlPdf: '', //fix
        ),
        trajeto: FormularioServicoTrajetoModel(
          descricao: TextEditingController(
            text: widget.servico!.trajeto.descricao,
          ),
          pontoInicio: FormularioServicoTrajetoPontoInicioModel(
            latitude: 0.0,
            longitude: 0.0,
          ),
          faculdades: widget.servico!.trajeto.faculdades
              .map(
                (Faculdade faculdade) => FormularioServicoTrajetoFaculdadeModel(
                  nome: TextEditingController(
                    text: faculdade.nome,
                  ),
                  horarioChegada: TextEditingController(
                    text: faculdade.horarioChegada,
                  ),
                  localizacao:
                      FormularioServicoTrajetoFaculdadeLocalizacaoModel(
                    latitude: 0.0,
                    longitude: 0.0,
                  ),
                ),
              )
              .toList(),
        ),
      );
    } else {
      controller.formularioServico = FormularioServicoModel(
        titulo: TextEditingController(),
        descricao: TextEditingController(),
        valorCobrado: MoneyMaskedTextController(
          decimalSeparator: '.',
          thousandSeparator: ',',
          leftSymbol: 'R\$ ',
        ),
        vagasDisponiveis: 1,
        veiculos: <FormularioServicoVeiculoModel>[
          FormularioServicoVeiculoModel(
            nome: TextEditingController(),
            cor: TextEditingController(),
            placa: TextEditingController(),
            urlFoto: TextEditingController(),
          ),
        ],
        contrato: FormularioServicoContratoModel(
          descricao: TextEditingController(),
          politicaCancelamento:
              FormularioServicoContratoPoliticaCancelamentoModel(
            isRequerido: false,
            mesesMinimo: TextEditingController(),
          ),
          urlPdf: '', //fix
        ),
        trajeto: FormularioServicoTrajetoModel(
          descricao: TextEditingController(),
          pontoInicio: FormularioServicoTrajetoPontoInicioModel(
            latitude: 0.0,
            longitude: 0.0,
          ),
          faculdades: <FormularioServicoTrajetoFaculdadeModel>[
            FormularioServicoTrajetoFaculdadeModel(
              nome: TextEditingController(),
              horarioChegada: TextEditingController(),
              localizacao: FormularioServicoTrajetoFaculdadeLocalizacaoModel(
                latitude: 0.0,
                longitude: 0.0,
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        key: controller.scaffoldKey,
        appBar: AppBar(
          title: const Text('Novo Servicço'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  TextFieldWidget(
                    fieldName: "Título",
                    controller: controller.formularioServico.titulo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu nome de Título';
                      } else if (value.length < 5) {
                        return 'Minimo 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  IntegerFieldWidget(
                    fieldName: "Valor Cobrado",
                    controller: controller.formularioServico.valorCobrado,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu nome de Título';
                      } else if (value.length < 5) {
                        return 'Minimo 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldWidget(
                    minLines: 5,
                    maxLines: 5,
                    fieldName: "Descrição do Serviço",
                    controller: controller.formularioServico.descricao,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um texto';
                      } else if (value.length < 30) {
                        return 'Minimo 30 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Números de Vagas:',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                controller.formularioServico.vagasDisponiveis++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              size: 36,
                            ),
                          ),
                          Text(
                            controller.formularioServico.vagasDisponiveis
                                .toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller
                                      .formularioServico.vagasDisponiveis !=
                                  1) {
                                setState(() {
                                  controller
                                      .formularioServico.vagasDisponiveis--;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.upload),
                    label: Text('Enviar PDF Contrato'),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contrato Obrigatório?',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(width: 10.0),
                      Switch(
                        value: controller.formularioServico.contrato
                            .politicaCancelamento.isRequerido,
                        onChanged: (value) {
                          setState(() {
                            controller.formularioServico.contrato
                                .politicaCancelamento.isRequerido = value;
                          });
                        },
                        activeTrackColor: Colors.yellow,
                        activeColor: Colors.orangeAccent,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: controller.formularioServico.contrato
                        .politicaCancelamento.isRequerido,
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        IntegerFieldWidget(
                          fieldName: "Números de Meses com fidelidade",
                          controller: controller.formularioServico.contrato
                              .politicaCancelamento.mesesMinimo,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite um texto';
                            } else if (value.length < 1) {
                              return 'Minimo 1 número';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldWidget(
                    minLines: 5,
                    maxLines: 5,
                    fieldName: "Descrição do Contrato",
                    controller: controller.formularioServico.contrato.descricao,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um texto';
                      } else if (value.length < 10) {
                        return 'Minimo 10 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Veículos',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  ...controller.formularioServico.veiculos.map(
                    (FormularioServicoVeiculoModel veiculo) => Column(
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        TextFieldWidget(
                          fieldName: "Nome do Veículo",
                          controller: veiculo.nome,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome de Título';
                            } else if (value.length < 5) {
                              return 'Minimo 5 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldWidget(
                          fieldName: "Placa do Veículo",
                          controller: veiculo.placa,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome de Título';
                            } else if (value.length < 5) {
                              return 'Minimo 5 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldWidget(
                          fieldName: "Cor do Veículo",
                          controller: veiculo.cor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome de Título';
                            } else if (value.length < 5) {
                              return 'Minimo 5 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.upload),
                          label: Text('Enviar foto do Veículo'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        controller.formularioServico.veiculos.add(
                          FormularioServicoVeiculoModel(
                            nome: TextEditingController(),
                            cor: TextEditingController(),
                            placa: TextEditingController(),
                            urlFoto: TextEditingController(),
                          ),
                        );
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldWidget(
                    minLines: 5,
                    maxLines: 5,
                    fieldName: "Descrição do Trajeto",
                    controller: controller.formularioServico.trajeto.descricao,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um texto';
                      } else if (value.length < 10) {
                        return 'Minimo 10 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Latitude: ${controller.formularioServico.trajeto.pontoInicio.latitude}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'Longitude: ${controller.formularioServico.trajeto.pontoInicio.longitude}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelecionarLocalizacaoPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.place),
                    label: Text('Ponto de Inicío'),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Faculdades',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  ...controller.formularioServico.trajeto.faculdades.map(
                    (FormularioServicoTrajetoFaculdadeModel faculdade) =>
                        Column(
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        TextFieldWidget(
                          fieldName: "Nome da Faculdade",
                          controller: faculdade.nome,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome de Título';
                            } else if (value.length < 3) {
                              return 'Minimo 3 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldWidget(
                          fieldName: "Horário de Chegada",
                          controller: faculdade.horarioChegada,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome de Título';
                            } else if (value.length < 5) {
                              return 'Minimo 5 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.place),
                          label: Text('Local da Faculdade'),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Latitude: ${faculdade.localizacao.latitude}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              'Longitude: ${faculdade.localizacao.longitude}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        controller.formularioServico.trajeto.faculdades.add(
                          FormularioServicoTrajetoFaculdadeModel(
                            nome: TextEditingController(),
                            horarioChegada: TextEditingController(),
                            localizacao:
                                FormularioServicoTrajetoFaculdadeLocalizacaoModel(
                              latitude: 0.0,
                              longitude: 0.0,
                            ),
                          ),
                        );
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            widget.servico == null ? Icons.send : Icons.save,
          ),
          onPressed: () async {
            if (widget.servico == null) {
              final bool response = await controller.postar(
                context: context,
              );
              if (response == true) {
                Navigator.pop(
                  context,
                );
              }
            } else {
              final bool response = await controller.editar(
                id: widget.servico!.id!,
                context: context,
              );
              if (response == true) {
                Navigator.pop(
                  context,
                );
              }
            }
          },
        ),
      ),
    );
  }
}
