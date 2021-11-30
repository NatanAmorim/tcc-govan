import 'package:flutter/material.dart';
import 'package:govan/controllers/pagamentos_controller.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/models/servico_model.dart';
import 'package:govan/views/meus_servicos_page.dart';
import 'package:intl/intl.dart';

class PagamentosPage extends StatefulWidget {
  PagamentosPage({
    Key? key,
    required this.servico,
  }) : super(key: key);

  final ServicoModel servico;

  @override
  _PagamentosPageState createState() => _PagamentosPageState();
}

class _PagamentosPageState extends State<PagamentosPage> {
  final DateFormat format = DateFormat('dd/MM/yyyy');
  final PagamentosController controller = PagamentosController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Pagamentos'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () => DialogHelper.showLogoutDialog(context: context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              for (Passageiro passageiro in widget.servico.passageiros!)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: Text(passageiro.pessoaNome!),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              for (Mensalidade item in passageiro.mensalidade!)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            item.isPago!
                                                ? Icons.verified
                                                : Icons.error,
                                            color: item.isPago!
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            item.isPago! ? 'Pago' : 'Em aberto',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  color: item.isPago!
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Data de Vencimento: ${format.format(item.dataVencimento!)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Valor: R\$ ${item.valor!}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Visibility(
                                        visible: !item.isPago!,
                                        child: SizedBox(height: 10),
                                      ),
                                      Visibility(
                                        visible: item.formaPagamento != null,
                                        child: Text(
                                          'Forma de Pagamento: ${item.formaPagamento ?? ''}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Visibility(
                                        visible: !item.isPago!,
                                        child: Center(
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              primary: Colors.green[500],
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 5),
                                              textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      'Digite a forma de Pagamento'),
                                                  content: Form(
                                                    key: controller.formKey,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Digite a Forma de Pagamento';
                                                        } else if (value
                                                                .length <
                                                            4) {
                                                          return 'Mínimo 4 caracteres';
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            "Forma de Pagamento",
                                                      ),
                                                      autofocus: true,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancelar'),
                                                      child: const Text(
                                                          'Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(
                                                          context,
                                                          'OK',
                                                        );
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                MeusServicosPage(),
                                                          ),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false,
                                                        );
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                              // TODO: marcar como pago
                                            },
                                            icon: Icon(Icons.monetization_on),
                                            label: Text('Marcar como Pago'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Divider(
                                        color: Theme.of(context).accentColor,
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
