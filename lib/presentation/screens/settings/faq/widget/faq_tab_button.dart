import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class FaqTabButton extends StatelessWidget {
  final String icon;
  final String text;
  final Color bgColor;
  const FaqTabButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.w, bottom: 15.w, left: 15.w),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(6.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(icon),
          //MIght used the width later instead of mainaxis
          // Space(75.w),
          Text(
            text,
            style: AppText.body3(
              context,
              AppColors.whiteColor,
            ),
          ),
          const Space(0),
        ],
      ),
    );
  }
}
