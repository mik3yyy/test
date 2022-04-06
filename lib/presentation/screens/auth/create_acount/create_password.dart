import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/currency.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

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
                  "Create Password",
                  style: AppText.header3(context, AppColors.appColor, 20.sp),
                  textAlign: TextAlign.center,
                ),
                Space(12.h),
                Text(
                  "Create a Unique Kayndrexsphere",
                  style: AppText.header2(context, AppColors.appColor, 20.sp),
                  textAlign: TextAlign.center,
                ),
                Space(5.h),
                Text(
                  "Password",
                  style: AppText.header2(context, AppColors.appColor, 20.sp),
                  textAlign: TextAlign.center,
                ),
                Space(160.h),

                // password
                TextFormInput(
                  textAlign: TextAlign.start,
                  labelText: 'Password',
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
                Space(190.h),
                CustomButton(
                  buttonWidth: 244.w,
                  buttonText: 'Proceed',
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: () {
                    context.navigate(const CurrencyScreen());
                  },
                ),
                Space(30.h),
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          // onTap: () =>
                          // context.navigate(const VerifyAccountScreen()),
                          child: Text(
                            'Privacy Policy ',
                            style: AppText.body4(context, AppColors.appColor),
                          ),
                        ),
                      ),
                      TextSpan(
                          text: ' | ',
                          style: AppText.body4(context, AppColors.appColor)),
                      WidgetSpan(
                        child: InkWell(
                          // onTap: () =>
                          // context.navigate(const VerifyAccountScreen()),
                          child: Text(
                            ' Terms',
                            style: AppText.body4(context, AppColors.appColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
