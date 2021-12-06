import 'package:flutter/material.dart';
import 'package:govan/controllers/explorar_servicos_detalhes_controller.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/models/servico_model.dart';
import 'package:hive/hive.dart';

class ExplorarServicoDetalhesPage extends StatefulWidget {
  ExplorarServicoDetalhesPage({
    Key? key,
    required this.servico,
  }) : super(key: key);

  final ServicoModel servico;

  @override
  State<ExplorarServicoDetalhesPage> createState() =>
      _ExplorarServicoDetalhesPageState();
}

class _ExplorarServicoDetalhesPageState
    extends State<ExplorarServicoDetalhesPage> {
  final ExplorarServicosDetalhesController controller =
      ExplorarServicosDetalhesController();

  final Box<dynamic> box = Hive.box('jwt');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Mais detalhes'),
      ),
      body: RawScrollbar(
        radius: Radius.circular(20),
        thumbColor: Colors.orangeAccent.withOpacity(0.5),
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.servico.titulo,
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            widget.servico.descricao,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Preço',
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                widget.servico.valorCobrado,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.green),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Trajeto',
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            widget.servico.trajeto.descricao,
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Contrato',
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => controller.baixarContrato(context),
                            icon: Icon(Icons.download),
                            label: Text('Baixar Contrato'),
                          ),
                          SizedBox(height: 20),
                          Text(
                            widget.servico.contrato.descricao,
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Obrigatório? ' +
                                  (widget.servico.contrato.politicaCancelamento
                                          .isRequerido
                                      ? 'Sim'
                                      : 'Não'),
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Meses mínimo de fidelidade:  ${widget.servico.contrato.politicaCancelamento.mesesMinimo ?? 0}',
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Veículos',
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          ...widget.servico.veiculos.map(
                            (Veiculo veiculo) => Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                Container(
                                  color: Colors.grey,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  constraints: BoxConstraints(maxHeight: 200),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      veiculo.nome,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Cor: ',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      veiculo.cor,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Placa: ',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      veiculo.placa,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: widget.servico.passageiros != null
                      ? !widget.servico.passageiros!.any(
                          (Passageiro passageiro) =>
                              passageiro.pessoaId == box.get('user_id'),
                        )
                      : true,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      primary: Theme.of(context).accentColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      bool response = await controller.contratarVan(
                        context: context,
                        servicoId: widget.servico.id!,
                      );

                      if (response == true) {
                        DialogHelper.showSucessDialog(
                          context: context,
                          description: 'Van Contratada com Sucesso!',
                        );
                      }
                    },
                    icon: Icon(Icons.connect_without_contact),
                    label: Text('Contratar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
