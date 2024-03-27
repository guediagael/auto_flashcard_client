import '../constants/errors.dart';

const String loginTxt = 'login_txt';
const String passwordTxt = 'password_txt';
const String emailTxt = 'email_txt';
const String emailPrompt = 'email_prompt';
const String passwordPrompt = 'password_prompt';
const String loginButton = 'login_btn';
const String socialLoginPrompt = 'social_login_prompt';
const String noAccountPrompt = 'no_account_prompt';
const String signUpText = 'signup_txt';
const String errorServer = 'error_server';
const String credentialsNotFound = 'credentials_not_found';
const String networkError = 'network_error';
const String googleLoginFailure = 'google_login_failure';
const error500 = 'error500';
const error404 = 'error404';
const error4041 = 'error4041';
const error4091 = 'error4091';

final Map<String, String> enUs = {
  loginTxt: 'Log in',
  emailTxt: 'Email',
  emailPrompt: 'Please enter your email',
  passwordTxt: 'Password',
  passwordPrompt: 'Please enter your password',
  loginButton: 'Login',
  socialLoginPrompt: 'Log in with: ',
  noAccountPrompt: 'No account? ',
  signUpText: 'Sign up',
  errorServer: 'Server error',
  credentialsNotFound: 'Credentials not found',
  networkError: 'Network error',
  googleLoginFailure: 'Error connecting to your Google account',
  error500: errorCodes[500]?['en'] ?? "Error 500",
  error404: errorCodes[404]?['en'] ?? "Error 404",
  error4041: errorCodes[4041]?['en'] ?? "Error 4041",
  error4091: errorCodes[4091]?['en'] ?? "Error 4091",
};
