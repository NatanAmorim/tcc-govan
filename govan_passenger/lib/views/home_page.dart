import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('GoVan'),
            bottom: const TabBar(
              tabs: <Tab>[
                Tab(
                  text: 'Procurar',
                  icon: Icon(Icons.hail),
                ),
                Tab(
                  text: 'Minhas Vans',
                  icon: Icon(Icons.directions_bus_filled),
                ),
                Tab(
                  text: 'Chat',
                  icon: Icon(Icons.chat),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
