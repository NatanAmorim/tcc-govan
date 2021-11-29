import 'package:flutter/material.dart';
import 'package:govan/helper/dialog_helper.dart';
import 'package:govan/services/app_exception_service.dart';

handleError({
  required error,
  required BuildContext context,
}) {
  if (error is BadRequestException) {
    final String? message = error.message;
    if (message != null) {
      return DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else if (error is FetchDataException) {
    final String? message = error.message;
    if (message != null) {
      DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else if (error is ApiNotRespondingAppException) {
    final String? message = error.message;
    if (message != null) {
      DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else if (error is ForbiddenRequestException) {
    final String? message = error.message;
    if (message != null) {
      DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else if (error is UnAuthorizedException) {
    DialogHelper.showTokenExpiredDialog(
      context: context,
    );
  } else if (error is ErroContratarServico) {
    DialogHelper.showErrorDialog(
      title: 'Erro ao Contratar serviço',
      description: 'Esse serviço Não tem Vagas abertas',
      context: context,
    );
  } else {
    DialogHelper.showTokenExpiredDialog(
      context: context,
    );
  }
}

void handleErrorLogin({
  required dynamic error,
  required BuildContext context,
}) {
  if (error is BadRequestException) {
    final String? message = error.message;
    if (message != null) {
      DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else if (error is FetchDataException) {
    final String? message = error.message;
    if (message != null) {
      DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else if (error is ApiNotRespondingAppException) {
    final String? message = error.message;
    if (message != null) {
      DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else if (error is UnAuthorizedException) {
    DialogHelper.showErrorDialog(
      context: context,
      description: 'E-mail e/ou Senha incorreto(s)!',
    );
  } else if (error is ForbiddenRequestException) {
    final String? message = error.message;
    if (message != null) {
      DialogHelper.showErrorDialog(
        description: message,
        context: context,
      );
    }
    DialogHelper.showErrorDialog(
      context: context,
    );
  } else {
    DialogHelper.showErrorDialog(
      context: context,
    );
  }
}
