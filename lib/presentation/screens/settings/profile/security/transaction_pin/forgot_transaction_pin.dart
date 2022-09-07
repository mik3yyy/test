import 'package:flutter/material.dart';
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
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/transaction_pin/pin_otp.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/forgot_pin_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotTransactionPin extends HookConsumerWidget {
  ForgotTransactionPin({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(forgotPinProvider);
    final controller = useTextEditingController();
    ref.listen<RequestState>(forgotPinProvider, (T, value) {
      if (value is Success<bool>) {
        context.loaderOverlay.hide();
        pushNewScreen(
          context,
          screen: PinOTPScreen(
            emailAdress: controller.text,
          ),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
        // context.navigate(PinOTPScreen(
        //   emailAdress: controller.text,
        // ));
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

                    Space(180.h),

                    // phone number or email
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Column(
                        children: [
                          TextFormInput(
                            labelText: 'Email Address or Phone Number',
                            controller: controller,
                            capitalization: TextCapitalization.none,
                            focusNode: fieldFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email address or phone number is required";
                              }
                              // if (!RegExp(
                              //         "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                              //     .hasMatch(value)) {
                              //   return 'Please input a valid email address';
                              // }

                              return null;
                            },
                            obscureText: false,
                          ),
                          Space(260.h),
                          CustomButton(
                            buttonWidth: double.infinity,
                            buttonText:
                                vm is Loading ? "Sending OTP..." : "Send",
                            bgColor: AppColors.appColor,
                            borderColor: AppColors.appColor,
                            textColor: Colors.white,
                            onPressed: vm is Loading
                                ? null
                                : () async {
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    pref.setString(
                                        Constants.email, controller.text);
                                    if (formKey.currentState!.validate()) {
                                      fieldFocusNode.unfocus();
                                      ref
                                          .read(forgotPinProvider.notifier)
                                          .forgotPin(controller.text);

                                      // context.loaderOverlay.show();
                                    }
                                  },
                          ),
                        ],
                      ),
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
