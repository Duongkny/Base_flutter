import 'package:base_flutter/src/features/auth/domain/entites/profile_information.dart';
import 'package:base_flutter/src/features/auth/domain/entites/user_token.dart';

abstract class AuthRepo {
  Future<UserToken> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<void> sendOtp({
    required String email,
  });

  Future<void> verifyOtp({
    required String email,
    required String otp,
  });

  Future<void> updateProfile(
    ProfileInformation information,
  );

  Future<Map<String, dynamic>> getProfile();

  Future<void> forgotPassword({
    required String email,
  });

  Future<String> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}