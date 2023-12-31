import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

import '../../../components/app text theme/app_text_theme.dart';

class WalletTextField extends StatelessWidget {
  const WalletTextField(
      {Key? key,
      this.controller,
      this.autovalidateMode,
      this.validator,
      this.labelText,
      this.keyboardType,
      required this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.inputFormatter,
      this.maxLines,
      this.enabled,
      this.readOnly = false,
      this.initialValue,
      required this.color,
      this.expands,
      this.onChanged,
      this.minLines})
      : super(key: key);

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color color;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final bool? enabled;
  final bool? readOnly;
  final String? initialValue;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        cursorColor: AppColors.appColor,
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatter,
        obscureText: obscureText,
        keyboardType: keyboardType,
        enabled: enabled,
        readOnly: readOnly!,
        onChanged: onChanged,
        onTap: onTap,
        initialValue: initialValue,
        // maxLines: maxLines,
        // minLines: minLines,
        // expands: expands!,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: color,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appColor),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: labelText,
            labelStyle: AppText.body2(context, Colors.grey[400]!, 19.sp),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: const BorderSide())),
        validator: validator);
  }
}
