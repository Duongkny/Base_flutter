import 'package:base_flutter/src/features/auth/domain/entites/profile_information.dart';
import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';

@injectable
class UpdateProfileUseCase {
  final AuthRepo _repo;

  const UpdateProfileUseCase(this._repo);

Future<void> call({
  required ProfileInformation information,
}) {
  return _repo.updateProfile(information);
}
}