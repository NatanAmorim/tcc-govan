import 'package:flutter/material.dart';
import 'package:govan/controllers/servico_controller.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/configuracoes_page.dart';
import 'package:govan/views/explorar_servicos_detalhes.dart';

class ExplorarServicosPage extends StatelessWidget {
  const ExplorarServicosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServicoController controller = ServicoController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Meus Servços'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () => DialogHelper.showLogoutDialog(context: context),
            ),
            IconButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfiguracoesPage()),
                    ),
                icon: Icon(
                  Icons.settings,
                )),
          ],
        ),
        body: FutureBuilder<ServicosModel>(
          future: controller.fetchServicos(context: context),
          builder: (
            BuildContext context,
            AsyncSnapshot<ServicosModel> snapshot,
          ) {
            if (snapshot.hasData) {
              controller.servicos = snapshot.data!;
              if (controller.servicos!.servicos!.length != 0) {
                return GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    for (var servico in controller.servicos!.servicos!)
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExplorarServicoDetalhesPage(
                                    servico: servico,
                                  )),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                Text(servico.titulo),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                );
              } else {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Você não oferece serviços'),
                    ),
                  ),
                ));
              }
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.error,
                      size: 96,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Erro ao obter os dados.\nPor favor, tente novamente.',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
