import 'package:flutter/material.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/chat_page.dart';
import 'package:govan/views/comparecimento_page.dart';
import 'package:govan/views/criar_servico_page.dart';
import 'package:govan/views/detalhes_servico_page.dart';
import 'package:govan/views/pagamentos_page.dart';

class MaisOpcoesServicoPage extends StatelessWidget {
  MaisOpcoesServicoPage({
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
        title: Text('Meu Serviço'),
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
                        icon: Icon(Icons.place_outlined),
                        label: Text('Iniciar Rota'),
                        onPressed: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Renomear(
                          //         servico: servico,
                          //       ),
                          //     ),
                          //   );
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
                        icon: Icon(Icons.fact_check_outlined),
                        label: Text('Comparecimento'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComparecimentoPage(
                                passageiros: servico.passageiros!,
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
                        label: Text('Pagamentos'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagamentosPage(
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
                        icon: Icon(Icons.info_outline),
                        label: Text('Detalhes do Serviço'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesServicoPage(
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
                        icon: Icon(Icons.edit_outlined),
                        label: Text('Editar Serviço'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CriarServicoPage(
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
