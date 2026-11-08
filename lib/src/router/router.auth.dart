part of 'router.import.dart';

final List<RouteBase> authRoutes = [
  // GET STARTED
  GoRoute(
    path: AppRoute.getStarted.path,
    builder: (context, state) => const GetStartedScreen(),
  ),

  // ONBOARDING
  GoRoute(
    path: AppRoute.onboarding.path,
    pageBuilder: (context, state) {
      return CustomTransitionPage<void>(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );

          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.12, 0),
            end: Offset.zero,
          ).animate(curvedAnimation);

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(position: slideAnimation, child: child),
          );
        },
      );
    },
  ),

  // AUTHENTICATION
  ShellRoute(
    builder: (context, state, child) => AuthScreen(child: child),
    routes: [
      // SIGN IN
      GoRoute(
        path: AppRoute.signIn.path,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: SignInScreen(
              onSignUp: () => AppRoute.signUp.go(context),
              onSignInSuccess: (hasProfile) { if (hasProfile) { AppRoute.home.go(context); } else { AppRoute.signUpInformation.go(context); } },
              onForgotPassword: () => AppRoute.forgotPassword.push(context),
            ),
          );
        },
      ),

      // SIGN UP
      GoRoute(
        path: AppRoute.signUp.path,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<AuthBloc>(),
            child: SignUpScreen(
              onSignIn: () => AppRoute.signIn.go(context),
              onSignUpSuccess: (email) {
                context.go(
                  Uri(
                    path: AppRoute.otp.path,
                    queryParameters: {'email': email.trim()},
                  ).toString(),
                );
              },
            ),
          );
        },
      ),

      // FORGOT PASSWORD
      GoRoute(
        path: AppRoute.forgotPassword.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: const ForgotPasswordScreen(),
        ),
      ),

      // VERIFY EMAIL OTP
      // VERIFY OTP (DÙNG CHUNG)
GoRoute(
  path: AppRoute.otp.path,
  builder: (context, state) {
    final email = state.uri.queryParameters['email']?.trim() ?? '';
    final type = state.uri.queryParameters['type'] ?? 'signup'; // Mặc định là signup

    return OtpScreen(
      email: email,

      // ==========================================
      // XỬ LÝ XÁC THỰC OTP
      // ==========================================
      onVerify: (code) async {
        if (email.isEmpty) throw StateError('Email xác thực không hợp lệ.');

        if (type == 'forgot_password') {
          // Gọi API xác thực OTP quên MK -> Lấy resetToken
          final resetToken = await getIt<VerifyOtpUseCase>()(
            email: email,
            otp: code,
            isForgotPassword: true,
          );

          if (!context.mounted) return;

          // Chuyển thẳng sang màn ResetPassword cùng với resetToken
          context.go(
            Uri(
              path: AppRoute.resetPassword.path,
              queryParameters: {'token': resetToken},
            ).toString(),
          );
        } else {
          // Gọi API xác thực email
          await getIt<VerifyOtpUseCase>()(
            email: email,
            otp: code,
          );

          if (!context.mounted) return;

          // Thành công thì quay về màn Đăng nhập
          AppRoute.signIn.go(context);
        }
      },

      // ==========================================
      // XỬ LÝ GỬI LẠI MÃ (RESEND)
      // ==========================================
      onResend: () async {
        if (email.isEmpty) throw StateError('Email xác thực không hợp lệ.');

        if (type == 'forgot_password') {
          // Gửi lại OTP của quên mật khẩu
          await getIt<ForgotPasswordUseCase>()(email: email);
        } else {
          // Gửi lại OTP của đăng ký
          await getIt<SendOtpUseCase>()(email: email);
        }
        return true;
      },
    );
  },
),

GoRoute(
  path: AppRoute.resetPassword.path,
  builder: (context, state) {
    final token = state.uri.queryParameters['token'] ?? '';
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: ResetPasswordScreen(resetToken: token),
    );
  },
),

      // COMPLETE PROFILE
      GoRoute(
        path: AppRoute.signUpInformation.path,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: const SignUpInformationScreen(),
        ),
      ),
    ],
  ),
];
