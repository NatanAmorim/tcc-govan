import 'package:flutter/material.dart';
import 'package:govan/models/servico_model.dart';

class ComparecimentoPage extends StatefulWidget {
  const ComparecimentoPage({
    Key? key,
    required this.passageiros,
  }) : super(key: key);

  final List<Passageiro> passageiros;

  @override
  _ComparecimentoPageState createState() => _ComparecimentoPageState();
}

class _ComparecimentoPageState extends State<ComparecimentoPage> {
  List<bool>? qtdPassageiros;
  @override
  Widget build(BuildContext context) {
    if (qtdPassageiros == null) {
      qtdPassageiros = List<bool>.generate(
        widget.passageiros.length,
        (_) => false,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Comparecimento Passageiros'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < widget.passageiros.length; i++)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CheckboxListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text(
                          widget.passageiros[i].pessoaNome,
                        ),
                        value: qtdPassageiros![i],
                        onChanged: (value) {
                          setState(() {
                            qtdPassageiros![i] = !qtdPassageiros![i];
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
