import 'package:flutter/material.dart';
import 'package:govan/views/home_page.dart';
import 'package:govan/views/login_page.dart';

import 'package:hive_flutter/hive_flutter.dart';

class DialogHelper {
  static void showSucessDialog({
    required BuildContext context,
    required String description,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text('Tudo Certo!'),
            Icon(
              Icons.check,
              color: Colors.green,
              size: 48,
            ),
          ],
        ),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Confirmar');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  static void showConfirmDialog({
    required BuildContext context,
    required VoidCallback voidCallback,
    String title = 'Confirmar envio.',
    String description = 'Tem Certeza?',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              () => voidCallback;
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  static void showErrorDialog({
    required BuildContext context,
    String title = 'Erro',
    String description = 'Erro ao obter os dados. Por favor, tente novamente.',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(title),
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
          ],
        ),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showLogoutDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text('Sair'),
            Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
          ],
        ),
        content: const Text('Tem certeza?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final Box<dynamic> box = Hive.box('jwt');
              box.delete('token');

              Navigator.pop(context, 'Sair');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  static void showTokenExpiredDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              'Impossível confirmar a identidade',
            ),
            Icon(
              Icons.person_off_outlined,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
          ],
        ),
        content: const Text(
          'A sua autenticação expírou, para continuar usando, '
          'por favor faça o login novamente.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              final Box<dynamic> box = Hive.box('jwt');
              box.delete('token');

              Navigator.pop(context, 'OK');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
