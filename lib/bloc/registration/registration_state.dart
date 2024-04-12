import 'package:client/bloc/base/base_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final String email, name;

  RegistrationStateRegistered({required this.email, required this.name})
      : super([email, name]);
}

class RegistrationStateGoogleRegistered extends BaseState {
  final String email, token;

  RegistrationStateGoogleRegistered({required this.email, required this.token})
      : super([email, token]);
}

class RegistrationStateGoogleCredentialsError extends BaseState {
  final String errorMessage;

  RegistrationStateGoogleCredentialsError({required this.errorMessage})
      : super([errorMessage]);
}

class RegistrationStatePasswordTooWeakError extends BaseState {
  const RegistrationStatePasswordTooWeakError() : super(const []);
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

class RegistrationStateGoogleAuthError extends BaseState {
  final FirebaseAuthException error;

  RegistrationStateGoogleAuthError({required this.error}) : super([error]);
}
