import 'package:client/bloc/base/base_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final GoogleSignInAuthentication googleSignInAuthentication;

  LoginEventGoogleSignInSuccess({required this.googleSignInAuthentication})
      : super([googleSignInAuthentication]);
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
