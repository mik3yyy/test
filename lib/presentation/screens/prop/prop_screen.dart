import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class PropScreen extends StatelessWidget {
  const PropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WalletViewWidget(
        appBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [],
              ),
            ],
          ),
        ),
        child: Container(
          height: 850.h,
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w, bottom: 39.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Messages",
                style: AppText.body3(
                  context,
                  AppColors.appColor,
                ),
              ),
              Column(
                children: [
                  Image.asset(AppImage.noMessage),
                  Space(17.h),
                  Text(
                    "No Messages",
                    style: AppText.body3(
                      context,
                      AppColors.appColor,
                    ),
                  ),
                  Space(8.h),
                  Text(
                    "Connect with friends, transfer money on Kayndrexsphere!",
                    style: AppText.body3(
                      context,
                      AppColors.referFriendBorderColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              CustomButton(
                borderColor: AppColors.appColor,
                buttonText: "Start Messaging",
                bgColor: AppColors.appColor,
                textColor: AppColors.whiteColor,
                buttonWidth: double.infinity,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
