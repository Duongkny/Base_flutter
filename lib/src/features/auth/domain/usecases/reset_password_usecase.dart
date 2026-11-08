import 'package:injectable/injectable.dart';
import '../repos/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _repo;

  const ResetPasswordUseCase(this._repo);

  Future<void> call({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (newPassword.length < 8) {
      throw ArgumentError('Mật khẩu phải có ít nhất 8 ký tự');
    }
    if (newPassword != confirmPassword) {
      throw ArgumentError('Mật khẩu xác nhận không khớp');
    }
    return _repo.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}