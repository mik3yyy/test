import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/app text theme/app_text_theme.dart';

class EditForm extends StatelessWidget {
  const EditForm(
      {Key? key,
      required this.controller,
      this.autovalidateMode,
      required this.validator,
      this.labelText,
      required this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.focusNode,
      // this.textAlign,
      this.onTap,
      this.readOnly = false,
      this.enabled,
      this.inputter,
      this.textLength,
      this.keyboardType,
      this.onEditingComplete,
      this.onChanged})
      : super(key: key);

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  // final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?) validator;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final int? textLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: onTap,
        inputFormatters: inputter,
        enabled: enabled,
        readOnly: readOnly,
        maxLength: textLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        controller: controller,
        cursorColor: Colors.blue,
        autovalidateMode: autovalidateMode,
        obscureText: obscureText,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,

          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.h),
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          labelStyle: AppText.body2(context, Colors.black38, 20.sp),
          // border: const OutlineInputBorder(borderSide: BorderSide())
        ),
        validator: validator);
  }
}
