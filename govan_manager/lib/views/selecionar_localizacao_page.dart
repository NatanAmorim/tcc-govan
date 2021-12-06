import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class SelecionarLocalizacaoPage extends StatefulWidget {
  const SelecionarLocalizacaoPage({Key? key}) : super(key: key);

  @override
  _SelecionarLocalizacaoPageState createState() =>
      _SelecionarLocalizacaoPageState();
}

class _SelecionarLocalizacaoPageState extends State<SelecionarLocalizacaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('goVan - Selecionar local'),
      ),
      body: HereMap(onMapCreated: _onMapViewCreated),
    );
  }

  void _onMapViewCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        print("Map scene not loaded. MapError: " + error.toString());
        return;
      }

      double distanceToEarthInMeters = 8000;
      hereMapController.camera.lookAtPointWithDistance(
        GeoCoordinates(-21.2231767, -50.4430845),
        distanceToEarthInMeters,
      );
    });
  }

  void _searchButtonClicked() {
    // _searchExample?.searchButtonClicked(); //fix
  }

  void _geocodeAnAddressButtonClicked() {
    // _searchExample?.geocodeAnAddressButtonClicked(); //fix
  }

  // A helper method to add a button on top of the HERE map.
  Align button(String buttonLabel, Function callbackFunction) {
    return Align(
      alignment: Alignment.topCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          onPrimary: Colors.white,
        ),
        onPressed: () => callbackFunction(),
        child: Text(buttonLabel, style: TextStyle(fontSize: 20)),
      ),
    );
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
