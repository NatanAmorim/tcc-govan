class AppException implements Exception {
  AppException([
    this.message,
    this.prefix,
  ]);

  final String? message;
  final String? prefix;
}

class BadRequestException extends AppException {
  BadRequestException({
    required String message,
  }) : super(message, 'Requisição inválida: ');
}

class FetchDataException extends AppException {
  FetchDataException({
    required String message,
  }) : super(message, 'Erro Durante a comunicação: ');
}

class ApiNotRespondingAppException extends AppException {
  ApiNotRespondingAppException({
    required String message,
  }) : super(message, 'Servidor não respondeu dentro do tempo limite: ');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException({
    required String message,
  }) : super(message, 'Sua sessão expirou');
}

class ForbiddenRequestException extends AppException {
  ForbiddenRequestException({
    required String message,
  }) : super(message, 'Acesso Negado');
}

class ConflictException extends AppException {
  ConflictException({
    required String message,
  }) : super(message, 'Requisição, conflita com registro já cadastrado.');
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException({
    required String message,
  }) : super(message, 'Erro do servidor');
}

class ErroContratarServico extends AppException {
  ErroContratarServico({
    required String message,
  }) : super(message, 'Erro do servidor');
}
