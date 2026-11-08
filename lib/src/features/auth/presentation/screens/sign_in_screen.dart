import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/presentation/widgets/input_field.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/container_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
    required this.onSignUp,
    required this.onForgotPassword,
    this.onSignInSuccess,
  });

  final VoidCallback onSignUp;
  final VoidCallback onForgotPassword;
  final void Function(bool hasProfile)? onSignInSuccess;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInButtonClicked() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
          SignInEvent(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthError || current is SignedIn,
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        }

        if (state is SignedIn) {
          widget.onSignInSuccess?.call(state.hasProfile);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;
        final colors = context.colorScheme;

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
                  context.loc.signIn,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: colors.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: 22.h),

                // =========================
                // FORM
                // =========================
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField.email(
                        controller: _emailController,
                        hintText: context.loc.emailHint,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icon(
                          Icons.person,
                          size: 22.r,
                          color: colors.onSurface,
                        ),
                      ),

                      SizedBox(height: 14.h),

                      InputField.password(
                        controller: _passwordController,
                        hintText: context.loc.passwordHint,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 22.r,
                          color: colors.onSurface,
                        ),
                        onFieldSubmitted: (_) {
                          if (!isLoading) {
                            _onSignInButtonClicked();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                // =========================
                // FORGOT PASSWORD
                // =========================
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: isLoading ? null : widget.onForgotPassword,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 4.h,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      context.loc.forgotPassword,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 22.h),

                // =========================
                // SIGN IN BUTTON
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onSignInButtonClicked,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                      elevation: 0,
                      shape: const StadiumBorder(),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 22.r,
                            height: 22.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.onPrimary,
                            ),
                          )
                        : Text(
                            context.loc.signIn,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: colors.onPrimary,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 20.h),

                // =========================
                // SIGN UP REDIRECT
                // =========================
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        context.loc.dontHaveAccount,
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: isLoading ? null : widget.onSignUp,
                        child: Text(
                          context.loc.signUpNow,
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
