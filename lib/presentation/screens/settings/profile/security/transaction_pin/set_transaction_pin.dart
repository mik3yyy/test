import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../../components/app image/app_image.dart';
import '../../../../../components/app text theme/app_text_theme.dart';

class SetTransactionPin extends HookConsumerWidget {
  SetTransactionPin({Key? key}) : super(key: key);

  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final togglePassword = ref.watch(passwordToggleStateProvider.state);
    final fistNameController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Security',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40.h,
              width: MediaQuery.of(context).size.width,
              color: AppColors.appColor.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.only(right: 230.w),
                child: Center(
                  child: Text(
                    'Set Transaction PIN',
                    style: AppText.body2(context, Colors.black54, 20.sp),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Column(
                children: [
                  EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Enter Transaction Pin',
                    keyboardType: TextInputType.text,
                    // textAlign: TextAlign.start,
                    controller: fistNameController,
                    obscureText: togglePassword.state,
                    validator: (value) => validatePassword(value),
                    suffixIcon: SizedBox(
                      width: 55.w,
                      child: GestureDetector(
                        onTap: () {
                          togglePassword.state = !togglePassword.state;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.h),
                          child: Icon(
                            togglePassword.state
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Space(30.h),
                  EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Re-enter Transaction Pin',
                    keyboardType: TextInputType.text,
                    // textAlign: TextAlign.start,
                    controller: fistNameController,
                    obscureText: togglePassword.state,
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter valid password.';
                      // }
                      validatePassword(value);

                      if (value != fistNameController.text) {
                        return 'Confirm password does not match.';
                      }
                      return null;
                    },
                    suffixIcon: SizedBox(
                      width: 55.w,
                      child: GestureDetector(
                        onTap: () {
                          togglePassword.state = !togglePassword.state;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.h),
                          child: Icon(
                            togglePassword.state
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Space(100.h),
                  Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.appColor.withOpacity(0.05),
                    child: Center(
                      child: Text(
                        'Unable to remember old password?',
                        style: AppText.header2(context, Colors.black38, 20.sp),
                      ),
                    ),
                  ),
                  Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.appColor.withOpacity(0.2),
                    child: Center(
                      child: Text(
                        'Reset',
                        style:
                            AppText.header2(context, AppColors.appColor, 20.sp),
                      ),
                    ),
                  ),
                  Space(150.h),
                  CustomButton(
                      buttonText: 'Save',
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: () {
                        // pushNewScreen(context,
                        //     screen: const VerifyScreen(),
                        //     pageTransitionAnimation:
                        //         PageTransitionAnimation.fade);
                      },
                      buttonWidth: MediaQuery.of(context).size.width),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
