import 'package:flutter/material.dart';

import 'package:divmeds/designs/app_colors.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final Widget? label;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? error;
  final TextStyle? errorStyle;
  final String? errorText;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final String? prefixText;
  final String? suffixText;

  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final FormFieldValidator? validator;
  final bool? showCursor;

  const TextInputField({
    super.key,
    required this.hintText,
    this.prefixIconWidget,
    required this.obscureText,
    this.keyboardType,
    required this.controller,
    this.onTap,
    this.showCursor,
    this.validator,
    this.labelText,
    this.label,
    this.suffixIconWidget,
    this.prefix,
    this.suffix,
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixStyle,
    this.suffixStyle,
    this.prefixText,
    this.suffixText,
    this.labelStyle,
    this.error,
    this.errorStyle,
    this.errorText,
    this.floatingLabelStyle,
  });
  @override
  Widget build(BuildContext context) {
    // decoration elements
    const enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
    const focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        showCursor: showCursor,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefix: prefix,
          suffix: suffix,
          prefixIconColor: prefixIconColor,
          suffixIconColor: suffixIconColor,
          prefixStyle: prefixStyle,
          prefixText: prefixText,
          suffixStyle: suffixStyle,
          suffixText: suffixText,
          label: label,
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle,
          error: error,
          errorStyle: errorStyle,
          errorText: errorText,
          floatingLabelStyle: floatingLabelStyle,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          prefixIcon: prefixIconWidget,
          suffixIcon: suffixIconWidget,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          filled: true,
          fillColor: Colors.grey[200],
          focusColor: AppColors.divMedsColorBlue3,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
        validator: validator,
      ),
    );
  }
}
