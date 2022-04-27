import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forgot_password_otp.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/forgot_password_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(forgotPasswordProvider);
    final controller = TextEditingController();
    ref.listen<RequestState>(forgotPasswordProvider, (T, value) {
      if (value is Success) {
        context.navigate(ForgetPasswordOTPScreen(
          emailAdress: controller.text,
        ));
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Please Check Your Mail or SMS for Verification Code",
        );
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitWave(
          color: AppColors.appColor,
          size: 50.0,
        ),
      ),
      child: Scaffold(
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
                          "Forgot Password",
                          style: AppText.header3(
                              context, AppColors.appColor, 20.sp),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Space(19.h),
                    Text(
                      "Forgot your Kayndrexsphere Password?",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),

                    Space(180.h),

                    // phone number or email
                    TextFormInput(
                      labelText: 'Email Address or Phone Number',
                      controller: controller,
                      focusNode: fieldFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email address or Phone Number is required";
                        }
                        if (!RegExp(
                                "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                            .hasMatch(value)) {
                          return 'Please input a valid email address';
                        }

                        return null;
                      },
                      obscureText: false,
                    ),

                    Space(260.h),
                    CustomButton(
                      buttonWidth: double.infinity,
                      buttonText: vm is Loading ? "Sending OTP..." : "Send",
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: vm is Loading
                          ? null
                          : () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              pref.setString(Constants.email, controller.text);
                              if (formKey.currentState!.validate()) {
                                fieldFocusNode.unfocus();
                                ref
                                    .read(forgotPasswordProvider.notifier)
                                    .forgotPassword(controller.text);
                                print(controller.text);
                                context.loaderOverlay.show();
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
