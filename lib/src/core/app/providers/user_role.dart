import 'package:flutter/material.dart';

enum UserRole {
  user,
  admin;

  static UserRole? fromString(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return admin;
      default:
        return user;
    }
  }
}

extension UserRoleExtension on UserRole {
  IconData get icon {
    switch (this) {
      case UserRole.admin:
        return Icons.admin_panel_settings;
      case UserRole.user:
        return Icons.person;
    }
  }
}