import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forgot_password_otp.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left,
                      size: 35.h,
                    ),
                    Space(85.w),
                    Text(
                      "Forgot Password",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Space(19.h),
                Text(
                  "Forgot your Kayndrexsphere Password?",
                  style: AppText.header2(context, AppColors.appColor, 20.sp),
                  textAlign: TextAlign.center,
                ),

                Space(180.h),

                // phone number or email
                TextFormInput(
                  textAlign: TextAlign.center,
                  labelText: 'Email Address or Phone Number',
                  controller: controller,
                  validator: (value) {},
                  obscureText: false,
                ),

                Space(260.h),
                CustomButton(
                  buttonWidth: double.infinity,
                  buttonText: 'Send',
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: () {
                    context.navigate(ForgetPasswordOTPScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
