
import 'package:equatable/equatable.dart';

class ProfileInformation extends Equatable {
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final String nickname;
  final String address;
  final String phoneNumber;
  final String? avatarPath;

  const ProfileInformation({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.nickname,
    required this.address,
    required this.phoneNumber,
    this.avatarPath,
  });

  @override
  List<Object?> get props => [
        fullName,
        dateOfBirth,
        gender,
        nickname,
        address,
        phoneNumber,
        avatarPath,
      ];
}
