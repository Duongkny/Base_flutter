import 'package:base_flutter/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:base_flutter/src/features/auth/domain/entites/profile_information.dart';
import 'package:base_flutter/src/features/auth/domain/entites/user_token.dart';
import 'package:base_flutter/src/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remote;

  AuthRepoImpl(this._remote);

  @override
  Future<UserToken> signIn({
    required String email,
    required String password,
  }) {
    return _remote.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return _remote.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Future<void> sendOtp({
    required String email,
  }) {
    return _remote.sendOtp(email: email);
  }

  @override
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) {
    return _remote.verifyOtp(
      email: email,
      otp: otp,
    );
  }

  @override
  Future<void> updateProfile(
    ProfileInformation information,
  ) {
    return _remote.updateProfile(information);
  }

  @override
  Future<Map<String, dynamic>> getProfile() {
    return _remote.getProfile();
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) {
    return _remote.forgotPassword(email: email);
  }

  @override
  Future<String> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) {
    return _remote.verifyForgotPasswordOtp(
      email: email,
      otp: otp,
    );
  }

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) {
    return _remote.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}