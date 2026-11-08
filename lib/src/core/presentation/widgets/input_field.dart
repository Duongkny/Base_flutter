import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/src/core/extension/context.dart';

import '../../utils/validators.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.hintText,
    this.lableText,
    this.prefixIcon,
    this.autofillHints,
    this.validator,
    this.onFieldSubmitted,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.onChanged,
    super.key,
  });
  InputField.dob({
    required TextEditingController controller,
    String? errorText,
    String hintText = 'Date of Birth',
    Widget? prefixIcon,
    TextInputAction textInputAction = TextInputAction.next,
    Key? key,
  }) : this(
         key: key,
         controller: controller,
         textInputAction: textInputAction,
         keyboardType: TextInputType.datetime,
         errorText: errorText,
         hintText: hintText,
         prefixIcon: prefixIcon,
         inputFormatters: [DateInputFormatter()],
         autofillHints: const [
           AutofillHints.birthdayDay,
           AutofillHints.birthdayMonth,
           AutofillHints.birthdayYear,
         ],
         validator: Validators.required,
       );

const InputField.name({
  required TextEditingController controller,
  String? errorText,
  String? labelText,
  String hintText = 'Name',
  Widget? prefixIcon,
  FormFieldValidator<String>? validator,
  TextInputAction textInputAction = TextInputAction.next,
  Key? key,
}) : this(
       key: key,
       controller: controller,
       textInputAction: textInputAction,
       keyboardType: TextInputType.name,
       errorText: errorText,
       lableText: labelText,
       hintText: hintText,
       prefixIcon: prefixIcon,
       autofillHints: const [AutofillHints.name],
       validator: validator ?? Validators.name,
     );

  const InputField.number({
    required TextEditingController controller,
    String? errorText,
    String hintText = 'Number',
    Widget? prefixIcon,
    TextInputAction textInputAction = TextInputAction.next,
    Key? key,
  }) : this(
         key: key,
         controller: controller,
         textInputAction: textInputAction,
         keyboardType: TextInputType.number,
         errorText: errorText,
         hintText: hintText,
         prefixIcon: prefixIcon,
         autofillHints: const [AutofillHints.name],
         validator: Validators.required,
       );

const InputField.phone({
  required TextEditingController controller,
  String? errorText,
  String? labelText,
  String hintText = 'Phone Number',
  Widget? prefixIcon,
  TextInputAction textInputAction = TextInputAction.next,
  Key? key,
}) : this(
       key: key,
       controller: controller,
       textInputAction: textInputAction,
       keyboardType: TextInputType.phone,
       errorText: errorText,
       lableText: labelText,
       hintText: hintText,
       prefixIcon: prefixIcon,
       autofillHints: const [AutofillHints.telephoneNumber],
       validator: Validators.phone,
     );
     
  const InputField.email({
    required TextEditingController controller,
    String? errorText,
    String? labelText,
    String hintText = 'Email',
    Widget? prefixIcon,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
    Key? key,
  }) : this(
         key: key,
         controller: controller,
         textInputAction: textInputAction,
         keyboardType: TextInputType.emailAddress,
         errorText: errorText,
         lableText: labelText,
         hintText: hintText,
         prefixIcon: prefixIcon,
         autofillHints: const [AutofillHints.email],
         validator: Validators.email,
         onFieldSubmitted: onFieldSubmitted,
       );

  const InputField.password({
    required TextEditingController controller,
    String? errorText,
    String? labelText = 'Password',
    String hintText = 'Password',
    Widget? prefixIcon,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
    Key? key,
  }) : this(
         key: key,
         controller: controller,
         textInputAction: textInputAction,
         keyboardType: TextInputType.visiblePassword,
         autofillHints: const [AutofillHints.password],
         errorText: errorText,
         lableText: labelText,
         hintText: hintText,
         prefixIcon: prefixIcon,
         validator: Validators.password,
         onFieldSubmitted: onFieldSubmitted,
       );

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? errorText;
  final String? lableText;
  final String? hintText;
  final Widget? prefixIcon;
  final List<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText;
  late bool _isPassword;

  @override
  void initState() {
    _isPassword = widget.keyboardType == TextInputType.visiblePassword;
    _obscureText = _isPassword;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    if (oldWidget.keyboardType != widget.keyboardType) {
      _isPassword = widget.keyboardType == TextInputType.visiblePassword;
      _obscureText = _isPassword;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final validator =
        widget.validator ?? Validators.getValidator(widget.keyboardType);

    final colors = context.colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscureText,
      validator: validator,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        filled: true,
        fillColor: isDark ? colors.surfaceContainerLow : colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          borderSide: BorderSide(
            color: colors.outline,
            width: 1.2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          borderSide: BorderSide(
            color: colors.outline,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          borderSide: BorderSide(
            color: colors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          borderSide: BorderSide(color: colors.error, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        hintStyle: TextStyle(
          color: colors.onSurfaceVariant,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          color: colors.onSurfaceVariant,
          fontSize: 14.sp,
        ),
        errorText: widget.errorText,
        hintText: widget.hintText,
        labelText: widget.lableText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: colors.onSurface,
        suffixIconColor: colors.onSurface,
        suffixIcon: _isPassword
            ? IconButton(
                autofocus: false,
                onPressed: () => setState(() => _obscureText = !_obscureText),
                icon: _obscureText
                    ? Icon(
                        Icons.visibility_off_outlined,
                        size: 22.r,
                        color: colors.onSurface,
                      )
                    : Icon(
                        Icons.visibility_outlined,
                        size: 22.r,
                        color: colors.onSurface,
                      ),
              )
            : null,
      ),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += digitsOnly[i];
    }
    if (formatted.length > 10) {
      formatted = formatted.substring(0, 10);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}