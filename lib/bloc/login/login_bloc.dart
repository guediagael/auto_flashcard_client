import 'dart:async';

import 'package:client/localization/en_us.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/shared_prefs/data_preferences.dart';
import '../base/base_bloc.dart';
import '../base/base_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc {
  LoginBloc({required super.dataRepository})
      : super(initialState: const LoginStateInitial()) {
    on<LoginEventTriggerCredentialsLogin>(_onLoginEventTriggerCredentials);
    on<LoginEventSendCredentials>(_onLoginEventSendCredentials);
    on<LoginEventTriggerGoogleLogin>(_onLoginEventTriggerGoogle);
    on<LoginEventGoogleSignInSuccess>(_onLoginEventGoogleSignInSuccess);
    on<LoginEventTriggerGoogleSignInFailure>(_onLoginEventGoogleSignInFailure);
    on<LoginEventCheckFormValidity>(_onLoginEventCheckFormValidity);
  }

  _saveCredentials(String? token, LoginType loginType) {
    assert(token != null || loginType == LoginType.guest);
    dataRepository.sharedPreferencesImpl.setLoginType(loginType);
    if (token != null) {
      dataRepository.sharedPreferencesImpl.setToken(token);
    }
  }

  FutureOr<void> _onLoginEventTriggerCredentials(
      LoginEventTriggerCredentialsLogin event, Emitter<BaseState> emit) async {
    emit(const LoginStateLoadingSendingCredentials());
  }

  FutureOr<void> _onLoginEventSendCredentials(
      LoginEventSendCredentials event, Emitter<BaseState> emit) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      if (credential.user != null) {
        emit(const LoginStateLoggedIn());
      } else {
        debugPrint(
            "login_bloc::_onLoginEventSendCredentials>> Login not found");
        emit(const LoginStateLoginNotFound());
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(
          "login_block::_onLoginEventSendCredentials::FirebaseAuthException $e");
      if (e.code == 'account-exists-with-different-credential') {
        emit(LoginStateGoogleCredentialsError(
            errorMessage: accountCreateWithGoogleError));
      } else if (e.code == 'user-not-found') {
        debugPrint('login_bloc::_onLoginEventSendCredentials>> '
            'No user found for that email.');
        emit(const LoginStateLoginNotFound());
      } else if (e.code == 'wrong-password') {
        debugPrint('login_bloc::_onLoginEventSendCredentials>> '
            'Wrong password provided for that user.');
        emit(const LoginStateWrongCredentials());
      } else {
        emit(FirebaseAuthErrorState(e.code));
      }
    }
  }

  FutureOr<void> _onLoginEventTriggerGoogle(
      LoginEventTriggerGoogleLogin event, Emitter<BaseState> emit) async {
    emit(const LoginStateLoadingSendingGoogleCredentials());

  }

  FutureOr<void> _onLoginEventGoogleSignInSuccess(
      LoginEventGoogleSignInSuccess event, Emitter<BaseState> emit) async{
    try {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: event.googleSignInAuthentication.accessToken,
        idToken: event.googleSignInAuthentication.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(const LoginStateLoggedIn());
      } else {
        emit(LoginStateGoogleCredentialsError(
            errorMessage: credentialsNotFound));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(
          "login_block::_onLoginEventTriggerGoogle::FirebaseAuthException $e");
      if (e.code == 'account-exists-with-different-credential') {
        emit(LoginStateGoogleCredentialsError(
            errorMessage: accountCreatedWithPasswordError));
      } else {
        emit(FirebaseAuthErrorState(e.code));
      }
    }
  }

  FutureOr<void> _onLoginEventGoogleSignInFailure(
      LoginEventTriggerGoogleSignInFailure event, Emitter<BaseState> emit) {
    emit(LoginStateGoogleCredentialsError(errorMessage: event.errorMessage));
  }

  FutureOr<void> _onLoginEventCheckFormValidity(
      LoginEventCheckFormValidity event, Emitter<BaseState> emit) {
    String? email = event.email;
    String? password = event.password;
    if (event.email != null &&
        event.email!.trim().length > 6 &&
        event.password != null &&
        event.password!.isNotEmpty) {}
    emit(LoginStateFormValidityCheck(
        emailError: email, passwordError: password));
  }
}
