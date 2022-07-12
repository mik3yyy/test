import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class AppFundContainerWidget extends StatelessWidget {
  final String image;
  final String text;
  final void Function()? onTap;
  const AppFundContainerWidget({
    Key? key,
    required this.image,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70.h,
        padding: EdgeInsets.only(top: 22.w, bottom: 22.w),
        margin: EdgeInsets.only(left: 25.w, right: 25.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            Space(9.w),
            Text(
              text,
              style: AppText.body2Medium(
                context,
                AppColors.textColor,
                20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
