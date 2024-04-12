import '../constants/errors.dart';

const String loginTxt = 'login_txt';
const String passwordTxt = 'password_txt';
const String emailTxt = 'email_txt';
const String emailPrompt = 'email_prompt';
const String passwordPrompt = 'password_prompt';
const String loginButton = 'login_btn';
const String socialLoginPrompt = 'social_login_prompt';
const String socialRegistrationPrompt = 'social_registration_prompt';
const String noAccountPrompt = 'no_account_prompt';
const String signUpText = 'signup_txt';
const String errorServer = 'error_server';
const String credentialsNotFound = 'credentials_not_found';
const String networkError = 'network_error';
const String googleLoginFailure = 'google_login_failure';
const String error500 = '500';
const String error404 = '404';
const String error4041 = '4041';
const String error4091 = '4091';
const String error5001 = '5001';
const String error5002 = '5002';
const String duplicateAccount = 'duplicate_account';
const String registrationTxt = 'registration_txt';
const String passwordConfirmationTxt = 'password_confirmation';
const String passwordConfirmationPrompt = 'password_confirmation_prompt';
const String registerButton = 'register_button';
const String existingAccountPrompt = 'existing_account_prompt';
const String nameTxt = 'name_txt';
const String namePrompt = 'name_prompt';
const String totalTxt = 'total_text';
const String correctTxt = 'correct_text';
const String totalAnsweredTxt = 'total_answered_text';
const String mcqTxt = 'mcq_txt';
const String flashCardTxt = 'flashcardTxt';
const String aboutTxt = 'about_txt';
const String privacyPolicyTxt = 'privacy_policy_txt';
const String appDescriptionTxt = 'app_description_txt';
const String sendFeedbackTxt = 'send_feedback_txt';
const String openedText = 'opened_text';
const String noTokenFromGoogleError = 'no_token_from_google_error';
const String noGoogleUserError = 'no_google_user_error';
const String passwordTooWeakError = 'password_too_weak_error';
const String emailAlreadyInUse = 'email_already_in_use_error';
const String accountCreateWithGoogleError = 'account_create_with_google_error';
const String accountCreatedWithPasswordError = 'account_created_with_password_error';

final Map<String, String> enUs = {
  loginTxt: 'Log in',
  emailTxt: 'Email',
  emailPrompt: 'Please enter your email',
  passwordTxt: 'Password',
  passwordPrompt: 'Please enter your password',
  loginButton: 'Login',
  socialLoginPrompt: 'Log in with: ',
  socialRegistrationPrompt: 'Register in with',
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
  namePrompt: 'Please enter your name',
  totalTxt: 'Total',
  totalAnsweredTxt: 'Answered',
  correctTxt: 'Correct',
  mcqTxt: 'MCQ',
  flashCardTxt: 'Flash Card',
  aboutTxt: 'About app',
  privacyPolicyTxt: 'Privacy Policy',
  appDescriptionTxt:
      "This application is intended to help you remember the important information from your pdf. ",
  sendFeedbackTxt: 'Send Feedback',
  openedText: 'Opened',
  noTokenFromGoogleError:
      "We couldn't get the token from Google. Please try again",
  noGoogleUserError: "We couldn't get the user from Google. Please try again",
  passwordTooWeakError:
      "The password is too weak. Please use at least 8 characters containing at"
          " least one capital letter, one small letter, one digit and one "
          "special character",
  emailAlreadyInUse: "There is already an account with the provided email",
  accountCreatedWithPasswordError: "Account exists with password",
  accountCreateWithGoogleError: "Account exists with Google Login"
};
