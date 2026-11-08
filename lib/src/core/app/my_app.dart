import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/l10n/output/app_localization.dart';
import 'package:base_flutter/src/constant/app_theme.dart';
import 'package:base_flutter/src/core/app/provider.dart';
import 'package:base_flutter/src/core/localization/bloc/localization_bloc.dart';
import 'package:base_flutter/src/core/theme/bloc/theme_bloc.dart';
import 'package:base_flutter/src/router/router.import.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(
      ThemeData.light().textTheme,
    );

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: appProviders,
          child: BlocBuilder<ThemeBloc, AppThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LocalizationBloc, AppLocalizationState>(
                builder: (context, locState) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    locale: locState.selectedLanguage.value,

                    // Theme
                    theme: appTheme.light(),
                    darkTheme: appTheme.dark(),
                    themeMode: themeState.selectedTheme.value,

                    // Localization
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales:
                        AppLocalizations.supportedLocales,

                    // GoRouter
                    routerConfig: appRouter,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
