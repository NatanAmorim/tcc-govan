import 'package:flutter/material.dart';
import 'package:govan/models/servico_model.dart';

class DetalhesServicoPage extends StatelessWidget {
  DetalhesServicoPage({
    Key? key,
    required this.servico,
  }) : super(key: key);

  ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(servico.titulo),
      ),
      body: Center(
        child: Text(servico.descricao),
      ),
    ));
  }
}
