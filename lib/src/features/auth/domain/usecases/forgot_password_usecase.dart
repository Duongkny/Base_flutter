
import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepo _repo;

  const ForgotPasswordUseCase(this._repo);

  Future<void> call({
    required String email,
  }) async {
    final normalizedEmail = email.trim();

    if (normalizedEmail.isEmpty) {
      throw ArgumentError('Vui lòng nhập email');
    }

    await _repo.forgotPassword(
      email: normalizedEmail,
    );
  }
}
