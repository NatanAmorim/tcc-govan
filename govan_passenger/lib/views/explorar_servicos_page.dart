import 'package:flutter/material.dart';
import 'package:govan/controllers/servico_controller.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/explorar_servicos_detalhes.dart';

class ExplorarServicosPage extends StatefulWidget {
  ExplorarServicosPage({Key? key}) : super(key: key);

  @override
  State<ExplorarServicosPage> createState() => _ExplorarServicosPageState();
}

class _ExplorarServicosPageState extends State<ExplorarServicosPage> {
  final TextEditingController searchTextEditingController =
      TextEditingController();

  final ServicoController controller = ServicoController();

  void clearSearchText() => searchTextEditingController.clear();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ServicosModel>(
      future: searchTextEditingController.text.isEmpty
          ? controller.fetchServicos(context: context)
          : controller.fetchServicosSearch(
              input: searchTextEditingController.text,
              context: context,
            ),
      builder: (
        BuildContext context,
        AsyncSnapshot<ServicosModel> snapshot,
      ) {
        if (snapshot.hasData) {
          controller.servicos = snapshot.data!;
          if (controller.servicos!.servicos!.length != 0) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: MediaQuery.of(context).size.width / 6,
                        ),
                        child: TextField(
                          controller: searchTextEditingController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            hintText: 'Pesquisar',
                            counterText: '',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            suffixIcon: Tooltip(
                              message: 'Limpar Pesquisa',
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.grey[600],
                                ),
                                onPressed: clearSearchText,
                              ),
                            ),
                          ),
                          maxLength: 30,
                          cursorColor: Theme.of(context).accentColor,
                          onChanged: (String input) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExplorarServicoDetalhesPage(
                              servico: controller.servicos!.servicos![index],
                            ),
                          ),
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
                                      controller
                                          .servicos!.servicos![index].titulo,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.servicos!.servicos!.length,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: MediaQuery.of(context).size.width / 6,
                  ),
                  child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      hintText: 'Pesquisar',
                      counterText: '',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      suffixIcon: Tooltip(
                        message: 'Limpar Pesquisa',
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.grey[600],
                          ),
                          onPressed: clearSearchText,
                        ),
                      ),
                    ),
                    maxLength: 30,
                    cursorColor: Theme.of(context).accentColor,
                    onChanged: (String input) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Nenhum serviço encontrado'),
                    ),
                  ),
                ),
              ],
            );
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
