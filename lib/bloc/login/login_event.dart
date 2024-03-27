import 'package:client/bloc/base/base_event.dart';

class LoginEventTriggerCredentialsLogin extends BaseEvent {
  final String email;
  final String password;

  LoginEventTriggerCredentialsLogin(
      {required this.email, required this.password})
      : super([email, password]);
}

class LoginEventSendCredentials extends BaseEvent {
  final String email;
  final String password;

  LoginEventSendCredentials({required this.email, required this.password})
      : super([email, password]);
}

class LoginEventTriggerGoogleLogin extends BaseEvent {
  const LoginEventTriggerGoogleLogin() : super(const []);
}

class LoginEventGoogleSignInSuccess extends BaseEvent {
  final String email;
  final String token;

  LoginEventGoogleSignInSuccess({required this.email, required this.token})
      : super([email, token]);
}

class LoginEventTriggerGoogleSignInFailure extends BaseEvent {
  final String errorMessage;

  LoginEventTriggerGoogleSignInFailure({required this.errorMessage})
      : super([errorMessage]);
}

class LoginEventCheckFormValidity extends BaseEvent {
  final String? email;
  final String? password;

  LoginEventCheckFormValidity({required this.email, required this.password})
      : super([email, password]);
}
