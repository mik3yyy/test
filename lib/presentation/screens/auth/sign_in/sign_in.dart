import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/create_account.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/transaction_pin/transaction_pin.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/main_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class SigninScreen extends HookConsumerWidget {
  SigninScreen({Key? key}) : super(key: key);


  final formKey = GlobalKey<FormState>();

               


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(signInProvider);
    final emailPhoneController = TextEditingController();
    final passwordController = TextEditingController();
    ref.listen<RequestState>(signInProvider, (T, value) {
      if (value is Success) {
        context.navigate(HomePage());
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Login successful!",
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
                    Text(
                      "Welcome Back!",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(12.h),
                    Text(
                      "Continue to Sign in",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(180.h),


                    //email
                    TextFormInput(
                        textAlign: TextAlign.center,
                        labelText: 'Email or Phone Number',
                        controller: emailPhoneController,
                        validator: (value) {},
                        obscureText: false),
                    Space(32.h),

                    //password
                    TextFormInput(
                      textAlign: TextAlign.center,
                      labelText: 'Password',
                      controller: passwordController,
                      validator: (value) {},
                      obscureText: false,
                      suffixIcon: Icon(Icons.visibility),

                Space(160.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      buttonWidth: 280.w,
                      buttonText: 'Sign In',
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: () {
                        context.navigate(
                          MainScreen(
                            menuScreenContext: context,
                          ),
                        );
                      },

                    ),
                    Space(32.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: AppText.body4(context, AppColors.appColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    Space(160.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          buttonWidth: 280.w,
                          buttonText: 'Sign In',
                          bgColor: AppColors.appColor,
                          borderColor: AppColors.appColor,
                          textColor: Colors.white,
                          onPressed: vm is Loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    ref.read(signInProvider.notifier).signIn(
                                        emailPhoneController.text,
                                        passwordController.text);
                                    context.loaderOverlay.show();
                                  }
                                },
                        ),
                        Container(
                          height: 55.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: const Image(
                            image: AssetImage(
                              "images/fingerprint-3.png",
                            ),
                            color: AppColors.whiteColor,
                          ),
                        )
                      ],
                    ),
                    Space(20.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Don’t have an account? ',
                              style:
                                  AppText.body4(context, AppColors.appColor)),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () =>
                                  context.navigate(CreateAccountScreen()),
                              child: Text(
                                ' Sign up',
                                style:
                                    AppText.body4(context, AppColors.appColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
