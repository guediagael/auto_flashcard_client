import 'package:client/bloc/base/base_state.dart';

class LoginStateInitial extends BaseState {
  const LoginStateInitial() : super(const []);
}

class LoginStateLoginNotFound extends BaseState {
  const LoginStateLoginNotFound() : super(const []);
}

class LoginStateLoadingSendingCredentials extends BaseState {
  const LoginStateLoadingSendingCredentials() : super(const []);
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
  final String? emailError;
  final String? passwordError;

  LoginStateFormValidityCheck({this.emailError, this.passwordError})
      : super([passwordError, emailError]);
}
