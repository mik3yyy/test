import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

import '../app text theme/app_text_theme.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput(
      {Key? key,
      required this.controller,
      this.autovalidateMode,
      required this.validator,
      this.labelText,
      required this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.inputFormatters,
      this.enabled,
      this.textLength,
      this.readOnly = false,
      required this.capitalization,
      this.focusNode,
      this.keyboardType})
      : super(key: key);

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool readOnly;
  final Widget? prefixIcon;

  final TextInputType? keyboardType;
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?) validator;
  final TextCapitalization capitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? textLength;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enabled,
        controller: controller,
        cursorColor: Colors.blue,
        focusNode: focusNode,
        readOnly: readOnly,
        maxLength: textLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autovalidateMode: autovalidateMode,
        textCapitalization: capitalization,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,

          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appColor),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.h),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: labelText,
          hintStyle: AppText.label(context, Colors.black38),
          // border: const OutlineInputBorder(borderSide: BorderSide())
        ),
        validator: validator);
  }
}
