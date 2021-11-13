import 'package:flutter/material.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/views/criar_servico_page.dart';

class MeusServicosPage extends StatelessWidget {
  const MeusServicosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Meus Servços'),
          //   actions: [
          //     IconButton(
          //       icon: const Icon(
          //         Icons.logout,
          //       ),
          //       onPressed: () => DialogHelper.showLogoutDialog(context: context),
          //     ),
          //   ],
          // ),
          // body: Container(),
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.add),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const CriarServicoPage()),
          //   ),
          // ),
          ),
    );
  }
}
