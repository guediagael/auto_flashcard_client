import 'package:client/app_localization.dart';
import 'package:client/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bloc/base/base_bloc_builder.dart';
import '../bloc/base/base_bloc_listener.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../constants/assets.dart';
import '../core/errors/exceptions.dart';
import '../data/data_repository.dart';
import '../data/shared_prefs/data_preferences.dart';
import '../localization/en_us.dart';
import '../utils/messenger.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_elevated_button.dart';
import 'home_screen.dart';

class LoginFormScreen extends StatefulWidget {
  static String routeName = "login";

  final String? initialEmail, initialPassword;
  final UserCredential? userCredential;

  LoginType? initialLoginType;

  LoginFormScreen(
      {super.key,
      this.initialEmail,
      this.initialPassword,
      this.userCredential}) {
    if (userCredential != null) {
      initialLoginType = LoginType.google;
    } else if (initialPassword != null) {
      initialLoginType = LoginType.email;
    } else {}
    initialLoginType = null;
  }

  @override
  State<LoginFormScreen> createState() => _LoginFormState();

  static Widget buildLoginFormScreen(
      {Key? key,
      String? email,
      String? token,
      UserCredential? userCredential,}) {
    return BlocProvider(
      create: (ctx) => LoginBloc(dataRepository: ctx.read<DataRepository>()),
      child: LoginFormScreen(
          key: key,
          initialEmail: email,
          initialPassword: token,
          userCredential: userCredential),
    );
  }

  static Widget buildLoginFormScreenAfterPasswordRegistration(
      {Key? key, required String email, required String token}) {
    return buildLoginFormScreen(key: key, email: email, token: token);
  }

  static Widget buildLoginFormScreenAfterGoogleRegistration(
      {Key? key, required UserCredential userCredential}) {
    return buildLoginFormScreen(key: key, userCredential: userCredential);
  }
}

class _LoginFormState extends State<LoginFormScreen> {
  late final GlobalKey<FormState> _formKey; // Key for form validation
  late final TextEditingController _emailController,
      _passwordController; // Controller for password field

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    if (widget.initialEmail != null) {
      _emailController.text = widget.initialEmail!;
      _passwordController.text = widget.initialPassword!;
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint(
          "login_form_screen::initState::addPostFrameCallback:: loginType ${widget.initialLoginType}");
      if (widget.initialLoginType == LoginType.email) {
        context.read<LoginBloc>().add(LoginEventSendCredentials(
            email: widget.initialEmail!, password: widget.initialPassword!));
      } else if(widget.initialLoginType == LoginType.google) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => HomeScreen.buildHomeScreen()),
            (route) => false);
      }
      super.didChangeDependencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    String? emailError, passwordError;
    bool sendingCredentials = false;
    final loginBloc = context.read<LoginBloc>();

    return BaseBlocListener(
      bloc: loginBloc,
      messenger: Messenger(context),
      listener: (listenerCtx, listenerState) {
        emailError = null;
        passwordError = null;
        sendingCredentials = false;
        if (listenerState is LoginStateWrongCredentials) {
          ClientException(
              message: credentialsNotFound.tr(context), context: listenerCtx);
        } else if (listenerState is LoginStateLoginNotFound) {
          ScaffoldMessenger.of(listenerCtx).showSnackBar(
              SnackBar(content: Text(credentialsNotFound.tr(listenerCtx))));
        } else if (listenerState is LoginStateLoadingSendingCredentials) {
          sendingCredentials = true;
          loginBloc.add(LoginEventSendCredentials(
              email: _emailController.text,
              password: _passwordController.text));
        } else if (listenerState is LoginStateLoadingSendingGoogleCredentials) {
          sendingCredentials = true;
          GoogleSignIn().signIn().then((googleUser) {
            if (googleUser != null) {
              // Obtain the auth details from the request
              googleUser.authentication.then((googleAuth) {
                loginBloc.add(LoginEventGoogleSignInSuccess(
                    googleSignInAuthentication: googleAuth));
              });
            }
          });
        } else if (listenerState is LoginStateLoggedIn) {
          Navigator.of(listenerCtx).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HomeScreen.buildHomeScreen()),
              (route) => false);
        } else if (listenerState is LoginStateGoogleCredentialsError) {
          ClientException(
              message: listenerState.errorMessage.tr(context),
              context: listenerCtx);
        } else if (listenerState is LoginStateFormValidityCheck) {
          emailError = listenerState.emailError;
          passwordError = listenerState.passwordError;
        }
      },
      child: BaseBlocBuilder(
          bloc: loginBloc,
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
                          const FlutterLogo(
                            size: 96,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(24)),
                            child: Text(
                              loginTxt.tr(context),
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
                              controller: _emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onEditingComplete: () {
                                loginBloc.add(LoginEventCheckFormValidity(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: emailTxt.tr(context),
                                border: OutlineInputBorder(),
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
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              // Hid
                              onEditingComplete: () {
                                loginBloc.add(LoginEventCheckFormValidity(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              },
                              // e password characters
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
                          // Add spacing before button

                          // Login button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(24)),
                            child: CustomElevatedButton(
                              loading: sendingCredentials,
                              onPressed: (emailError != null ||
                                      passwordError != null)
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        // Handle login logic here (e.g., call API)
                                        debugPrint(
                                            'Email: ${_emailController.text}');
                                        debugPrint(
                                            'Password: ${_passwordController.text}');
                                        loginBloc.add(
                                            LoginEventTriggerCredentialsLogin(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text));
                                      }
                                    },
                              text: loginButton.tr(context),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(24)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  socialLoginPrompt.tr(context),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(12))),
                                InkWell(
                                  onTap: sendingCredentials
                                      ? null
                                      : () {
                                          loginBloc.add(
                                              const LoginEventTriggerGoogleLogin());
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
                                  Text(noAccountPrompt.tr(context)),
                                  InkWell(
                                    onTap: sendingCredentials
                                        ? null
                                        : () {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        RegistrationFormScreen
                                                            .buildRegistrationFormScreen()));
                                          },
                                    child: Text(
                                      signUpText.tr(context),
                                      style:
                                          const TextStyle(color: Colors.blue),
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
          }),
    );
  }
}
