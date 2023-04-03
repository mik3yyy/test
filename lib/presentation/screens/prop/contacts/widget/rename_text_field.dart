import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class RenameTextInput extends StatelessWidget {
  const RenameTextInput({
    Key? key,
    required this.controller,
    this.autovalidateMode,
    required this.validator,
    required this.onEditingComplete,
    this.labelText,
    this.onChanged,
    this.onTapOutside,
    this.inputFormatters,
    this.enabled,
    this.textLength,
    this.readOnly = false,
    this.focusNode,
  }) : super(key: key);

  final String? labelText;
  final bool? enabled;
  final bool readOnly;
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? textLength;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
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
        textCapitalization: TextCapitalization.words,
        inputFormatters: inputFormatters,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.name,
        onChanged: onChanged,
        style: AppText.header2(context, AppColors.appColor, 18.sp),
        onEditingComplete: onEditingComplete,
        onTapOutside: onTapOutside,
        decoration: InputDecoration(
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 4.h, horizontal: 0.h),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: labelText,
            hintStyle: AppText.label(context, Colors.black38),
            border: InputBorder.none),
        validator: validator);
  }
}
