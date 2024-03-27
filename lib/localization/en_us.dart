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
const error500 = '500';
const error404 = '404';
const error4041 = '4041';
const error4091 = '4091';
const error5001 =  '5001';
const error5002 = '5002';
const String duplicateAccount = 'duplicate_account';
const registrationTxt = 'registration_txt';
const passwordConfirmationTxt = 'password_confirmation';
const passwordConfirmationPrompt = 'password_confirmation_prompt';
const registerButton = 'register_button';
const existingAccountPrompt = 'existing_account_prompt';
const String nameTxt = 'name_txt';
const String namePrompt = 'name_prompt';

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
  error5001: errorCodes[5001]?['en'] ?? "Error 5001",
  error5002: errorCodes[5002]?['en'] ?? "Error 5002",
  duplicateAccount: 'An account already exists with the provided Email',
  registrationTxt: 'Registration',
  passwordConfirmationTxt: 'Confirm Password',
  passwordConfirmationPrompt: 'Please re-enter your password',
  registerButton: 'Create Account',
  existingAccountPrompt: 'You already have an account? ',
  nameTxt: 'Name',
  namePrompt: 'Please enter your name'
};
