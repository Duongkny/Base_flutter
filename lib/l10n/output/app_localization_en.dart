// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'BaseFlutter';

  @override
  String get getStartedTitle => 'Welcome to HomeLove';

  @override
  String get getStartedDescription =>
      'A place to treasure your moments of love';

  @override
  String get appDescription =>
      'Together, let\'s treasure\nour most beautiful moments';

  @override
  String get getStartedButton => 'Get Started';

  @override
  String get getStartedSignIn => 'Already have an account? Sign In';

  @override
  String get onboardingMemoryTitle => 'Treasure Your Memories';

  @override
  String get onboardingMemoryDescription =>
      'Capture the special moments of your journey together';

  @override
  String get onboardingHabitsTitle => 'Build Good Habits Together';

  @override
  String get onboardingHabitsDescription =>
      'Plan, remind and experience more meaningful moments every day';

  @override
  String get onboardingConnectionTitle => 'Grow Closer Together';

  @override
  String get onboardingConnectionDescription =>
      'Share feelings, understand each other and build your own journey';

  @override
  String get skip => 'Skip';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signIn => 'Sign In';

  @override
  String get signInTitle => 'Welcome back';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUpNow => 'Sign up now';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signUpTitle => 'Create your HomeLove account';

  @override
  String get startLoveJourney => 'Start your journey of love';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get signInNow => 'Sign in now';

  @override
  String get agreeWith => 'I agree to ';

  @override
  String get termsAndPrivacyPolicy => 'Terms and Privacy Policy';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get or => 'or';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get forgotPasswordTitle => 'Reset Password';

  @override
  String get forgotPasswordDescription =>
      'Enter your email to receive password reset instructions';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get backToSignIn => 'Back to Sign In';

  @override
  String get resetEmailSent =>
      'Password reset instructions have been sent if the email exists in our system';

  @override
  String get otpTitle => 'Enter Verification Code';

  @override
  String get otpDescription => 'We have sent a 6-digit code to your email.';

  @override
  String get otpNotReceived => 'Didn\'t receive the code?';

  @override
  String get verifyOtp => 'Confirm';

  @override
  String get resendOtp => 'Resend code';

  @override
  String get otpExpireMessage => 'Resend code';

  @override
  String theCodeWill(String time) {
    return 'Resend in $time';
  }

  @override
  String get otpInvalid => 'Invalid verification code';

  @override
  String get otpExpired => 'The verification code has expired';

  @override
  String get otpVerifySuccess => 'Verification successful';

  @override
  String get otpResendSuccess => 'A new verification code has been sent';

  @override
  String get invalidOtpLength => 'OTP must contain exactly 6 digits';

  @override
  String get otpResending => 'Resending...';

  @override
  String get invalidNumber => 'Please enter a valid number';

  @override
  String get profileInformation => 'Personal Information';

  @override
  String get profileInformationDescription =>
      'Tell us a little more about yourself';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get dateOfBirthHint => 'Select your date of birth';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get other => 'Other';

  @override
  String get nickname => 'Nickname';

  @override
  String get nicknameHint => 'Enter your nickname';

  @override
  String get address => 'Address';

  @override
  String get addressHint => 'Enter your address';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneNumberHint => 'Enter your phone number';

  @override
  String get avatar => 'Profile Picture';

  @override
  String get chooseAvatar => 'Choose Profile Picture';

  @override
  String get avatarTooLarge => 'Profile picture must not exceed 5 MB';

  @override
  String get next => 'Continue';

  @override
  String get back => 'Back';

  @override
  String get complete => 'Complete';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get loading => 'Processing...';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidEmail => 'Invalid email address';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get termsRequired => 'Please agree to the Terms of Service';

  @override
  String get signInSuccess => 'Signed in successfully';

  @override
  String get signUpSuccess => 'Account created successfully';

  @override
  String get profileUpdateSuccess => 'Profile updated successfully';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again';

  @override
  String get featureUnderDevelopment => 'This feature is under development';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordDescription =>
      'Enter a new password for your account';

  @override
  String get newPassword => 'New Password';

  @override
  String get newPasswordHint => 'Enter new password (minimum 8 characters)';

  @override
  String get resetPasswordButton => 'Update Password';

  @override
  String get resetPasswordSuccess =>
      'Password reset successful! Please log in again.';
}
