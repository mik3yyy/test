import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/success_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';

class VerifyScreen extends HookConsumerWidget {
  bool isloading;
  VerifyScreen({Key? key, required this.isloading}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              Space(200.h),
              //* replace the container with a loading indicator here

              isloading == true
                  ? const CircularProgressIndicator()
                  : Container(
                      color: Colors.green,
                      height: 50,
                      width: 100,
                    ),
              Space(150.h),
              Text(
                'Just a moment',
                style: AppText.header2(context, Colors.white, 25.sp),
              ),
              Space(90.h),
              Text(
                'If you have any further queries,\nthen contact our support team',
                style: AppText.body2(context, Colors.white, 20.sp),
              ),
              Space(150.h),
              CustomButton(
                  buttonText: 'Go Back',
                  bgColor: AppColors.appColor,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  onPressed: () {
                    pushNewScreen(context,
                        screen: const VerificationSuccess(),
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
