import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';
import 'package:base_flutter/src/core/presentation/widgets/input_field.dart';
import 'package:base_flutter/src/core/utils/validators.dart';
import 'package:base_flutter/src/features/auth/domain/entites/profile_information.dart';
import 'package:base_flutter/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:base_flutter/src/router/route.dart';
import 'package:image_picker/image_picker.dart';

class SignUpInformationScreen extends StatefulWidget {
  const SignUpInformationScreen({super.key});

  @override
  State<SignUpInformationScreen> createState() =>
      _SignUpInformationScreenState();
}

class _SignUpInformationScreenState
    extends State<SignUpInformationScreen> {
  final _stepOneFormKey = GlobalKey<FormState>();
  final _stepTwoFormKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  DateTime? _dateOfBirth;
  String? _gender;
  XFile? _avatar;

  int _currentStep = 0;

  @override
  void dispose() {
    _fullNameController.dispose();
    _nicknameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // ======================================
  // CAMERA / GALLERY
  // ======================================

  Future<void> _pickAvatar(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (image == null) return;

      final size = await image.length();

      if (!mounted) return;

      if (size > 5 * 1024 * 1024) {
        _showMessage(context.loc.avatarTooLarge);
        return;
      }

      setState(() {
        _avatar = image;
      });
    } catch (error) {
      debugPrint('Pick avatar failed: $error');

      if (!mounted) return;

      _showMessage(context.loc.somethingWentWrong);
    }
  }

  // ======================================
  // AVATAR OPTIONS BOTTOM SHEET
  // ======================================

  void _showAvatarOptions() {
    final colors = context.colorScheme;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Chọn ảnh đại diện',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20.h),

                ListTile(
                  leading: Icon(
                    Icons.camera_alt_rounded,
                    color: colors.primary,
                  ),
                  title: const Text('Chụp ảnh'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickAvatar(ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.photo_library_rounded,
                    color: colors.primary,
                  ),
                  title: const Text('Chọn từ thư viện'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickAvatar(ImageSource.gallery);
                  },
                ),

                SizedBox(height: 12.h),
              ],
            ),
          ),
        );
      },
    );
  }

  // ======================================
  // DATE OF BIRTH
  // ======================================

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day),
    );

    if (!mounted || pickedDate == null) return;

    setState(() {
      _dateOfBirth = pickedDate;
    });
  }

  // ======================================
  // NEXT STEP
  // ======================================

  void _nextStep() {
    final valid =
        _stepOneFormKey.currentState?.validate() ?? false;

    if (!valid) return;

    if (_avatar == null ||
        _dateOfBirth == null ||
        _gender == null) {
      _showMessage(context.loc.requiredField);
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _currentStep = 1;
    });
  }

  // ======================================
  // PREVIOUS STEP
  // ======================================

  void _previousStep() {
    FocusScope.of(context).unfocus();

    setState(() {
      _currentStep = 0;
    });
  }

  // ======================================
  // SUBMIT PROFILE
  // ======================================

  void _submit() {
    final authBloc = context.read<AuthBloc>();

    if (authBloc.state is AuthLoading) return;

    final valid = _stepTwoFormKey.currentState?.validate() ?? false;
    if (!valid) return;

    final avatar = _avatar;
    final dateOfBirth = _dateOfBirth;
    final gender = _gender;

    if (avatar == null || dateOfBirth == null || gender == null) {
      _showMessage(context.loc.requiredField);
      return;
    }

    final profile = ProfileInformation(
      fullName: _fullNameController.text.trim(),
      dateOfBirth: dateOfBirth,
      gender: gender,
      nickname: _nicknameController.text.trim(),
      address: _addressController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      avatarPath: avatar.path,
    );

    FocusScope.of(context).unfocus();

authBloc.add(
  UpdateProfileEvent(
    information: profile,
  ),
);
  }

  // ======================================
  // AVATAR WIDGET
  // ======================================

  Widget _buildAvatar() {
    final colors = context.colorScheme;
    final loc = context.loc;

    return Column(
      children: [
        InkWell(
          onTap: _showAvatarOptions,
          customBorder: const CircleBorder(),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 44.r,
                backgroundColor: colors.primaryContainer,
                backgroundImage: _avatar == null
                    ? null
                    : FileImage(File(_avatar!.path)),
                child: _avatar == null
                    ? Icon(
                        Icons.person_rounded,
                        size: 44.r,
                        color: colors.primary,
                      )
                    : null,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: colors.primary,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 15.r,
                    color: colors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          loc.chooseAvatar,
          style: context.textTheme.bodySmall?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ======================================
  // DATE PICKER WIDGET
  // ======================================

  Widget _buildDateOfBirthField() {
    final loc = context.loc;
    final colors = context.colorScheme;

    final selectedDate = _dateOfBirth == null
        ? loc.dateOfBirthHint
        : '${_dateOfBirth!.day.toString().padLeft(2, '0')}/'
          '${_dateOfBirth!.month.toString().padLeft(2, '0')}/'
          '${_dateOfBirth!.year}';

    return InkWell(
      onTap: _selectDateOfBirth,
      borderRadius: BorderRadius.circular(12.r),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: loc.dateOfBirth,
          suffixIcon: const Icon(
            Icons.calendar_month_rounded,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          selectedDate,
          style: context.textTheme.bodyLarge?.copyWith(
            color: _dateOfBirth == null
                ? colors.onSurfaceVariant
                : colors.onSurface,
          ),
        ),
      ),
    );
  }

  // ======================================
  // STEP ONE
  // ======================================

  Widget _buildStepOne() {
    final loc = context.loc;

    return Form(
      key: _stepOneFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvatar(),

          SizedBox(height: 24.h),

          InputField.name(
            controller: _fullNameController,
            labelText: loc.fullName,
            hintText: loc.fullNameHint,
            textInputAction: TextInputAction.done,
          ),

          SizedBox(height: 16.h),

          _buildDateOfBirthField(),

          SizedBox(height: 16.h),

          DropdownButtonFormField<String>(
            value: _gender,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: loc.gender,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            items: [
              DropdownMenuItem(
                value: 'MALE',
                child: Text(loc.male),
              ),
              DropdownMenuItem(
                value: 'FEMALE',
                child: Text(loc.female),
              ),
              DropdownMenuItem(
                value: 'OTHER',
                child: Text(loc.other),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _gender = value;
              });
            },
            validator: (value) {
              return value == null
                  ? loc.requiredField
                  : null;
            },
          ),
        ],
      ),
    );
  }

  // ======================================
  // STEP TWO
  // ======================================

  Widget _buildStepTwo() {
    final loc = context.loc;

    return Form(
      key: _stepTwoFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputField(
            controller: _nicknameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            lableText: loc.nickname,
            hintText: loc.nicknameHint,
            validator: Validators.required,
          ),

          SizedBox(height: 16.h),

          InputField(
            controller: _addressController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.streetAddress,
            lableText: loc.address,
            hintText: loc.addressHint,
            validator: Validators.required,
          ),

          SizedBox(height: 16.h),

          InputField.phone(
            controller: _phoneNumberController,
            labelText: loc.phoneNumber,
            hintText: loc.phoneNumberHint,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  // ======================================
  // STEP PROGRESS
  // ======================================

  Widget _buildProgressIndicator() {
    final colors = context.colorScheme;

    return Row(
      children: List.generate(2, (index) {
        final isActive = index <= _currentStep;

        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            height: 5.h,
            decoration: BoxDecoration(
              color: isActive
                  ? colors.primary
                  : colors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }),
    );
  }

  // ======================================
  // NAVIGATION BUTTONS
  // ======================================

  Widget _buildButtons(bool isLoading) {
    final loc = context.loc;
    final colors = context.colorScheme;

    if (_currentStep == 0) {
      return SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            elevation: 0,
            shape: const StadiumBorder(),
          ),
          child: Text(
            loc.next,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.onPrimary,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52.h,
            child: OutlinedButton(
              onPressed: isLoading ? null : _previousStep,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.onSurface,
                side: BorderSide(color: colors.outline, width: 1.2),
                shape: const StadiumBorder(),
              ),
              child: Text(
                loc.back,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
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
                      loc.complete,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.onPrimary,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  // ======================================
  // BUILD
  // ======================================

 @override
Widget build(BuildContext context) {
  return BlocConsumer<AuthBloc, AuthState>(
    listenWhen: (previous, current) =>
        current is ProfileUpdated || current is AuthError,
    listener: (context, state) {
      if (state is ProfileUpdated) {
        AppRoute.home.go(context);
      }

      if (state is AuthError) {
        _showMessage(state.message);
      }
    },
    builder: (context, state) {
      final isLoading = state is AuthLoading;

      final colors = context.colorScheme;
      final textTheme = context.textTheme;
      final loc = context.loc;

      return Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 350.w),
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
              vertical: 26.h,
            ),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: colors.brightness == Brightness.dark
                    ? colors.outline
                    : colors.outlineVariant,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withValues(
                    alpha: colors.brightness == Brightness.dark ? 0.35 : 0.18,
                  ),
                  blurRadius: 24.r,
                  offset: Offset(0, 10.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  loc.profileInformation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: colors.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  loc.profileInformationDescription,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 24.h),

                _buildProgressIndicator(),

                SizedBox(height: 28.h),

                AnimatedSize(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  alignment: Alignment.topCenter,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.08, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _currentStep == 0
                        ? KeyedSubtree(
                            key: const ValueKey('stepOne'),
                            child: _buildStepOne(),
                          )
                        : KeyedSubtree(
                            key: const ValueKey('stepTwo'),
                            child: _buildStepTwo(),
                          ),
                  ),
                ),

                SizedBox(height: 28.h),

                _buildButtons(isLoading),
              ],
            ),
          ),
        ),
      );
    },
  );
}
}
