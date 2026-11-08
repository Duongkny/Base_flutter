import 'package:injectable/injectable.dart';
import '../repos/auth_repo.dart';

@injectable
class VerifyOtpUseCase {
  final AuthRepo _repo;

  const VerifyOtpUseCase(this._repo);

  Future<String?> call({
    required String email,
    required String otp,
    bool isForgotPassword = false, // <-- Thêm cờ này (mặc định là false)
  }) async {
    if (isForgotPassword) {
      // Nếu là quên mật khẩu: gọi API trả về resetToken
      return await _repo.verifyForgotPasswordOtp(
        email: email,
        otp: otp,
      );
    }

    // Nếu là đăng ký: gọi API cũ
    await _repo.verifyOtp(
      email: email,
      otp: otp,
    );
    return null;
  }
}