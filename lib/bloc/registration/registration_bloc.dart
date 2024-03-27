import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/base_bloc.dart';
import '../base/base_state.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends BaseBloc {
  RegistrationBloc({required super.dataRepository})
      : super(initialState: const RegistrationStateInitial()) {
    on<RegistrationEventTriggerCredentialRegistration>(
        _onTriggerCredentialRegistration);
    on<RegistrationEventSendCredential>(_onSendCredentialRegistration);
    on<RegistrationEventTriggerGoogleRegistration>(
        _onTriggerGoogleRegistration);
    on<RegistrationEventGoogleRegistrationSuccess>(
        _onGoogleRegistrationSuccess);
    on<RegistrationEventGoogleRegistrationError>(_onGoogleRegistrationError);
    on<RegistrationEventCheckFormValidity>(_onCheckFormValidity);
  }

  FutureOr<void> _onTriggerCredentialRegistration(
      RegistrationEventTriggerCredentialRegistration event,
      Emitter<BaseState> emit) {
    emit(const RegistrationStateLoadingSendingCredentials());
  }

  FutureOr<void> _onSendCredentialRegistration(
      RegistrationEventSendCredential event, Emitter<BaseState> emit) async {
    await Future.delayed(Duration(seconds: 2), () {
      emit(const RegistrationStateRegistered());
    });
  }

  FutureOr<void> _onTriggerGoogleRegistration(
      RegistrationEventTriggerGoogleRegistration event,
      Emitter<BaseState> emit) {
    emit(const RegistrationStateLoadingSendingGoogleCredentials());
  }

  FutureOr<void> _onGoogleRegistrationSuccess(
      RegistrationEventGoogleRegistrationSuccess event,
      Emitter<BaseState> emit) {
    emit(RegistrationStateGoogleRegistered(
        email: event.email, token: event.token));
  }

  FutureOr<void> _onGoogleRegistrationError(
      RegistrationEventGoogleRegistrationError event, Emitter<BaseState> emit) {
    emit(RegistrationStateGoogleCredentialsError(
        errorMessage: 'just something to test'));
  }

  FutureOr<void> _onCheckFormValidity(
      RegistrationEventCheckFormValidity event, Emitter<BaseState> emit) {
    int? nameError;
    if (event.name.trim().isEmpty) {
      nameError = 5001;
    }
    int? passwordError;
    if (event.password.trim().isEmpty) {
      passwordError = 5001;
    }
    int? passwordConfirmError;
    if (event.passwordConfirmation.trim().isEmpty ||
        event.passwordConfirmation != event.password) {
      passwordConfirmError = 5002;
    }
    int? emailError;
    if (event.email.trim().isEmpty) {
      emailError = 5001;
    }
    emit(RegistrationStateFormValidityCheck(
        name: nameError,
        email: emailError,
        password: passwordError,
        passwordConfirm: passwordConfirmError));
  }
}
