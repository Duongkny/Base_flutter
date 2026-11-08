import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';

class ContainerAuth extends StatelessWidget {
  const ContainerAuth({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 350.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: isDark ? colors.outline : colors.outlineVariant,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: isDark ? 0.35 : 0.18),
            blurRadius: 24.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 26.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
