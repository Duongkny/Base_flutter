import 'package:base_flutter/src/constant/enviroment.dart';

class EndPoint {
  static String get apiUrl =>
      '${Environment.getApiUrl}/api/v1';

  // Authentication
  static String get authSignIn => '$apiUrl/auth/login';

  static String get authRegister => '$apiUrl/auth/register';

  static String get authSendOtp => '$apiUrl/auth/send-otp';

  static String get authVerifyOtp =>
      '$apiUrl/auth/verify-otp';

  static String get authForgotPassword =>
      '$apiUrl/auth/forgot-password';

  static String get authForgotPasswordVerify =>
      '$apiUrl/auth/forgot-password/verify';

  static String get authResetPassword =>
      '$apiUrl/auth/reset-password';

  // Profile
  static String get profileComplete =>
      '$apiUrl/profiles/complete';

  static String get profileMe =>
      '$apiUrl/profiles/me';
}
