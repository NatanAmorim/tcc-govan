import 'package:flutter/material.dart';
import 'package:govan/controllers/explorar_servicos_detalhes_controller.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/chat_page.dart';
import 'package:govan/views/explorar_servicos_detalhes_page.dart';
import 'package:govan/views/mensalidade_page.dart';
import 'package:hive/hive.dart';

class MinhasVansDetalhesPage extends StatelessWidget {
  MinhasVansDetalhesPage({
    Key? key,
    required this.servico,
  }) : super(key: key);

  final ServicoModel servico;
  final ExplorarServicosDetalhesController controller =
      ExplorarServicosDetalhesController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Mais detalhes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () => DialogHelper.showLogoutDialog(context: context),
          ),
        ],
      ),
      body: RawScrollbar(
        radius: Radius.circular(20),
        thumbColor: Colors.orangeAccent.withOpacity(0.5),
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                        icon: Icon(Icons.info_outline),
                        label: Text('Detalhes do Serviço'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExplorarServicoDetalhesPage(
                                servico: servico,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                        icon: Icon(Icons.local_atm),
                        label: Text('Mensalidade'),
                        onPressed: () {
                          final Box<dynamic> box = Hive.box('jwt');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MensalidadePage(
                                mensalidades: servico.passageiros!
                                    .firstWhere(
                                      (Passageiro passageiro) =>
                                          passageiro.pessoaId ==
                                          box.get('user_id'),
                                    )
                                    .mensalidade!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(
                        icon: Icon(Icons.chat_outlined),
                        label: Text('Chat'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChatPage(username: 'username'),
                            ),
                          );
                        },
                      ),
                    ),
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
