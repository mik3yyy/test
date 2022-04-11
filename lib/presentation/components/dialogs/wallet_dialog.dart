import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../app image/app_image.dart';
import '../app text theme/app_text_theme.dart';

class WalletDialog {
  static void transactionDialog(BuildContext context,
      {required dynamic transfered,
      required dynamic received,
      required String details}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: SizedBox(
                height: 240.h,
                width: 400.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close_outlined,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    Space(15.h),
                    Row(
                      children: [
                        Text(
                          'Amount transferred:  ',
                          style:
                              AppText.body2(context, AppColors.appColor, 20.sp),
                        ),
                        Text(
                          transfered,
                          style:
                              AppText.body2(context, AppColors.appColor, 20.sp),
                        ),
                      ],
                    ),
                    Space(20.h),
                    Row(
                      children: [
                        Text(
                          'Amount Received:  ',
                          style:
                              AppText.body2(context, AppColors.appColor, 20.sp),
                        ),
                        Text(
                          received,
                          style:
                              AppText.body2(context, AppColors.appColor, 20.sp),
                        ),
                      ],
                    ),
                    Space(20.h),
                    Text(
                      'Transfer detail:',
                      style:
                          AppText.header1(context, AppColors.appColor, 20.sp),
                    ),
                    Space(10.h),
                    Text(
                      details,
                      style: AppText.body2(context, AppColors.appColor, 20.sp),
                    ),
                    Space(20.h),
                    Center(
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Image.asset(AppImage.successIcon),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
