import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:base_flutter/src/core/local_storage/local_storage_key.dart';
import 'package:base_flutter/src/features/auth/domain/entites/profile_information.dart';
import 'package:base_flutter/src/features/auth/domain/entites/user_token.dart';
import 'package:base_flutter/src/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:base_flutter/src/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._updateProfileUseCase,
    this._forgotPasswordUseCase,
    this._verifyOtpUseCase,
    this._resetPasswordUseCase,
  ) : super(const AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetAuthEvent>(_onResetAuth);
    on<ResetPasswordEvent>(_onResetPassword);
    on<SignOutEvent>((event, emit) async {
      final box = Hive.box(LocalStorageKey.token);
      await box.clear();
      emit(const SignedOut());
    });
  }

  // SIGN IN
  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final userToken = await _signInUseCase(
        email: event.email,
        password: event.password,
      );

      // Lưu accessToken vào Hive để DioClient tự động gắn Bearer Token
          // Lưu accessToken vào Hive
      bool isProfileCompleted = false;
      try {
        final box = Hive.isBoxOpen(LocalStorageKey.token)
            ? Hive.box(LocalStorageKey.token)
            : await Hive.openBox(LocalStorageKey.token);

        // 1. Chỉ lưu dạng chuỗi String an toàn
        await box.put('accessToken', userToken.accessToken);
        await box.put('userId', userToken.userId);
        await box.put('email', userToken.email);

        // 2. Lấy cờ lưu tạm trong máy
        isProfileCompleted =
            box.get('isProfileCompleted', defaultValue: false) as bool;

        // 3. Nếu trong máy chưa lưu true, gọi server kiểm tra hồ sơ
        if (!isProfileCompleted) {
          try {
            final profile = await _signInUseCase.repo.getProfile();
            if (profile['fullName'] != null &&
                (profile['fullName'] as String).trim().isNotEmpty) {
              isProfileCompleted = true;
              await box.put('isProfileCompleted', true); // Lưu lại cho các lần sau
            }
          } catch (e) {
            debugPrint('Chưa có hồ sơ cá nhân trên server hoặc lỗi: $e');
          }
        }
      } catch (e) {
        debugPrint('Lỗi lưu token vào Hive: $e');
      }

      emit(SignedIn(userToken, hasProfile: isProfileCompleted));
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // SIGN UP
  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      await _signUpUseCase(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      emit(const SignedUp());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // UPDATE PROFILE
  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _updateProfileUseCase(information: event.information);

      // Lưu trạng thái đã hoàn thành hồ sơ vào Hive
      try {
        final box = Hive.isBoxOpen(LocalStorageKey.token)
            ? Hive.box(LocalStorageKey.token)
            : await Hive.openBox(LocalStorageKey.token);
        await box.put('isProfileCompleted', true);
      } catch (e) {
        debugPrint('Lỗi lưu cờ isProfileCompleted vào Hive: $e');
      }

      emit(const ProfileUpdated());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // FORGOT PASSWORD
  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _forgotPasswordUseCase(email: event.email);

      emit(const ForgotPasswordSuccess());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // VERIFY OTP
  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _verifyOtpUseCase(email: event.email, otp: event.otp);

      emit(const OtpVerified());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // RESET PASSWORD
  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _resetPasswordUseCase(
        resetToken: event.resetToken,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
      emit(const ResetPasswordSuccess());
    } catch (error) {
      emit(AuthError(_getErrorMessage(error)));
    }
  }

  // RESET AUTH STATE
  void _onResetAuth(ResetAuthEvent event, Emitter<AuthState> emit) {
    emit(const AuthInitial());
  }

  // ERROR HANDLING
  String _getErrorMessage(Object error) {
    debugPrint('========== AUTH ERROR ==========');
    debugPrint('Error type: ${error.runtimeType}');
    debugPrint('Error: $error');

    if (error is DioException) {
      debugPrint('URL: ${error.requestOptions.uri}');
      debugPrint('Method: ${error.requestOptions.method}');
      debugPrint('Status Code: ${error.response?.statusCode}');
      debugPrint('Response: ${error.response?.data}');
      debugPrint('Dio Type: ${error.type}');

      final data = error.response?.data;

      if (data is Map &&
          data['message'] is String &&
          (data['message'] as String).isNotEmpty) {
        return data['message'] as String;
      }

      final statusCode = error.response?.statusCode;
      if (statusCode == 409) {
        return 'Email này đã được sử dụng. Vui lòng đăng nhập hoặc dùng email khác.';
      }
      if (statusCode == 400) {
        return 'Thông tin không hợp lệ. Vui lòng kiểm tra lại.';
      }
      if (statusCode == 401) {
        return 'Email hoặc mật khẩu không chính xác.';
      }
      if (statusCode == 403) {
        return 'Bạn không có quyền thực hiện thao tác này.';
      }
      if (statusCode == 404) {
        return 'Không tìm thấy dữ liệu yêu cầu.';
      }
      if (statusCode != null && statusCode >= 500) {
        return 'Hệ thống máy chủ đang bận ($statusCode). Vui lòng thử lại sau.';
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Kết nối quá thời gian. Vui lòng thử lại.';

        case DioExceptionType.connectionError:
          return 'Không thể kết nối đến máy chủ.';

        default:
          return 'Yêu cầu thất bại (${statusCode ?? "không có mã HTTP"}).';
      }
    }

    return 'Đã xảy ra lỗi, vui lòng thử lại.';
  }
}
