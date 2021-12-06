import 'package:flutter/material.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/search_example.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

import 'gestures_example.dart';

class SelecionarLocalizacaoPage extends StatefulWidget {
  const SelecionarLocalizacaoPage({Key? key}) : super(key: key);

  @override
  _SelecionarLocalizacaoPageState createState() =>
      _SelecionarLocalizacaoPageState();
}

class _SelecionarLocalizacaoPageState extends State<SelecionarLocalizacaoPage> {
  SearchExample? _searchExample;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('goVan - Selecionar local'),
        ),
        body: HereMap(onMapCreated: _onMapViewCreated),
      ),
    );
  }

  void _onMapViewCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error == null) {
        GesturesExample(_showDialog, context, hereMapController);
      } else {
        print("Erro ao iniciar o mapa. MapError: " + error.toString());
      }
    });
  }

  // A helper method to show a dialog.
  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
