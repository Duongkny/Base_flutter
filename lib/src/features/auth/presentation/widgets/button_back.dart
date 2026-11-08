import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:base_flutter/src/core/extension/context.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.canPop()) {
      return const SizedBox.shrink();
    }

    final colors = context.colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? colors.outline : colors.outlineVariant,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: isDark ? 0.3 : 0.12),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            if (context.canPop()) {
              context.pop();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.r,
              color: colors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
