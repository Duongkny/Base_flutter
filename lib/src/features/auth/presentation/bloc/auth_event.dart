part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Đăng nhập bằng Email và Password
final class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
    email,
    password,
  ];
}

/// Đăng ký tài khoản
final class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
  ];
}

final class UpdateProfileEvent extends AuthEvent {
  final ProfileInformation information;

  const UpdateProfileEvent({
    required this.information,
  });

  @override
  List<Object?> get props => [information];
}

/// Yêu cầu khôi phục mật khẩu qua Email
final class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

/// Đưa trạng thái Auth về ban đầu
final class ResetAuthEvent extends AuthEvent {
  const ResetAuthEvent();
}

final class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;

  const VerifyOtpEvent({
    required this.email,
    required this.otp,
  });

  

  @override
  List<Object?> get props => [email, otp];
}

final class ResetPasswordEvent extends AuthEvent {
  final String resetToken;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordEvent({
    required this.resetToken,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [resetToken, newPassword, confirmPassword];
}

final class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}