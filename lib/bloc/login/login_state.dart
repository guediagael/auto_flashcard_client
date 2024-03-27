import 'package:client/bloc/base/base_state.dart';

class LoginStateInitial extends BaseState {
  const LoginStateInitial() : super(const []);
}

class LoginStateLoginNotFound extends BaseState {
  final String email;
  final String password;

  LoginStateLoginNotFound({required this.email, required this.password})
      : super([email, password]);
}

class LoginStateLoadingSendingCredentials extends BaseState {
  final String email;
  final String password;

  LoginStateLoadingSendingCredentials(
      {required this.email, required this.password})
      : super([email, password]);
}

class LoginStateLoadingSendingGoogleCredentials extends BaseState {
  const LoginStateLoadingSendingGoogleCredentials() : super(const []);
}

class LoginStateLoggedIn extends BaseState {
  const LoginStateLoggedIn() : super(const []);
}

class LoginStateGoogleCredentialsError extends BaseState {
  final String errorMessage;

  LoginStateGoogleCredentialsError({required this.errorMessage})
      : super([errorMessage]);
}

class LoginStateFormValidityCheck extends BaseState {
  final String? email;
  final String? password;
  final String? emailError;
  final String? passwordError;

  LoginStateFormValidityCheck(
      {required this.email,
      required this.password,
      this.emailError,
      this.passwordError})
      : super([email, password, passwordError, emailError]);
}
