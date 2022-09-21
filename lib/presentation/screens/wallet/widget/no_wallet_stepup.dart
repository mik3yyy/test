import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app image/app_image.dart';
import '../../../components/app text theme/app_text_theme.dart';
import 'wallet_appbar.dart';

class NoWalletSetUpWidget extends StatelessWidget {
  const NoWalletSetUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomWalletAppBarWithChild(
        containerOneHeight: 200.h,
        containerTwoHeight: 900.h,
        containerTwoMargin: 150.h,
        child1: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallets',
                        style: AppText.body3(
                          context,
                          Colors.white,
                        ),
                      ),
                      Space(4.h),
                      Text(
                        'Lets you view your wallets',
                        style: AppText.body3(
                          context,
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    Space(15.w),
                    const CircleAvatar(
                      radius: 18.0,
                      backgroundImage: AssetImage(
                        AppImage.image1,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        child2: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImage.bottomIcon2,
            ),
            Space(7.h),
            Text(
              'You have no wallet set up ',
              style: AppText.body1(
                context,
                AppColors.appColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
