import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/select_how_prop_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class PropScreen extends StatelessWidget {
  const PropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: SafeArea(
        child: Column(
          children: [
            const Space(20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const Space(130),
                  Text(
                    'Messages',
                    style: AppText.header2(context, Colors.white, 19.sp),
                  ),
                  const Space(0),
                ],
              ),
            ),
            const Space(50),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45.r)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Space(220.h),
                    Image.asset(AppImage.noMessage),
                    Space(17.h),
                    Text(
                      "No Messages",
                      style:
                          AppText.header2(context, AppColors.appColor, 19.sp),
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
                    Space(100.h),
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
            ))
          ],
        ),
      ),
    );
  }
}
