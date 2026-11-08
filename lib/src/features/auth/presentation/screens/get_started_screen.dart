import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/local_storage/local_storage_key.dart';
import 'package:base_flutter/src/router/route.dart';
import 'package:base_flutter/src/core/injections/injections.dart';
import 'package:base_flutter/src/features/auth/domain/repos/auth_repo.dart';

import '../widgets/intro_layout.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkExistingAuth());
  }

  Future<void> _checkExistingAuth() async {
  try {
    final box = Hive.isBoxOpen(LocalStorageKey.token)
        ? Hive.box(LocalStorageKey.token)
        : await Hive.openBox(LocalStorageKey.token);

    final token = box.get('accessToken') as String?;
    if (token == null || token.isEmpty) return; // Chưa đăng nhập thì ở lại GetStarted

    bool hasProfile = box.get('isProfileCompleted', defaultValue: false) as bool;

    // Nếu cờ trong máy chưa có, hỏi thử server
    if (!hasProfile) {
      try {
        final profile = await getIt<AuthRepo>().getProfile();
        if (profile['fullName'] != null && (profile['fullName'] as String).isNotEmpty) {
          hasProfile = true;
          await box.put('isProfileCompleted', true); // Lưu lại cho lần sau
        }
      } catch (e) {
        debugPrint('Chưa có hồ sơ trên server: $e');
      }
    }

    if (!mounted) return;

    // Điều hướng chuẩn
    if (hasProfile) {
      AppRoute.home.go(context);
    } else {
      AppRoute.signUpInformation.go(context);
    }
  } catch (e) {
    debugPrint('Lỗi kiểm tra phiên đăng nhập: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return IntroLayout(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.h,
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // HomeLove introduction card
            Container(
              width: 260.w,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 26.h,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.15),
                    blurRadius: 16.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Icon(
                    Icons.house_rounded,
                    size: 60.r,
                    color: colorScheme.primary,
                  ),

                  SizedBox(height: 10.h),

                  // App name
                  Text(
                    context.loc.appName,
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Description
                  Text(
                    context.loc.appDescription,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 3),

            // Get started button
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: FilledButton(
                onPressed: () {
                  AppRoute.onboarding.go(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      context.loc.getStartedButton,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.r,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
