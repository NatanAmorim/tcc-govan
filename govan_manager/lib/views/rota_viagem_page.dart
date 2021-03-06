import 'package:flutter/material.dart';
import 'package:govan/views/routing_example.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class RotaViagemPage extends StatefulWidget {
  const RotaViagemPage({
    Key? key,
    required this.startGeoCoordinates,
    required this.destinationGeoCoordinates,
  }) : super(key: key);

  final GeoCoordinates startGeoCoordinates;
  final GeoCoordinates destinationGeoCoordinates;

  @override
  _RotaViagemPageState createState() => _RotaViagemPageState();
}

class _RotaViagemPageState extends State<RotaViagemPage> {
  RoutingExample? _routingExample;

  @override
  void initState() {
    super.initState();
    _routingExample?.addRoute(
      widget.startGeoCoordinates,
      widget.destinationGeoCoordinates,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('goVan - Rota Viagem'),
        ),
        body: HereMap(onMapCreated: _onMapCreated),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigation),
          tooltip: "Iniciar Navegação",
          onPressed: _addRouteButtonClicked,
        ),
      ),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.setWatermarkPosition(WatermarkPlacement.bottomLeft, 1);
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error == null) {
        _routingExample = RoutingExample(_showDialog, hereMapController);
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });
  }

  void _addRouteButtonClicked() {
    _routingExample?.addRoute(
      widget.startGeoCoordinates,
      widget.destinationGeoCoordinates,
    );
  }

  void _clearMapButtonClicked() {
    _routingExample?.clearMap();
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
