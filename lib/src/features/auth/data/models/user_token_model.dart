import 'package:base_flutter/src/features/auth/domain/entites/user_token.dart';

class UserTokenModel extends UserToken {
  const UserTokenModel({
    required super.userId,
    required super.email,
    required super.accessToken,
    required super.tokenType,
  });

  factory UserTokenModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserTokenModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'accessToken': accessToken,
      'tokenType': tokenType,
    };
  }
}