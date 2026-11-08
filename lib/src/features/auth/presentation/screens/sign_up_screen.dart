import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/presentation/widgets/input_field.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/container_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.onSignIn,
    required this.onSignUpSuccess,
    this.onPrivacyPolicy,
  });

  final VoidCallback onSignIn;
  final ValueChanged<String> onSignUpSuccess;
  final VoidCallback? onPrivacyPolicy;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isAgreePolicy = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUpButtonClicked() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.loc.passwordsDoNotMatch),
          ),
        );
      return;
    }

    if (!_isAgreePolicy) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.loc.termsRequired),
          ),
        );
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
          SignUpEvent(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthError || current is SignedUp,
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

        if (state is SignedUp) {
          widget.onSignUpSuccess(
            _emailController.text.trim(),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
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
                  context.loc.signUp,
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
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 22.r,
                          color: colors.onSurface,
                        ),
                      ),

                      SizedBox(height: 14.h),

                      InputField.password(
                        controller: _confirmPasswordController,
                        hintText: context.loc.confirmPasswordHint,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 22.r,
                          color: colors.onSurface,
                        ),
                        onFieldSubmitted: (_) {
                          if (!isLoading) {
                            _onSignUpButtonClicked();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // =========================
                // TERMS AND PRIVACY CHECKBOX
                // =========================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Checkbox(
                        value: _isAgreePolicy,
                        activeColor: colors.primary,
                        checkColor: colors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        onChanged: isLoading
                            ? null
                            : (value) {
                                setState(() {
                                  _isAgreePolicy = value ?? false;
                                });
                              },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            context.loc.agreeWith,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onPrivacyPolicy,
                            child: Text(
                              context.loc.termsAndPrivacyPolicy,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 22.h),

                // =========================
                // SIGN UP BUTTON
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onSignUpButtonClicked,
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
                            context.loc.signUp,
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
                // SIGN IN REDIRECT
                // =========================
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        context.loc.alreadyHaveAccount,
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: isLoading ? null : widget.onSignIn,
                        child: Text(
                          context.loc.signInNow,
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
