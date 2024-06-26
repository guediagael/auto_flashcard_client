import 'package:client/bloc/base/base_event.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistrationEventTriggerCredentialRegistration extends BaseEvent {
  const RegistrationEventTriggerCredentialRegistration() : super(const []);
}

class RegistrationEventSendCredential extends BaseEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegistrationEventSendCredential(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirmation})
      : super([name, email, password, passwordConfirmation]);
}

class RegistrationEventTriggerGoogleRegistration extends BaseEvent {
  const RegistrationEventTriggerGoogleRegistration() : super(const []);
}

class RegistrationEventGoogleRegistrationSuccess extends BaseEvent {
  final GoogleSignInAuthentication googleAuth;

  RegistrationEventGoogleRegistrationSuccess(
      {required this.googleAuth})
      : super([googleAuth]);
}

class RegistrationEventGoogleRegistrationError extends BaseEvent {
  final String errorMessage;

  RegistrationEventGoogleRegistrationError({required this.errorMessage})
      : super([errorMessage]);
}

class RegistrationEventCheckFormValidity extends BaseEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegistrationEventCheckFormValidity(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirmation})
      : super([name, email, password, passwordConfirmation]);
}
