import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';

@injectable
class SignUpUseCase {
  final AuthRepo _repo;

  const SignUpUseCase(this._repo);

  Future<void> call({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final normalizedEmail = email.trim();

    if (normalizedEmail.isEmpty) {
      throw ArgumentError('Vui lòng nhập email');
    }

    if (password.length < 8) {
      throw ArgumentError(
        'Mật khẩu phải có ít nhất 8 ký tự',
      );
    }

    if (password != confirmPassword) {
      throw ArgumentError(
        'Mật khẩu xác nhận không khớp',
      );
    }

    await _repo.signUp(
      email: normalizedEmail,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
