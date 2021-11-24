import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:govan/controllers/criar_servico_controller.dart';
import 'package:govan/models/formulario_servico_model.dart';
import 'package:govan/widgets/integer_field.dart';
import 'package:govan/widgets/text_field.dart';

class CriarServicoPage extends StatefulWidget {
  const CriarServicoPage({Key? key}) : super(key: key);

  @override
  _CriarServicoPageState createState() => _CriarServicoPageState();
}

class _CriarServicoPageState extends State<CriarServicoPage> {
  final CriarServicoController controller = CriarServicoController();

  @override
  void initState() {
    super.initState();
    controller.formularioServico = FormularioServicoModel(
      titulo: TextEditingController(),
      descricao: TextEditingController(),
      vagasDisponiveis: TextEditingController(),
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
        pontoInicio: TextEditingController(),
        pontoFim: TextEditingController(),
        valorCobrado: MoneyMaskedTextController(
            decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$'),
        faculdades: <FormularioServicoTrajetoFaculdadeModel>[
          FormularioServicoTrajetoFaculdadeModel(
            nome: TextEditingController(),
            horarioChegada: TextEditingController(),
          )
        ],
      ),
    );
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
                  IntegerFieldWidget(
                    fieldName: "Números de Vagas",
                    controller: controller.formularioServico.vagasDisponiveis,
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
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.upload),
                    label: Text('Enviar PDF Contrato'),
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
                  Row(
                    children: [
                      Text('Contrato Obrigatório?'),
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
                  Text('Veículos'),
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
                  TextFieldWidget(
                    fieldName: "Ponto de Inicío",
                    controller:
                        controller.formularioServico.trajeto.pontoInicio,
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
                    fieldName: "Ponto de Chegada",
                    controller: controller.formularioServico.trajeto.pontoFim,
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
                    fieldName: "Valor Cobrado", //FIX colocar teclado númerico
                    controller:
                        controller.formularioServico.trajeto.valorCobrado,
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
                  Text('Faculdades'),
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
                          fieldName:
                              "Horário de Chegada", //FIX colocar Calendario
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
          child: const Icon(
            Icons.send,
          ),
          onPressed: () async {
            final bool response = await controller.postar(
              context: context,
            );
            if (response == true) {
              Navigator.pop(
                context,
              );
            }
          },
        ),
      ),
    );
  }
}
