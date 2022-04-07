import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class WalletViewCustomTextFormField extends StatelessWidget {
  final String? hinText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  const WalletViewCustomTextFormField({
    this.hinText,
    this.prefixIcon,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
        prefixIcon: prefixIcon,
        hintText: hinText,
        filled: true,
        fillColor: AppColors.whiteColor,
        hintStyle: AppText.body3(
          context,
          AppColors.faqHintTextColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromRGBO(216, 216, 216, 0.8),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromRGBO(216, 216, 216, 0.8),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }
}
