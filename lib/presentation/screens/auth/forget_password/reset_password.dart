import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forgot_password_otp.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/transaction_pin/transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
                      "Reset Password",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Space(19.h),
                Text(
                  "Reset your Kayndrexsphere Password",
                  style: AppText.header2(context, AppColors.appColor, 20.sp),
                  textAlign: TextAlign.center,
                ),

                Space(120.h),

                // new password
                TextFormInput(
                  textAlign: TextAlign.start,
                  labelText: 'New Password',
                  controller: controller,
                  validator: (value) {},
                  obscureText: false,
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                Space(32.h),

                // confirm password
                TextFormInput(
                  textAlign: TextAlign.start,
                  labelText: 'Confirm Password',
                  controller: controller,
                  validator: (value) {},
                  obscureText: false,
                  suffixIcon: const Icon(Icons.visibility_off),
                ),

                Space(150.h),
                CustomButton(
                  buttonWidth: double.infinity,
                  buttonText: 'Continue',
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: () {
                    context.navigate(TransactionPinScreen());
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
