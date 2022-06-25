import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/create_account.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/create_account_phno.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/color/value.dart';
import '../../../utils/widget_spacer.dart';
import '../sign_in/sign_in.dart';

class ChooseAccount extends StatelessWidget {
  const ChooseAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
          child: Column(
            children: [
              Text(
                "Create Account!",
                style: AppText.header3(context, AppColors.appColor, 20.sp),
                textAlign: TextAlign.center,
              ),
              Space(33.h),
              Text(
                "You can create an account with any of the following options listed below. ",
                style: AppText.header2(context, AppColors.appColor, 20.sp),
                textAlign: TextAlign.center,
              ),
              Space(120.h),
              AccountRow(
                icon: Icons.phone,
                text: "Sign up with phone number",
                ontap: () => context.navigate(CreatePhoneAccount()),
              ),
              Space(50.h),
              AccountRow(
                ontap: () => context.navigate(CreateAccountScreen()),
                icon: Icons.mail,
                text: "Sign up with email",
              ),
              Space(50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Already have an account? ',
                      style: AppText.body4(context, AppColors.hintColor)),
                  InkWell(
                    onTap: () => context.navigate(SigninScreen()),
                    child: Text(
                      ' Sign In',
                      style: AppText.body4(context, AppColors.appColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountRow extends StatelessWidget {
  const AccountRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.ontap,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 90.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(width: 1.h, color: AppColors.textColor),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 40.w),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.textColor,
              ),
              Space(10.w),
              Text(
                text,
                style: AppText.header2(context, AppColors.textColor, 20.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
