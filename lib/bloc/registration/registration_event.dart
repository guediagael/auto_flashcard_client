import 'package:client/bloc/base/base_event.dart';

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
  final String? name;
  final String email;
  final String accessToken;
  final String idToken;

  RegistrationEventGoogleRegistrationSuccess(
      {required this.name,
      required this.email,
      required this.accessToken,
      required this.idToken})
      : super([name, email, accessToken, idToken]);
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
