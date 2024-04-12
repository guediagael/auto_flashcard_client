import 'package:client/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bloc/base/base_bloc_builder.dart';
import '../bloc/base/base_bloc_listener.dart';
import '../bloc/registration/registration_bloc.dart';
import '../bloc/registration/registration_event.dart';
import '../bloc/registration/registration_state.dart';
import '../constants/assets.dart';
import '../core/errors/exceptions.dart';
import '../data/data_repository.dart';
import '../localization/en_us.dart';
import '../utils/messenger.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_elevated_button.dart';
import 'login_form_screen.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationFormScreenState();

  static Widget buildRegistrationFormScreen({Key? key}) {
    return BlocProvider(
      create: (ctx) => RegistrationBloc(
        dataRepository: ctx.read<DataRepository>(),
      ),
      child: RegistrationFormScreen(
        key: key,
      ),
    );
  }
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _passwordConfirmController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    String? nameError, emailError, passwordError, passwordConfirmError;
    bool sendingCredentials = false;
    final registrationBloc = context.read<RegistrationBloc>();
    return BaseBlocListener(
      bloc: registrationBloc,
      messenger: Messenger(context),
      listener: (listenerCtx, listenerState) {
        nameError = null;
        emailError = null;
        passwordError = null;
        passwordConfirmError = null;
        sendingCredentials = false;

        if (listenerState is RegistrationStatePasswordTooWeakError) {
          ClientException(
              message: passwordTooWeakError.tr(context), context: listenerCtx);
        } else if (listenerState is RegistrationStateGoogleAuthError) {
          ClientException(
              message: listenerState.error.code, context: listenerCtx);
        } else if (listenerState is RegistrationStateEmailAlreadyExists) {
          ClientException(
              message: duplicateAccount.tr(context), context: listenerCtx);
        } else if (listenerState
            is RegistrationStateLoadingSendingCredentials) {
          sendingCredentials = true;
          registrationBloc.add(RegistrationEventSendCredential(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              passwordConfirmation: _passwordController.text));
        } else if (listenerState
            is RegistrationStateLoadingSendingGoogleCredentials) {
          sendingCredentials = true;
          // Trigger the authentication flow
          GoogleSignIn().signIn().then((googleUser) {
            if (googleUser != null) {
              // Obtain the auth details from the request
              googleUser.authentication.then((googleAuth) {
                if (googleAuth.idToken != null &&
                    googleAuth.accessToken != null) {
                  registrationBloc.add(
                      RegistrationEventGoogleRegistrationSuccess(
                          googleAuth: googleAuth));
                } else {
                  registrationBloc.add(RegistrationEventGoogleRegistrationError(
                      errorMessage: noTokenFromGoogleError.tr(context)));
                }
              });
            } else {
              registrationBloc.add(RegistrationEventGoogleRegistrationError(
                  errorMessage: noGoogleUserError.tr(context)));
            }
          });
        } else if (listenerState is RegistrationStateRegistered) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (ctx) => LoginFormScreen
                      .buildLoginFormScreenAfterPasswordRegistration(
                          email: _emailController.text,
                          token: _passwordController.text)),
              (route) => false);
        } else if (listenerState is RegistrationStateGoogleRegistered) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (ctx) => LoginFormScreen
                          .buildLoginFormScreenAfterGoogleRegistration(
                        userCredential: listenerState.userCredential,
                      )),
              (route) => false);
        } else if (listenerState is RegistrationStateGoogleCredentialsError) {
          ClientException(
              message: listenerState.errorMessage, context: listenerCtx);
        } else if (listenerState is RegistrationStateFormValidityCheck) {
          bool valid = true;
          if (listenerState.email != null) {
            emailError = listenerState.email.toString().tr(listenerCtx);
            valid = false;
          }
          if (listenerState.name != null) {
            nameError = listenerState.name.toString().tr(listenerCtx);
            valid = false;
          }
          if (listenerState.password != null) {
            passwordError = listenerState.password.toString().tr(listenerCtx);
            valid = false;
          }
          if (listenerState.passwordConfirm != null) {
            passwordConfirmError =
                listenerState.passwordConfirm.toString().tr(context);
            valid = false;
          }

          if (valid) {
            registrationBloc
                .add(const RegistrationEventTriggerCredentialRegistration());
          }
        }
      },
      child: BaseBlocBuilder(
        bloc: registrationBloc,
        builder: (builderCtx, builderState) {
          return Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(16)),
                width: getProportionateScreenWidth(144),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Email field
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(24)),
                          child: Text(
                            registrationTxt.tr(context),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(24)),
                          child: TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: nameTxt.tr(context),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return namePrompt.tr(context);
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(24)),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: emailTxt.tr(context),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return emailPrompt.tr(context);
                              }
                              return null;
                            },
                          ),
                        ),
                        // Add spacing between fields

                        // Password field
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(24)),
                          child: TextFormField(
                            controller: _passwordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            // Hide password characters
                            decoration: InputDecoration(
                              labelText: passwordTxt.tr(context),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return passwordPrompt.tr(context);
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(24)),
                          child: TextFormField(
                            controller: _passwordConfirmController,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            // Hide password characters
                            decoration: InputDecoration(
                              labelText: passwordConfirmationTxt.tr(context),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return passwordConfirmationPrompt.tr(context);
                              }
                              return null;
                            },
                          ),
                        ),
                        // Add spacing before button

                        // Login button
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(24)),
                          child: CustomElevatedButton(
                            loading: sendingCredentials,
                            onPressed: (emailError != null ||
                                    passwordError != null ||
                                    nameError != null ||
                                    passwordConfirmError != null)
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      debugPrint(
                                          'Name: ${_nameController.text}');
                                      debugPrint(
                                          'Email: ${_emailController.text}');
                                      debugPrint(
                                          'Password: ${_passwordController.text}');
                                      debugPrint(
                                          'PasswordConfirm: ${_passwordConfirmController.text}');
                                      registrationBloc.add(
                                          RegistrationEventCheckFormValidity(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              passwordConfirmation:
                                                  _passwordConfirmController
                                                      .text));
                                    }
                                  },
                            text: registerButton.tr(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(24)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                socialRegistrationPrompt.tr(context),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(12))),
                              InkWell(
                                onTap: sendingCredentials
                                    ? null
                                    : () {
                                        registrationBloc.add(
                                            const RegistrationEventTriggerGoogleRegistration());
                                      },
                                child: Image.asset(googleAuthButton),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(12)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(existingAccountPrompt.tr(context)),
                                InkWell(
                                  onTap: sendingCredentials
                                      ? null
                                      : () {
                                          Navigator.of(builderCtx)
                                              .pushReplacement(MaterialPageRoute(
                                                  builder: (ctx) => LoginFormScreen
                                                      .buildLoginFormScreen()));
                                        },
                                  child: Text(
                                    loginTxt.tr(context),
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
