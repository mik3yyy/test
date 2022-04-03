import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_appbar.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class WithdrawalSuccessfulScreen extends StatelessWidget {
  const WithdrawalSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: CustomWalletAppBarWithChild(
          containerOneHeight: 170.h,
          containerTwoHeight: 900.h,
          containerTwoMargin: 130.h,
          child1: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        Space(4.h),
                        Text(
                          'Withdraw money',
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
          child2: Padding(
            padding: const EdgeInsets.fromLTRB(23.0, 60.0, 23.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Payment successful',
                      style: AppText.header3(
                        context,
                        AppColors.appColor,
                        20.sp,
                      ),
                    ),
                    Space(30.h),
                    Text(
                      'N5,000',
                      style: AppText.header3(
                        context,
                        AppColors.appColor,
                        16.sp,
                      ),
                    ),
                  ],
                ),
                Space(10.h),
                Image.asset(AppImage.image4),
                Space(32.h),
                CustomButton(
                  buttonHeight: 98.h,
                  buttonText: 'Home',
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
