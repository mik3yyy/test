import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';

class FriendsTab extends HookConsumerWidget {
  FriendsTab({Key? key}) : super(key: key);

  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context, ref) {
    final transactionPinToggle = ref.watch(passwordToggleStateProvider.state);
    final fistNameController = useTextEditingController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.appColor.withOpacity(0.1),
            height: 190.h,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space(20.h),
                  Text(
                    'Transfer to',
                    style: AppText.body2(context, Colors.black, 18.sp),
                  ),
                  Space(20.h),
                  SizedBox(
                    height: 95,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: 80.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                      width: 5, color: Colors.grey.shade300)),
                            ),
                            Space(10.h),
                            Text(
                              'Wale Ahmed',
                              style:
                                  AppText.body2(context, Colors.black, 16.sp),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 20.w);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Space(25.h),
          Padding(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make Transfer from your dollar account',
                  style: AppText.body2(context, AppColors.appColor, 19.sp),
                ),
                Space(40.h),
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
                Space(35.h),
                Container(
                  height: 80.h,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.appColor.withOpacity(0.05),
                  child: Row(
                    children: [
                      Space(20.w),
                      const Icon(
                        Icons.security,
                        size: 30,
                      ),
                      Space(15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'For security reasons',
                            style:
                                AppText.header2(context, Colors.black, 20.sp),
                          ),
                          const Space(2),
                          Text(
                            'Enter transaction PIN',
                            style:
                                AppText.body2Bold(context, Colors.black, 23.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Space(20.h),
                EditForm(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Enter Transaction Pin',
                  keyboardType: TextInputType.text,
                  // textAlign: TextAlign.start,
                  controller: fistNameController,
                  obscureText: transactionPinToggle.state,
                  validator: (value) => validatePassword(value),
                  suffixIcon: SizedBox(
                    width: 55.w,
                    child: GestureDetector(
                      onTap: () {
                        transactionPinToggle.state =
                            !transactionPinToggle.state;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.h),
                        child: Icon(
                          transactionPinToggle.state
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
                Space(20.h),
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
                Space(80.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
