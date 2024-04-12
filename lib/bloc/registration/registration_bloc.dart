import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    dataRepository.logout();
  }

  FutureOr<void> _onSendCredentialRegistration(
      RegistrationEventSendCredential event, Emitter<BaseState> emit) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (credential.user != null) {
        emit(RegistrationStateRegistered(
            email: event.email,
            name: credential.user?.displayName ??
                credential.additionalUserInfo?.username ??
                ""));
      } else {
        emit(RegistrationStateGoogleCredentialsError(errorMessage: '500'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const RegistrationStatePasswordTooWeakError());
      } else if (e.code == 'email-already-in-use') {
        emit(const RegistrationStateEmailAlreadyExists());
      }
    } catch (e) {
      emit(RegistrationStateGoogleCredentialsError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onTriggerGoogleRegistration(
      RegistrationEventTriggerGoogleRegistration event,
      Emitter<BaseState> emit) async {
    emit(const RegistrationStateLoadingSendingGoogleCredentials());
    await dataRepository.logout();
  }

  FutureOr<void> _onGoogleRegistrationSuccess(
      RegistrationEventGoogleRegistrationSuccess event,
      Emitter<BaseState> emit) async {
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: event.googleAuth.accessToken,
      idToken: event.googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential googleAuth =
        await FirebaseAuth.instance.signInWithCredential(credential);

    emit(RegistrationStateGoogleRegistered(userCredential: googleAuth));
  }

  FutureOr<void> _onGoogleRegistrationError(
      RegistrationEventGoogleRegistrationError event, Emitter<BaseState> emit) {
    emit(RegistrationStateGoogleCredentialsError(
        errorMessage: event.errorMessage));
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
