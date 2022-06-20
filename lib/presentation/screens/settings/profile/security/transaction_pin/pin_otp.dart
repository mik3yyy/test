import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/resend_otp_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/verify_account_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/transaction_pin/reset_transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinOTPScreen extends HookConsumerWidget {
  final String emailAdress;
  PinOTPScreen({Key? key, required this.emailAdress}) : super(key: key);
  final toggleStateProvider = StateProvider<bool>((ref) {
    return false;
  });

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(verifyAccountProvider);

    final verifyController = useTextEditingController();
    var toggleState = ref.watch(toggleStateProvider);

    ref.listen<RequestState>(resendOtpProvider, (T, value) {
      if (value is Success) {
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.appColor.withOpacity(0.1),
                      child: Padding(
                        padding: EdgeInsets.only(left: 23.w, top: 7),
                        child: Text(
                          'Reset Transaction Pin',
                          style: AppText.body2(context, Colors.black54, 20.sp),
                        ),
                      ),
                    ),

                    Space(20.h),
                    Text(
                      "Enter 4-digit code we have sent to",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(5.h),
                    Text(
                      emailAdress,
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(120.h),

                    //pincode field
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
                      buttonWidth: double.infinity,
                      buttonText: vm is Loading ? "Verifying..." : "Proceed",
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: vm is Loading
                          ? null
                          : () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              final email = pref.getString(Constants.email);

                              if (formKey.currentState!.validate()) {
                                // to be removed

                                context.navigate(ResetPinScreen(
                                  otpCode: verifyController.text,
                                  emailPhone: emailAdress,
                                ));
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
