import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

InputDecoration fieldInputDecoration(
    {String? labelText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? hintText,
    EdgeInsetsGeometry? contentPadding}) {
  return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      focusColor: AppColors.appColor,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: const TextStyle(color: AppColors.hintColor),
      hintStyle: TextStyle(color: AppColors.appColor.withOpacity(0.20)),
      errorStyle: const TextStyle(),
      errorMaxLines: 4,
      helperMaxLines: 4,
      contentPadding: contentPadding,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      errorBorder: InputBorder.none);
}
