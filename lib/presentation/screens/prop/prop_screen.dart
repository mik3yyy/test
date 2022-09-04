import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/select_how_prop_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_view_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class PropScreen extends StatelessWidget {
  const PropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GenericWidget(
        appbar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: const [],
          ),
        ),
        bgColor: AppColors.whiteColor,
        child: Container(
          height: 850.h,
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.appColor,
                    ),
                  ),
                  Text(
                    'Messages',
                    style: AppText.header2(context, AppColors.appColor, 19.sp),
                  ),
                  const Space(0),
                ],
              ),
              Space(220.h),
              Image.asset(AppImage.noMessage),
              Space(17.h),
              Text(
                "No Messages",
                style: AppText.header2(context, AppColors.appColor, 19.sp),
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
              Space(220.h),
              CustomButton(
                borderColor: AppColors.appColor,
                buttonText: "Start Messaging",
                bgColor: AppColors.appColor,
                textColor: AppColors.whiteColor,
                buttonWidth: double.infinity,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const SelectHowPropScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                  // context.navigate(const SelectHowPropScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
