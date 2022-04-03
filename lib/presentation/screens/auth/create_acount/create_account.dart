import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
          child: Column(
            children: [
              Text(
                "Create Account!",
                style: AppText.header3(context, AppColors.appColor, 20.sp),
                textAlign: TextAlign.center,
              ),
              Space(12.h),
              Text(
                "Please, provide the following details",
                style: AppText.header2(context, AppColors.appColor),
                textAlign: TextAlign.center,
              ),
              Space(60.h),

              //first name
              TextFormField(
                decoration: const InputDecoration(hintText: "First Name"),
              ),
              Space(32.h),

              //last name
              TextFormField(
                decoration: const InputDecoration(hintText: "Last Name"),
              ),
              Space(32.h),

              // email address
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Email address or Phone Number"),
              ),
              Space(77.h),
              Text(
                "By creating your account you agree with our",
                style: AppText.body4(context, AppColors.hintColor),
                textAlign: TextAlign.center,
              ),
              Space(5.h),
              Text(
                "Terms and Conditions",
                style: AppText.body4(context, AppColors.hintColor),
                textAlign: TextAlign.center,
              ),
              Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  value: false,
                  onChanged: (value) {}),
              Space(50.h),
              CustomButton(
                buttonWidth: 244.w,
                buttonText: 'Sign Up',
                bgColor: AppColors.appColor,
                borderColor: AppColors.appColor,
                textColor: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      )),
    );
  }
}
