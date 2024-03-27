import 'package:client/bloc/base/base_state.dart';

class RegistrationStateInitial extends BaseState {
  const RegistrationStateInitial() : super(const []);
}

class RegistrationStateEmailAlreadyExists extends BaseState {
  const RegistrationStateEmailAlreadyExists() : super(const []);
}

class RegistrationStateLoadingSendingCredentials extends BaseState {
  const RegistrationStateLoadingSendingCredentials() : super(const []);
}

class RegistrationStateLoadingSendingGoogleCredentials extends BaseState {
  const RegistrationStateLoadingSendingGoogleCredentials() : super(const []);
}

class RegistrationStateRegistered extends BaseState {
  const RegistrationStateRegistered() : super(const []);
}

class RegistrationStateGoogleRegistered extends BaseState {
  final String email, token;

  RegistrationStateGoogleRegistered(
      {required this.email, required this.token})
      : super([email, token]);
}

class RegistrationStateGoogleCredentialsError extends BaseState {
  final String errorMessage;

  RegistrationStateGoogleCredentialsError({required this.errorMessage})
      : super([errorMessage]);
}

class RegistrationStateFormValidityCheck extends BaseState {
  final int? name;
  final int? email;
  final int? password;
  final int? passwordConfirm;

  RegistrationStateFormValidityCheck(
      {this.name, this.email, this.password, this.passwordConfirm})
      : super([name, email, password, passwordConfirm]);
}
