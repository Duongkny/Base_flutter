import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/localization/bloc/localization_bloc.dart';
import 'package:base_flutter/src/core/localization/models/language.dart';
import 'package:base_flutter/src/core/theme/bloc/theme_bloc.dart';
import 'package:base_flutter/src/core/theme/models/theme_models.dart';

import 'button_back.dart';

class AuthTopBar extends StatelessWidget {
  const AuthTopBar({super.key});

  Widget _buildFlag(BuildContext context, Language lang) {
    if (lang == Language.vi) {
      return Container(
        width: 24.w,
        height: 16.h,
        decoration: BoxDecoration(
          color: const Color(0xFFDA251D),
          borderRadius: BorderRadius.circular(3.r),
        ),
        child: Center(
          child: Icon(
            Icons.star,
            size: 10.r,
            color: const Color(0xFFFFFF00),
          ),
        ),
      );
    }

    final colors = context.colorScheme;
    return Container(
      width: 24.w,
      height: 16.h,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Center(
        child: Text(
          'EN',
          style: TextStyle(
            color: colors.onPrimary,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ButtonBack(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // LANGUAGE SELECTOR PILL
                BlocBuilder<LocalizationBloc, AppLocalizationState>(
                  builder: (context, state) {
                    final currentLang = state.selectedLanguage;

                    return PopupMenuButton<Language>(
                      tooltip: 'Language',
                      elevation: 4,
                      offset: Offset(0, 36.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      color: colors.surface,
                      onSelected: (lang) {
                        context.read<LocalizationBloc>().add(
                              ChangeLanguage(selectedLanguage: lang),
                            );
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: Language.vi,
                          child: Row(
                            children: [
                              _buildFlag(context, Language.vi),
                              SizedBox(width: 10.w),
                              Text(
                                'Tiếng Việt',
                                style: TextStyle(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (currentLang == Language.vi) ...[
                                const Spacer(),
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: Language.en,
                          child: Row(
                            children: [
                              _buildFlag(context, Language.en),
                              SizedBox(width: 10.w),
                              Text(
                                'English',
                                style: TextStyle(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (currentLang == Language.en) ...[
                                const Spacer(),
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildFlag(context, currentLang),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 18.r,
                              color: colors.onSurface,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(width: 10.w),

                // THEME SELECTOR PILL
                BlocBuilder<ThemeBloc, AppThemeState>(
                  builder: (context, state) {
                    final currentTheme = state.selectedTheme;

                    return PopupMenuButton<ThemeModel>(
                      tooltip: 'Theme',
                      elevation: 4,
                      offset: Offset(0, 36.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      color: colors.surface,
                      onSelected: (theme) {
                        context.read<ThemeBloc>().add(
                              ChangeTheme(selectedTheme: theme),
                            );
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: ThemeModel.light,
                          child: Row(
                            children: [
                              Icon(
                                Icons.wb_sunny_outlined,
                                size: 20,
                                color: colors.onSurface,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Sáng',
                                style: TextStyle(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (currentTheme == ThemeModel.light) ...[
                                const Spacer(),
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: ThemeModel.dark,
                          child: Row(
                            children: [
                              Icon(
                                Icons.nightlight_round,
                                size: 20,
                                color: colors.onSurface,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Tối',
                                style: TextStyle(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (currentTheme == ThemeModel.dark) ...[
                                const Spacer(),
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: ThemeModel.system,
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings_brightness,
                                size: 20,
                                color: colors.onSurface,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Hệ thống',
                                style: TextStyle(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (currentTheme == ThemeModel.system) ...[
                                const Spacer(),
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isDark
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny_outlined,
                              size: 18.r,
                              color: colors.onSurface,
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 18.r,
                              color: colors.onSurface,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
