part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Trạng thái ban đầu
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Đang xử lý yêu cầu
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Đăng nhập thành công
final class SignedIn extends AuthState {
  final UserToken userToken;
  final bool hasProfile;

  const SignedIn(this.userToken, {this.hasProfile = false});

  @override
  List<Object?> get props => [userToken, hasProfile];
}

/// Đăng ký thành công
final class SignedUp extends AuthState {
  const SignedUp();
}

/// Cập nhật thông tin cá nhân thành công
final class ProfileUpdated extends AuthState {
  const ProfileUpdated();
}

/// Yêu cầu quên mật khẩu thành công
final class ForgotPasswordSuccess extends AuthState {
  const ForgotPasswordSuccess();
}

/// Xảy ra lỗi khi thực hiện Auth
final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

final class OtpVerified extends AuthState {
  const OtpVerified();
}

final class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess();
}

final class SignedOut extends AuthState {
  const SignedOut();
}