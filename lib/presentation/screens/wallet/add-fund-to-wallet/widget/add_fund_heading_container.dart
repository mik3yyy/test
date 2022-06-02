import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class AddFundHeadingContainer extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double paddingLeft;
  const AddFundHeadingContainer({
    Key? key,
    required this.text,
    required this.textAlign,
    required this.paddingLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: paddingLeft, top: 4.w, bottom: 4.w),
      width: MediaQuery.of(context).size.width,
      height: 32.h,
      decoration: BoxDecoration(
        color: AppColors.textColor.withOpacity(0.05),
      ),
      child: Text(
        text,
        style: AppText.body6(
          context,
          AppColors.textColor.withOpacity(0.7),
          15.sp,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
