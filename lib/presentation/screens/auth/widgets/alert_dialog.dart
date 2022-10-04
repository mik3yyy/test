import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/color/value.dart';

Future<dynamic> successAlart(
    BuildContext context, String text, String buttonText) {
  return showDialog(
    barrierDismissible: false,
    useSafeArea: false,
    barrierColor: Colors.black12,
    context: context,
    builder: (BuildContext context) => AlertDialog(
        content: Padding(
      padding: EdgeInsets.all(20.h),
      child: SizedBox(
        height: 300.h,
        child: Column(
          children: [
            const Image(
              image: AssetImage(AppImage.successIcon),
            ),
            Space(20.h),
            Text(
              'Success!',
              style: AppText.body4(context, AppColors.appColor),
            ),
            Space(20.h),
            Text(
              text,
              style: AppText.body2(context, AppColors.appColor, 16.sp),
            ),
            Space(5.h),
            Text(
              'successfully',
              style: AppText.body4(context, AppColors.appColor),
            ),
            Space(24.h),
            // GestureDetector(
            //   onTap: () => navigator.key.currentContext!
            //       .navigate(MainScreen(menuScreenContext: context)),
            //   child: CustomButton(
            //     buttonText: buttonText(context, "Sign in"),
            //     bgColor: AppColors.appColor,
            //     textColor: AppColors.whiteColor,
            //     buttonWidth: double.infinity,
            //     borderColor: AppColors.appColor,
            //   ),
            // )
          ],
        ),
      ),
    )),
  );
}
