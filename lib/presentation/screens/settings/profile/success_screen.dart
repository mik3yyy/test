import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/settings_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class VerificationSuccess extends HookConsumerWidget {
  const VerificationSuccess({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: Column(
            children: [
              Space(100.h),
              SvgPicture.asset(
                AppImage.successPin,
                height: 50.h,
                width: 50.w,
              ),
              Space(50.h),
              Stack(
                children: [
                  SvgPicture.asset(
                    AppImage.confetti,
                    height: 500.h,
                    width: 500.w,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                    child: Text(
                      'Congratulations',
                      style: AppText.header2(context, Colors.black, 25.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 140.h),
                    child: Text(
                      'You have been verified',
                      style: AppText.body2(context, Colors.black, 25.sp),
                    ),
                  ),
                ],
              ),
              Space(60.h),
              CustomButton(
                  buttonText: 'Continue',
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: () {
                    // context.navigate(MainScreen(menuScreenContext: context));
                    pushNewScreen(context,
                        screen: SettingScreen(
                            menuScreenContext: context,
                            onScreenHideButtonPressed: () {},
                            hideStatus: false),
                        pageTransitionAnimation: PageTransitionAnimation.fade);
                  },
                  buttonWidth: MediaQuery.of(context).size.width),
            ],
          ),
        ),
      ),
    );
  }
}
