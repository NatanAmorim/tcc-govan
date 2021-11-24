import 'package:flutter/material.dart';
import 'package:govan/controllers/servico_controller.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/explorar_servicos_detalhes.dart';

class MinhasVansPage extends StatefulWidget {
  const MinhasVansPage({Key? key}) : super(key: key);

  @override
  _MinhasVansPageState createState() => _MinhasVansPageState();
}

class _MinhasVansPageState extends State<MinhasVansPage> {
  @override
  Widget build(BuildContext context) {
    final ServicoController controller = ServicoController();
    return FutureBuilder<ServicosModel>(
      future: controller.fetchMeusServicos(context: context),
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
                          //TODO: mudar para meus serviçosDetalhe
                          builder: (context) => ExplorarServicoDetalhesPage(
                                servico: servico,
                              )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  servico.titulo,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
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
                  child: Text('Você não tem vans'),
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
    );
  }
}
