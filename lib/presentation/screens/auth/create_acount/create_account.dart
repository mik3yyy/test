import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widget/widget.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
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
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  Space(60.h),

                  //first name

                  TextFormInput(
                      labelText: 'First Name',
                      controller: controller,
                      validator: (value) {},
                      obscureText: false),
                  Space(32.h),

                  //last name
                  TextFormInput(
                      labelText: 'Last Name',
                      controller: controller,
                      validator: (value) {},
                      obscureText: false),
                  Space(32.h),

                  // email address
                  TextFormInput(
                      labelText: 'Email address or Phone Number',
                      controller: controller,
                      validator: (value) {},
                      obscureText: false),
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
          ),
        ),
      ),
    );
  }
}
