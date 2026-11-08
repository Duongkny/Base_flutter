import 'package:injectable/injectable.dart';
import '../repos/auth_repo.dart';

@injectable
class SendOtpUseCase {
  final AuthRepo _repo;

  const SendOtpUseCase(this._repo);

  Future<void> call({
    required String email,
  }) {
    return _repo.sendOtp(email: email);
  }
}