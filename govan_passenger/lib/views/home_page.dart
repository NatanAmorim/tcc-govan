import 'package:flutter/material.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/views/chat_page.dart';
import 'package:govan/views/configuracoes_page.dart';
import 'package:govan/views/explorar_servicos_page.dart';
import 'package:govan/views/minhas_vans_page.dart';

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
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('GoVan'),
            actions: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfiguracoesPage(),
                  ),
                ),
                icon: Icon(
                  Icons.settings,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.logout,
                ),
                onPressed: () =>
                    DialogHelper.showLogoutDialog(context: context),
              ),
            ],
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
          body: TabBarView(
            children: [
              ExplorarServicosPage(),
              MinhasVansPage(),
              ChatPage(username: 'username'),
            ],
          ),
        ),
      ),
    );
  }
}
