import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/presentation/widgets/input_field.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/container_auth.dart';
import '../../../../router/route.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
          ForgotPasswordEvent(
            email: _emailController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is ForgotPasswordSuccess || current is AuthError,
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Mã OTP xác thực đã được gửi về email của bạn.',
              ),
            ),
          );

          context.go(
            Uri(
              path: AppRoute.otp.path,
              queryParameters: {
                'email': _emailController.text.trim(),
                'type': 'forgot_password',
              },
            ).toString(),
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message)),
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
                  context.loc.forgotPassword,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: colors.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  context.loc.forgotPasswordDescription,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: colors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 22.h),

                // =========================
                // FORM
                // =========================
                Form(
                  key: _formKey,
                  child: InputField.email(
                    controller: _emailController,
                    hintText: context.loc.emailHint,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icon(
                      Icons.person,
                      size: 22.r,
                      color: colors.onSurface,
                    ),
                    onFieldSubmitted: (_) {
                      if (!isLoading) {
                        _submit();
                      }
                    },
                  ),
                ),

                SizedBox(height: 22.h),

                // =========================
                // SUBMIT BUTTON
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submit,
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
                            context.loc.sendResetLink,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: colors.onPrimary,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 18.h),

                // =========================
                // BACK TO SIGN IN
                // =========================
                Center(
                  child: GestureDetector(
                    onTap: isLoading ? null : () => AppRoute.signIn.go(context),
                    child: Text(
                      context.loc.backToSignIn,
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
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
