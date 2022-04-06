import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/create_account.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/verify_account.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

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
                Text(
                  "Welcome Back!",
                  style: AppText.header3(context, AppColors.appColor, 20.sp),
                  textAlign: TextAlign.center,
                ),
                Space(12.h),
                Text(
                  "Continue to Sign in",
                  style: AppText.header2(context, AppColors.appColor, 20.sp),
                  textAlign: TextAlign.center,
                ),
                Space(180.h),

                //email
                TextFormInput(
                    labelText: 'Email or Phone Number',
                    controller: controller,
                    validator: (value) {},
                    obscureText: false),
                Space(32.h),

                //password
                TextFormInput(
                  labelText: 'Password',
                  controller: controller,
                  validator: (value) {},
                  obscureText: false,
                  suffixIcon: Icon(Icons.visibility),
                ),
                Space(32.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: AppText.body4(context, AppColors.appColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                Space(160.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      buttonWidth: 280.w,
                      buttonText: 'Sign In',
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: () {
                        context.navigate(const HomePage());
                      },
                    ),
                    Container(
                      height: 70.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: const Image(
                        image: AssetImage(
                          "images/fingerprint-3.png",
                        ),
                        color: AppColors.whiteColor,
                      ),
                    )
                  ],
                ),
                Space(20.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Don’t have an account? ',
                          style: AppText.body4(context, AppColors.appColor)),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => context.navigate(CreateAccountScreen()),
                          child: Text(
                            ' Sign up',
                            style: AppText.body4(context, AppColors.appColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
