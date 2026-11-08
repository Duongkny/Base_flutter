
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/utils/validators.dart';

class InputAuthOTP extends StatelessWidget {
  const InputAuthOTP({
    super.key,
    required this.controller,
    this.onCompleted,
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40.w,
      height: 52.h,
      textStyle: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: context.colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colorScheme.outline,
        ),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        autofocus: true,
        enabled: enabled,
        controller: controller,
        onChanged: onChanged,
        onCompleted: onCompleted,
        validator: Validators.otp,
        showCursor: false,
        pinputAutovalidateMode:
            PinputAutovalidateMode.onSubmit,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(
              color: context.colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(
              color: context.colorScheme.error,
            ),
          ),
        ),
        errorTextStyle: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.error,
        ),
      ),
    );
  }
}
