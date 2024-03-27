import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    emit(LoginStateLoadingSendingCredentials());
  }

  FutureOr<void> _onLoginEventSendCredentials(
      LoginEventSendCredentials event, Emitter<BaseState> emit) async {
    await Future.delayed(Duration(seconds: 2), () {
      emit(LoginStateLoginNotFound());
    });
    // _saveCredentials(null, LoginType.email);
  }

  FutureOr<void> _onLoginEventTriggerGoogle(
      LoginEventTriggerGoogleLogin event, Emitter<BaseState> emit) {
    emit(const LoginStateLoadingSendingGoogleCredentials());
  }

  FutureOr<void> _onLoginEventGoogleSignInSuccess(
      LoginEventGoogleSignInSuccess event, Emitter<BaseState> emit) {
    // _saveCredentials(null, LoginType.google);
    emit(const LoginStateLoggedIn());
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
