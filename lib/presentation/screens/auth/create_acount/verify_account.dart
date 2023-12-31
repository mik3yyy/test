import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/verify_account_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/verify_account_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/create_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/verify_account_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../vm/resend_otp_vm.dart';

class VerifyAccountScreen extends HookConsumerWidget {
  final String emailAdress;
  VerifyAccountScreen({Key? key, required this.emailAdress}) : super(key: key);
  final toggleStateProvider = StateProvider<bool>((ref) {
    return false;
  });

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(verifyAccountProvider);

    final emailController = useTextEditingController(text: emailAdress);
    final verifyController = useTextEditingController();

    var toggleState = ref.watch(toggleStateProvider);
    ref.listen<RequestState>(verifyAccountProvider, (_, value) {
      if (value is Loading) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success<VerifyRes>) {
        context.navigate(const CreatePasswordScreen());
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Account Verified",
        );
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    ref.listen<RequestState>(resendOtpProvider, (T, value) {
      if (value is Success<bool>) {
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Check Your Mail for Verification Code",
        );
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
              child: Column(
                children: [
                  Text(
                    "Verify Account!",
                    style: AppText.header3(context, AppColors.appColor, 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  Space(12.h),
                  Text(
                    "Enter 4-digit code we have sent to",
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  Space(5.h),
                  Text(
                    emailAdress,
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  Space(120.h),
                  PinCodeTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'otp is required';
                      }
                      if (value.length < 4) {
                        return null;
                      }

                      // validator has to return something :)
                      return null;
                    },
                    pinTheme: PinTheme(
                      inactiveColor: AppColors.hintColor,
                      inactiveFillColor: AppColors.hintColor,
                      activeColor: AppColors.greenColor,
                      shape: PinCodeFieldShape.underline,
                      selectedColor: AppColors.greenColor,
                      activeFillColor: AppColors.greenColor,
                    ),
                    controller: verifyController,
                    cursorColor: AppColors.greenColor,
                    hintCharacter: "*",
                    autoDismissKeyboard: true,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    appContext: context,
                    length: 4,
                    onCompleted: (value) {
                      ref.read(toggleStateProvider.notifier).state =
                          toggleState == false ? true : false;
                      toggleState = true;
                    },
                    onChanged: (String value) {},
                  ),
                  Space(80.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Didn’t receive the code?',
                          style: AppText.body4(context, AppColors.hintColor)),
                      InkWell(
                        onTap: () {
                          ref
                              .read(resendOtpProvider.notifier)
                              .resendOtp(emailAdress);
                        },
                        child: Text(
                          ' Resend Code',
                          style: AppText.body4(context, AppColors.appColor),
                        ),
                      ),
                    ],
                  ),
                  Space(160.h),
                  CustomButton(
                    buttonWidth: 244.w,
                    buttonText: vm is Loading
                        ? loading(
                            Colors.white,
                          )
                        : buttonText(context, "Process"),
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: vm is Loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              var verifyAccount = VerifyAccount(
                                  emailPhone: emailController.text,
                                  verificationCode: verifyController.text);
                              ref
                                  .read(verifyAccountProvider.notifier)
                                  .verifyAccount(verifyAccount);
                            }
                          },
                  ),
                  Space(20.h),
                  Text('By clicking Proceed, you agree to our ',
                      style: AppText.body4(context, AppColors.hintColor)),
                  Space(5.h),
                  TextButton(
                      onPressed: () {
                        context.navigate(const AppWebView(
                          url: Constants.privacyPolicy,
                          successMsg: '',
                          webViewRoute: WebViewRoute.privacy,
                        ));
                      },
                      child: Text(
                        'Privacy Policy ',
                        style: AppText.body4(context, AppColors.appColor),
                      )),
                  Space(5.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
