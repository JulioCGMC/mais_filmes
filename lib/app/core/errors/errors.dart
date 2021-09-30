abstract class Failure implements Exception {
  String get message;
}

class GetUserError extends Failure {
  @override final String message;
  GetUserError({this.message = "Erro ao receber usuário"});
}

class LoginError extends Failure {
  @override final String message;
  LoginError({this.message = "Erro ao buscar usuário"});
}

class SignupError extends Failure {
  @override final String message;
  SignupError({this.message = "Erro ao cadastrar usuário"});
}

class ConnectionError extends Failure {
  @override final String message;
  ConnectionError({this.message = "Erro ao conectar-se à internet"});
}

class InternalError implements Failure {
  @override final String message;
  InternalError({this.message = "Erro interno"});
}
