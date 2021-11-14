import 'package:flutter/material.dart';
import 'package:govan/helper/dialog_helper.dart';

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () => DialogHelper.showLogoutDialog(context: context),
            ),
          ],
        ),
      ),
    );
  }
}
