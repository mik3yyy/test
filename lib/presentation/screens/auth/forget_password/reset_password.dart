import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';

import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/reset_password_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/alert_dialog.dart';

import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Data/constant/constant.dart';
import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  final String otpCode;
  final String emailPhone;
  ResetPasswordScreen({
    Key? key,
    required this.emailPhone,
    required this.otpCode,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(resetPasswordProvider);
    final confirmController = TextEditingController();
    final controller = TextEditingController();
    ref.listen<RequestState>(resetPasswordProvider, (T, value) {
      if (value is Success) {
        successAlart(
            context, "Your Password has been changed", "Continue to Dashboard");
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
            child: Form(
              key: formKey,
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
                    labelText: 'New Password',
                    controller: controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is requied";
                      }
                      if (value.length < 8) {
                        return 'Password must at least be 8 characters';
                      }
                      return null;
                    },
                    obscureText: false,
                    suffixIcon: const Icon(Icons.visibility_off),
                  ),
                  Space(32.h),

                  // confirm password
                  TextFormInput(
                    labelText: 'Confirm Password',
                    controller: confirmController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      } else if (controller.text != confirmController.text) {
                        return 'Password doesn\'t match';
                      }


                      // validator has to return something :)
                      return null;
                    },
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
                    onPressed: vm is Loading
                        ? null
                        : () async {
                            final pref = await SharedPreferences.getInstance();
                            final email = pref.getString(Constants.email);


                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(resetPasswordProvider.notifier)
                                  .resetPassword(
                                    email.toString(),
                                    otpCode,
                                    controller.text,
                                    confirmController.text,
                                  );
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
