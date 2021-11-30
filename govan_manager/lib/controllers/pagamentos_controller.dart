import 'package:flutter/cupertino.dart';

class PagamentosController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController formaPagamentoTextEditingController =
      TextEditingController();

  Future<bool> marcarPago({
    required BuildContext context,
  }) async {
    final bool isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    return true;
  }
}
