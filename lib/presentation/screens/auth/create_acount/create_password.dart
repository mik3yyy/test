import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/currency.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/create_password_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';

class CreatePasswordScreen extends HookConsumerWidget {
  CreatePasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(createPasswordProvider);

    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    ref.listen<RequestState>(createPasswordProvider, (T, value) {
      if (value is Success) {
        context.navigate(CurrencyScreen());
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Password created successfully",
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
                      "Create Password",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(12.h),
                    Text(
                      "Create a Unique Kayndrexsphere",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(5.h),
                    Text(
                      "Password",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(160.h),

                    // password
                    TextFormInput(
                      textAlign: TextAlign.start,
                      labelText: 'Password',
                      controller: passwordController,
                      validator: (String? value) {
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
                      textAlign: TextAlign.start,
                      labelText: 'Confirm Password',
                      controller: confirmPasswordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password is required';
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return 'Password doesn\'t match';
                        }

                        // validator has to return something :)
                        return null;
                      },
                      obscureText: false,
                      suffixIcon: const Icon(Icons.visibility_off),
                    ),
                    Space(190.h),
                    CustomButton(
                      buttonWidth: 244.w,
                      buttonText: 'Proceed',
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: vm is Loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                ref
                                    .read(createPasswordProvider.notifier)
                                    .createPassword(passwordController.text,
                                        confirmPasswordController.text);
                              }
                              // context.loaderOverlay.show();
                            },
                    ),
                    Space(30.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: InkWell(
                              // onTap: () =>
                              // context.navigate(const VerifyAccountScreen()),
                              child: Text(
                                'Privacy Policy ',
                                style:
                                    AppText.body4(context, AppColors.appColor),
                              ),
                            ),
                          ),
                          TextSpan(
                              text: ' | ',
                              style:
                                  AppText.body4(context, AppColors.appColor)),
                          WidgetSpan(
                            child: InkWell(
                              // onTap: () =>
                              // context.navigate(const VerifyAccountScreen()),
                              child: Text(
                                ' Terms',
                                style:
                                    AppText.body4(context, AppColors.appColor),
                              ),
                            ),
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
