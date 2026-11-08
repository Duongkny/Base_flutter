import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/presentation/widgets/input_field.dart';
import 'package:base_flutter/src/router/route.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/container_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String resetToken;

  const ResetPasswordScreen({
    super.key,
    required this.resetToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.loc.passwordsDoNotMatch),
          ),
        );
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
          ResetPasswordEvent(
            resetToken: widget.resetToken,
            newPassword: _newPasswordController.text,
            confirmPassword: _confirmPasswordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final colors = context.colorScheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is ResetPasswordSuccess || current is AuthError,
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(loc.resetPasswordSuccess),
              ),
            );
          AppRoute.signIn.go(context);
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
                  loc.resetPasswordTitle,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: colors.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  loc.resetPasswordDescription,
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
                  child: Column(
                    children: [
                      InputField.password(
                        controller: _newPasswordController,
                        hintText: loc.newPasswordHint,
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
                        hintText: loc.confirmPasswordHint,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 22.r,
                          color: colors.onSurface,
                        ),
                        onFieldSubmitted: (_) {
                          if (!isLoading) {
                            _submit();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

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
                            loc.resetPasswordButton,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: colors.onPrimary,
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
