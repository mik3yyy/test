import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';

class FriendsTab extends HookConsumerWidget {
  FriendsTab({Key? key}) : super(key: key);

  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context, ref) {
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space(10.h),
          Center(
            child: Text(
              'Make Transfer from your dollar account',
              style: AppText.body2(context, Colors.grey[400]!, 17.sp),
            ),
          ),
          Space(25.h),
          Text(
            'Enter the name of your friend',
            style: AppText.body2(context, AppColors.appColor, 19.sp),
          ),
          Space(5.h),
          const WalletTextField(
            labelText: 'Click to type',
            obscureText: false,
            color: Colors.white,
          ),
          Space(25.h),
          Text(
            'Enter Kayndrexsphere acc. No',
            style: AppText.body2(context, AppColors.appColor, 19.sp),
          ),
          Space(5.h),
          const WalletTextField(
            labelText: 'Click to type',
            obscureText: false,
            color: Colors.white,
          ),
          Space(25.h),
          Text(
            'Enter transfer amount',
            style: AppText.body2(context, AppColors.appColor, 19.sp),
          ),
          Space(5.h),
          const WalletTextField(
            labelText: 'Click to type',
            obscureText: false,
            color: Colors.white,
          ),
          Space(25.h),
          Text(
            'Currency',
            style: AppText.body2(context, AppColors.appColor, 19.sp),
          ),
          Space(5.h),
          WalletTextField(
            labelText: 'USD',
            obscureText: false,
            color: AppColors.appColor.withOpacity(0.05),
          ),
          Space(25.h),
          Center(
            child: Text(
              'Enter password',
              style: AppText.header3(context, AppColors.appColor, 20.sp),
            ),
          ),
          Space(5.h),
          Center(
            child: Text(
              'For security reasons, please enter your password',
              style: AppText.body2(context, AppColors.appColor, 16.sp),
            ),
          ),
          Space(5.h),
          WalletTextField(
            labelText: '',
            obscureText: true,
            color: Colors.white,
            suffixIcon: GestureDetector(
              onTap: () {
                togglePassword.state = !togglePassword.state;
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.h),
                child: Icon(
                  togglePassword.state
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.appColor,
                ),
              ),
            ),
          ),
          Space(10.h),
          CustomButton(
              buttonText: 'Transfer',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: () {
                // pushNewScreen(
                //   context,
                //   screen: const ViewAllWallet(),
                //   withNavBar: true, // OPTIONAL VALUE. True by default.
                //   pageTransitionAnimation: PageTransitionAnimation.fade,
                // );
                // context.navigate(AvailableBalance()

                // );
              },
              buttonWidth: MediaQuery.of(context).size.width),
          Space(7.h),
          Center(
            child: Text(
              'Cancel',
              style: AppText.header3(context, AppColors.appColor, 20.sp),
            ),
          ),
          Space(20.h),
        ],
      ),
    );
  }
}
