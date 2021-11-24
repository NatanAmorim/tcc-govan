import 'package:flutter/material.dart';
import 'package:govan/models/servico_model.dart';

class ExplorarServicoDetalhesPage extends StatelessWidget {
  ExplorarServicoDetalhesPage({
    Key? key,
    required this.servico,
  }) : super(key: key);

  final ServicoModel servico;

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
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    servico.titulo,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  servico.descricao,
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
                      servico.trajeto.valorCobrado,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.green),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                  servico.trajeto.descricao,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
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
                    primary: Theme.of(context).accentColor,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.download),
                  label: Text('Baixar Contrato'),
                ),
                SizedBox(height: 20),
                Text(
                  servico.contrato.descricao,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Obrigatório? ' +
                        (servico.contrato.politicaCancelamento.isRequerido
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
                    'Meses mínimo de fidelidade:  ${servico.contrato.politicaCancelamento.mesesMinimo ?? 0}',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Veículos',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                  ),
                ),
                ...servico.veiculos.map(
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
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Cor: ',
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            veiculo.cor,
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Placa: ',
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            veiculo.placa,
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    primary: Theme.of(context).accentColor,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.connect_without_contact),
                  label: Text('Contratar'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
