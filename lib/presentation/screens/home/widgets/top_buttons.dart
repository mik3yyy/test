import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class TopButtons extends StatelessWidget {
  final String title;
  final String image;
  final Color firstColor;
  final Color secondColor;

  final void Function()? onPressed;
  const TopButtons(
      {Key? key,
      required this.title,
      required this.image,
      required this.firstColor,
      required this.secondColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 120.h,
        width: 110.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          // color: AppColors.appColor,
          gradient: RadialGradient(
            colors: [firstColor, secondColor],
            radius: 0.75,
            focal: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space(5.h),
            SvgPicture.asset(
              image,
              color: Colors.white,
              height: 30.h,
              width: 30.w,
            ),
            Space(25.h),
            Text(
              title,
              style: AppText.header2(context, Colors.white, 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
