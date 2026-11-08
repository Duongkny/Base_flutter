import 'package:equatable/equatable.dart';

class UserToken extends Equatable {
  final String userId;
  final String email;
  final String accessToken;
  final String tokenType;

  const UserToken({
    required this.userId,
    required this.email,
    required this.accessToken,
    required this.tokenType,
  });

  @override
  List<Object?> get props => [
    userId,
    email,
    accessToken,
    tokenType,
  ];
}