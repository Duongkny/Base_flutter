
import 'package:flutter/material.dart';

import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/extension/string.dart';
import 'package:base_flutter/src/router/router.import.dart';


abstract class Validators {
  Validators._();

  // ==========================================
  // GET VALIDATOR
  // ==========================================

  static FormFieldValidator<String>? getValidator(
    TextInputType? keyboardType,
  ) {
    return switch (keyboardType) {
      TextInputType.name => Validators.name,
      TextInputType.emailAddress => Validators.email,
      TextInputType.number => Validators.number,
      TextInputType.phone => Validators.phone,
      _ => null,
    };
  }

  // ==========================================
  // REQUIRED
  // ==========================================

  static String? required(String? input) {
    if (input == null || input.trim().isEmpty) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    return null;
  }

  static String? requiredTyped<T>(T? input) {
    if (input == null) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    return null;
  }

  // ==========================================
  // NAME
  // ==========================================

  static String? name(String? name) {
    return required(name);
  }

  // ==========================================
  // EMAIL
  // ==========================================

  static String? email(String? email) {
    if (email == null || email.trim().isEmpty) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    if (!email.trim().isValidEmail()) {
      return navigatorKey.currentContext?.loc.invalidEmail;
    }

    return null;
  }

  // ==========================================
  // OTP
  // ==========================================

  static String? otp(String? code) {
    if (code == null || code.trim().isEmpty) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    if (!RegExp(r'^[0-9]{6}$').hasMatch(code)) {
      return navigatorKey.currentContext?.loc.invalidOtpLength;
    }

    return null;
  }

  // ==========================================
  // PASSWORD
  // ==========================================

  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    if (password.length < 8) {
      return navigatorKey.currentContext?.loc.passwordTooShort;
    }

    return null;
  }

  // ==========================================
  // CONFIRM PASSWORD
  // ==========================================

  static String? confirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null ||
        confirmPassword.isEmpty) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    if (password != confirmPassword) {
      return navigatorKey.currentContext?.loc.passwordsDoNotMatch;
    }

    return null;
  }

  // ==========================================
  // NUMBER
  // ==========================================

  static String? number(String? input) {
    if (input == null || input.trim().isEmpty) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    final number = num.tryParse(input.trim());

    if (number == null) {
      return navigatorKey.currentContext?.loc.invalidNumber;
    }

    return null;
  }

  // ==========================================
  // PHONE NUMBER
  // ==========================================

  static String? phone(String? input) {
    if (input == null || input.trim().isEmpty) {
      return navigatorKey.currentContext?.loc.requiredField;
    }

    final phoneNumber = input.trim();

    if (!RegExp(r'^\+?[0-9]{9,15}$').hasMatch(phoneNumber)) {
      return navigatorKey.currentContext?.loc.invalidPhoneNumber;
    }

    return null;
  }
}
