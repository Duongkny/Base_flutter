import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:base_flutter/src/constant/assets.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/router/route.dart';

import '../widgets/intro_layout.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  static const _animationDuration = Duration(
    milliseconds: 500,
  );

  static const List<_OnboardingItem> _pages = [
    _OnboardingItem(
      image: Assets.onboardingMemory,
      icon: Icons.auto_stories_rounded,
    ),
    _OnboardingItem(
      image: Assets.onboardingCalendar,
      icon: Icons.calendar_month_rounded,
    ),
    _OnboardingItem(
      image: Assets.onboardingLetter,
      icon: Icons.favorite_rounded,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int index) {
    if (!_pageController.hasClients) return;

    _pageController.animateToPage(
      index,
      duration: _animationDuration,
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _animateToPage(_currentPage + 1);
    }
  }

  void _skipOnboarding() {
    AppRoute.signIn.go(context);
  }

  Widget _buildIllustration(
    _OnboardingItem page,
    Color primaryColor,
  ) {
    return Image.asset(
      page.image,
      width: 160.w,
      height: 160.h,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: 160.w,
          height: 160.h,
          child: Icon(
            page.icon,
            size: 90.r,
            color: primaryColor,
          ),
        );
      },
    );
  }

  Widget _buildPage({
    required int index,
    required String title,
    required String description,
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    final page = _pages[index];

    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double currentPosition = _currentPage.toDouble();

        if (_pageController.hasClients &&
            _pageController.position.haveDimensions) {
          currentPosition =
              _pageController.page ?? currentPosition;
        }

        final distance = (currentPosition - index).abs();
        final progress = math.min(distance, 1.0);

        final opacity = 1.0 - progress * 0.35;
        final scale = 1.0 - progress * 0.06;
        final verticalOffset = progress * 12.h;

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, verticalOffset),
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
        );
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Illustration
              _buildIllustration(
                page,
                colors.primary,
              ),

              SizedBox(height: 22.h),

              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),

              SizedBox(height: 12.h),

              // Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation(ColorScheme colors) {
    final loc = context.loc;
    final isLastPage = _currentPage == _pages.length - 1;

    return SizedBox(
      height: 112.h,
      width: double.infinity,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: isLastPage
            ? Column(
                key: const ValueKey('finish'),
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: FilledButton(
                      onPressed: () {
                        AppRoute.signUp.go(context);
                      },
                      child: Text(loc.createAccount),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: _skipOnboarding,
                      child: Text(loc.signIn),
                    ),
                  ),
                ],
              )
            : Align(
                key: const ValueKey('next'),
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 48.h,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _skipOnboarding,
                        child: Text(loc.skip),
                      ),

                      IconButton.filled(
                        onPressed: _nextPage,
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;
    final loc = context.loc;

    final titles = [
      loc.onboardingMemoryTitle,
      loc.onboardingHabitsTitle,
      loc.onboardingConnectionTitle,
    ];

    final descriptions = [
      loc.onboardingMemoryDescription,
      loc.onboardingHabitsDescription,
      loc.onboardingConnectionDescription,
    ];

    return IntroLayout(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 28.h,
            ),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(alpha: 0.15),
                  blurRadius: 16.r,
                  offset: Offset(0, 6.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated onboarding content
                SizedBox(
                  height: 290.h,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const PageScrollPhysics(),
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildPage(
                        index: index,
                        title: titles[index],
                        description: descriptions[index],
                        colors: colors,
                        textTheme: textTheme,
                      );
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                // Worm indicator inside card
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: WormEffect(
                    spacing: 8.w,
                    dotWidth: 8.w,
                    dotHeight: 8.h,
                    radius: 12.r,
                    activeDotColor: colors.primary,
                    dotColor: colors.primary.withValues(
                      alpha: 0.2,
                    ),
                  ),
                  onDotClicked: _animateToPage,
                ),

                SizedBox(height: 24.h),

                // Navigation inside card
                _buildNavigation(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingItem {
  const _OnboardingItem({
    required this.image,
    required this.icon,
  });

  final String image;
  final IconData icon;
}
