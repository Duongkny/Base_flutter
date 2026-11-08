import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  /// Minimalist Monotone Light Scheme (Đen - Trắng - Xám tối giản, sang trọng)
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF18181B),
      surfaceTint: Color(0xFF18181B),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFF4F4F5),
      onPrimaryContainer: Color(0xFF18181B),
      secondary: Color(0xFF3F3F46),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE4E4E7),
      onSecondaryContainer: Color(0xFF18181B),
      tertiary: Color(0xFF71717A),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF4F4F5),
      onTertiaryContainer: Color(0xFF27272A),
      error: Color(0xFFEF4444),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: Color(0xFF991B1B),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF18181B),
      onSurfaceVariant: Color(0xFF71717A),
      outline: Color(0xFFD4D4D8),
      outlineVariant: Color(0xFFE4E4E7),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF18181B),
      inversePrimary: Color(0xFFF4F4F5),
      primaryFixed: Color(0xFFE4E4E7),
      onPrimaryFixed: Color(0xFF18181B),
      primaryFixedDim: Color(0xFFD4D4D8),
      onPrimaryFixedVariant: Color(0xFF27272A),
      secondaryFixed: Color(0xFFE4E4E7),
      onSecondaryFixed: Color(0xFF18181B),
      secondaryFixedDim: Color(0xFFD4D4D8),
      onSecondaryFixedVariant: Color(0xFF27272A),
      tertiaryFixed: Color(0xFFF4F4F5),
      onTertiaryFixed: Color(0xFF27272A),
      tertiaryFixedDim: Color(0xFFE4E4E7),
      onTertiaryFixedVariant: Color(0xFF3F3F46),
      surfaceDim: Color(0xFF505050),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFFAFAFA),
      surfaceContainer: Color(0xFFF4F4F5),
      surfaceContainerHigh: Color(0xFFE4E4E7),
      surfaceContainerHighest: Color(0xFFD4D4D8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  /// Minimalist Monotone Dark Scheme (Đen nhám Onyx - Trắng sáng - Xám tối giản)
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFAFAFA),
      surfaceTint: Color(0xFFFAFAFA),
      onPrimary: Color(0xFF18181B),
      primaryContainer: Color(0xFF27272A),
      onPrimaryContainer: Color(0xFFF4F4F5),
      secondary: Color(0xFFD4D4D8),
      onSecondary: Color(0xFF18181B),
      secondaryContainer: Color(0xFF3F3F46),
      onSecondaryContainer: Color(0xFFFAFAFA),
      tertiary: Color(0xFFA1A1AA),
      onTertiary: Color(0xFF18181B),
      tertiaryContainer: Color(0xFF27272A),
      onTertiaryContainer: Color(0xFFE4E4E7),
      error: Color(0xFFF87171),
      onError: Color(0xFF450A0A),
      errorContainer: Color(0xFF7F1D1D),
      onErrorContainer: Color(0xFFFEE2E2),
      surface: Color(0xFF18181B),
      onSurface: Color(0xFFFAFAFA),
      onSurfaceVariant: Color(0xFFA1A1AA),
      outline: Color(0xFF3F3F46),
      outlineVariant: Color(0xFF27272A),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFFAFAFA),
      inversePrimary: Color(0xFF18181B),
      primaryFixed: Color(0xFF27272A),
      onPrimaryFixed: Color(0xFFFAFAFA),
      primaryFixedDim: Color(0xFF3F3F46),
      onPrimaryFixedVariant: Color(0xFFF4F4F5),
      secondaryFixed: Color(0xFF27272A),
      onSecondaryFixed: Color(0xFFFAFAFA),
      secondaryFixedDim: Color(0xFF3F3F46),
      onSecondaryFixedVariant: Color(0xFFF4F4F5),
      tertiaryFixed: Color(0xFF27272A),
      onTertiaryFixed: Color(0xFFFAFAFA),
      tertiaryFixedDim: Color(0xFF3F3F46),
      onTertiaryFixedVariant: Color(0xFFE4E4E7),
      surfaceDim: Color(0xFF121214),
      surfaceBright: Color(0xFF27272A),
      surfaceContainerLowest: Color(0xFF09090B),
      surfaceContainerLow: Color(0xFF121214),
      surfaceContainer: Color(0xFF18181B),
      surfaceContainerHigh: Color(0xFF27272A),
      surfaceContainerHighest: Color(0xFF3F3F46),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: const StadiumBorder(),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: const StadiumBorder(),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(
            color: colorScheme.outline,
            width: 1.2,
          ),
          textStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
    );
  }

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily dark;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.dark,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
