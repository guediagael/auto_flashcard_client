import 'package:client/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/base/base_bloc_builder.dart';
import '../bloc/base/base_bloc_listener.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../constants/assets.dart';
import '../core/errors/exceptions.dart';
import '../data/data_repository.dart';
import '../localization/en_us.dart';
import '../utils/messenger.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_elevated_button.dart';
import 'home_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormState();

  static Widget buildLoginFormScreen({Key? key}) {
    return BlocProvider(
      create: (ctx) => LoginBloc(dataRepository: ctx.read<DataRepository>()),
      child: LoginFormScreen(
        key: key,
      ),
    );
  }
}

class _LoginFormState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _emailController =
      TextEditingController(); // Controller for email field
  final _passwordController =
      TextEditingController(); // Controller for password field

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    String? emailError, passwordError, email, password;
    bool sendingCredentials = false;
    final loginBloc = context.read<LoginBloc>();

    return BaseBlocListener(
      bloc: loginBloc,
      messenger: Messenger(context),
      listener: (listenerCtx, listenerState) {
        emailError = null;
        passwordError = null;
        email = null;
        password = null;
        sendingCredentials = false;
        if (listenerState is LoginStateLoginNotFound) {
          email = listenerState.email;
          password = listenerState.password;
          ScaffoldMessenger.of(listenerCtx).showSnackBar(
              SnackBar(content: Text(credentialsNotFound.tr(listenerCtx))));
        } else if (listenerState is LoginStateLoadingSendingCredentials) {
          sendingCredentials = true;
          email = listenerState.email;
          password = listenerState.password;
          loginBloc.add(LoginEventSendCredentials(
              email: listenerState.email, password: listenerState.password));
        } else if (listenerState is LoginStateLoadingSendingGoogleCredentials) {
          sendingCredentials = true;
          loginBloc.add(LoginEventTriggerGoogleSignInFailure(
              errorMessage: "Invalid credentials"));
        } else if (listenerState is LoginStateLoggedIn) {
          Navigator.of(listenerCtx).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HomeScreen.buildHomeScreen()),
              (route) => false);
        } else if (listenerState is LoginStateGoogleCredentialsError) {
          ClientException(
              message: listenerState.errorMessage, context: listenerCtx);
        } else if (listenerState is LoginStateFormValidityCheck) {
          emailError = listenerState.emailError;
          passwordError = listenerState.passwordError;
          email = listenerState.email;
          password = listenerState.password;
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
                              // Hid
                              onEditingComplete: () {
                                loginBloc.add(LoginEventCheckFormValidity(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              },
                              // e password characters
                              decoration: InputDecoration(
                                labelText: passwordTxt.tr(context),
                                border: OutlineInputBorder(),
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
                                    onTap: sendingCredentials ? null : () {},
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
