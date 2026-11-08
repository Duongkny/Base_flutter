
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  getStarted('/get-started'),
  onboarding('/onboarding'),
  signIn('/sign-in'),
  signUp('/sign-up'),
  signUpInformation('/sign-up-information'),
  forgotPassword('/forgot-password'),
  otp('/otp'),
  home('/home'),
  resetPassword('/reset-password');

  const AppRoute(this.path);

  final String path;

  void go(
    BuildContext context, {
    Object? extra,
  }) {
    context.go(path, extra: extra);
  }

  Future<T?> push<T extends Object?>(
    BuildContext context, {
    Object? extra,
  }) {
    return context.push<T>(
      path,
      extra: extra,
    );
  }

  void pushReplacement(
    BuildContext context, {
    Object? extra,
  }) {
    context.pushReplacement(
      path,
      extra: extra,
    );
  }
}
