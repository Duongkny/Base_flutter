import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';

import '../widgets/container_auth.dart';
import '../widgets/input_auth_otp.dart';
import '../widgets/otp_count_down_timer.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.email,
    required this.onVerify,
    required this.onResend,
  });

  final String email;
  final Future<void> Function(String code) onVerify;
  final Future<bool> Function() onResend;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  Timer? _timer;
  int _remainingSeconds = 60;

  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final code = _otpController.text.trim();

    if (code.length != 6 || _isVerifying || _isResending) {
      return;
    }

    setState(() => _isVerifying = true);

    try {
      await widget.onVerify(code);
    } catch (error) {
      debugPrint('Verify OTP failed: $error');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.loc.somethingWentWrong),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  Future<void> _resendOtp() async {
    if (_isResending || _isVerifying || _remainingSeconds > 0) {
      return;
    }

    setState(() => _isResending = true);

    try {
      final success = await widget.onResend();

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.otpResendSuccess),
          ),
        );
        _startTimer();
      }
    } catch (error) {
      debugPrint('Resend OTP failed: $error');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.loc.somethingWentWrong),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final colors = context.colorScheme;
    final code = _otpController.text;
    final isBusy = _isVerifying || _isResending;

    return Center(
      child: SingleChildScrollView(
        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 24.h,
        ),
        child: ContainerAuth(
          children: [
            // =========================
            // TITLE
            // =========================
            Text(
              loc.otpTitle,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                color: colors.onSurface,
                letterSpacing: -0.5,
              ),
            ),

            SizedBox(height: 8.h),

            // =========================
            // DESCRIPTION
            // =========================
            Text(
              '${loc.otpDescription} (${widget.email})',
              style: TextStyle(
                fontSize: 13.sp,
                color: colors.onSurfaceVariant,
                height: 1.4,
              ),
            ),

            SizedBox(height: 24.h),

            // =========================
            // OTP INPUT
            // =========================
            Center(
              child: InputAuthOTP(
                controller: _otpController,
                enabled: !isBusy,
                onChanged: (_) => setState(() {}),
              ),
            ),

            SizedBox(height: 20.h),

            // =========================
            // RESEND TIMER
            // =========================
            Center(
              child: Column(
                children: [
                  Text(
                    loc.otpNotReceived,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  OtpCountDownTimer(
                    remainingSeconds: _remainingSeconds,
                    onResend: _resendOtp,
                    isResending: _isResending,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // =========================
            // CONFIRM BUTTON
            // =========================
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: code.length == 6 && !isBusy ? _verifyOtp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  disabledBackgroundColor: colors.surfaceContainerHighest,
                  disabledForegroundColor: colors.onSurfaceVariant,
                  elevation: 0,
                  shape: const StadiumBorder(),
                ),
                child: _isVerifying
                    ? SizedBox(
                        width: 22.r,
                        height: 22.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.onPrimary,
                        ),
                      )
                    : Text(
                        loc.verifyOtp,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.onPrimary,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
