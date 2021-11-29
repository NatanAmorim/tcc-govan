import 'package:flutter/material.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/models/servico_model.dart';
import 'package:intl/intl.dart';

class PagamentosPage extends StatefulWidget {
  const PagamentosPage({
    Key? key,
    required this.passageiros,
  }) : super(key: key);

  final List<Passageiro> passageiros;

  @override
  _PagamentosPageState createState() => _PagamentosPageState();
}

class _PagamentosPageState extends State<PagamentosPage> {
  final DateFormat format = DateFormat('dd/MM/yyyy');

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
              for (Passageiro item in widget.passageiros)
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       children: <Widget>[
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Icon(
                //               item.isPago! ? Icons.verified : Icons.error,
                //               color: item.isPago! ? Colors.green : Colors.red,
                //             ),
                //             const SizedBox(width: 10),
                //             Text(
                //               item.isPago! ? 'Pago' : 'Em aberto',
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .headline6!
                //                   .copyWith(
                //                     color: item.isPago!
                //                         ? Colors.green
                //                         : Colors.red,
                //                   ),
                //             ),
                //           ],
                //         ),
                //         const SizedBox(height: 10),
                //         Text(
                //           'Data de Vencimento: ${format.format(item.dataVencimento!)}',
                //           style: Theme.of(context).textTheme.bodyText1,
                //         ),
                //         const SizedBox(height: 10),
                //         Text(
                //           'Valor: R\$ ${item.valor!}',
                //           style: Theme.of(context).textTheme.headline6,
                //         ),
                //         Visibility(
                //           visible: item.formaPagamento != null,
                //           child: SizedBox(height: 10),
                //         ),
                //         Visibility(
                //           visible: item.formaPagamento != null,
                //           child: Text(
                //             'Forma de Pagamento: ${item.formaPagamento ?? ''}',
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
