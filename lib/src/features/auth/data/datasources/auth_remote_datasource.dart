import 'package:dio/dio.dart';
import 'package:base_flutter/src/constant/end_point.dart';
import 'package:base_flutter/src/features/auth/data/models/user_token_model.dart';
import 'package:base_flutter/src/features/auth/domain/entites/profile_information.dart';
import 'package:base_flutter/src/features/auth/domain/entites/user_token.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  // SIGN IN
  Future<UserToken> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      EndPoint.authSignIn,
      data: {
        'email': email.trim(),
        'password': password,
      },
    );

    final data = response.data;

    if (data == null || data['success'] != true) {
      throw StateError('Đăng nhập thất bại');
    }

    return UserTokenModel.fromJson(data);
  }

  // SIGN UP
  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    await _dio.post(
      EndPoint.authRegister,
      data: {
        'email': email.trim(),
        'password': password,
        'confirmPassword': confirmPassword,
      },
    );
  }

  // SEND OTP
  Future<void> sendOtp({
    required String email,
  }) async {
    await _dio.post(
      EndPoint.authSendOtp,
      queryParameters: {
        'email': email.trim(),
      },
    );
  }

  // VERIFY OTP
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    await _dio.post(
      EndPoint.authVerifyOtp,
      data: {
        'email': email.trim(),
        'otp': otp.trim(),
      },
    );
  }

  // COMPLETE PROFILE
  Future<void> updateProfile(
    ProfileInformation information,
  ) async {
    final dob = information.dateOfBirth;
    final formattedDate =
        '${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';

    await _dio.post(
      EndPoint.profileComplete,
      data: {
        'fullName': information.fullName.trim(),
        'dateOfBirth': formattedDate,
        'gender': information.gender.toUpperCase(),
        'nickname': information.nickname.trim(),
        'address': information.address.trim(),
        'phoneNumber': information.phoneNumber.trim(),
        'avatarUrl': information.avatarPath ?? '',
      },
    );
  }

  // GET PROFILE
  Future<Map<String, dynamic>> getProfile() async {
    final response = await _dio.get<Map<String, dynamic>>(
      EndPoint.profileMe,
    );

    final data = response.data;

    if (data == null) {
      throw const FormatException(
        'Backend không trả về dữ liệu hồ sơ',
      );
    }

    return data;
  }

  // FORGOT PASSWORD
  Future<void> forgotPassword({
    required String email,
  }) async {
    await _dio.post(
      EndPoint.authForgotPassword,
      data: {
        'email': email.trim(),
      },
    );
  }

  // VERIFY FORGOT PASSWORD OTP
  Future<String> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      EndPoint.authForgotPasswordVerify,
      data: {
        'email': email.trim(),
        'otp': otp.trim(),
      },
    );

    final resetToken = response.data?['resetToken'];

    if (resetToken is! String || resetToken.isEmpty) {
      throw const FormatException(
        'Backend chưa trả về resetToken. '
        'Cần xác nhận response với Backend.',
      );
    }

    return resetToken;
  }

  // RESET PASSWORD
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _dio.post(
      EndPoint.authResetPassword,
      data: {
        'resetToken': resetToken,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
  }
}
