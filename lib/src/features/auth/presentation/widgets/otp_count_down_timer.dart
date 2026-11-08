import 'package:flutter/material.dart';
import 'package:base_flutter/src/core/extension/context.dart';

class OtpCountDownTimer extends StatelessWidget {
  const OtpCountDownTimer({
    super.key,
    required this.remainingSeconds,
    required this.onResend,
    this.isResending = false,
  });

  final int remainingSeconds;
  final VoidCallback onResend;
  final bool isResending;

  @override
  Widget build(BuildContext context) {
    if (remainingSeconds <= 0) {
      return TextButton(
        onPressed: isResending ? null : onResend,
        child: Text(
          isResending
              ? context.loc.otpResending
              : context.loc.resendOtp,
        ),
      );
    }

    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return Text(
      context.loc.theCodeWill('$minutes:$seconds'),
      style: context.textTheme.labelLarge?.copyWith(
        color: context.colorScheme.primary,
      ),
    );
  }
}

