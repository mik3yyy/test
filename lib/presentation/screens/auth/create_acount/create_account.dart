import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/verify_account.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/create_account_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class CreateAccountScreen extends HookConsumerWidget {
  CreateAccountScreen({Key? key}) : super(key: key);
  final toggleStateProvider = StateProvider<bool>((ref) {
    return false;
  });

  final formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(createAccountProvider);
    final fistNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailPhoneController = useTextEditingController();
    var toggleState = ref.watch(toggleStateProvider.state);
    ref.listen<RequestState>(createAccountProvider, (T, value) {
      if (value is Success) {
        context.navigate(VerifyAccountScreen(
          emailAdress: emailPhoneController.text,
        ));
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Check Your Mail or SMS for Verification Code",
        );
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitWave(
            color: AppColors.appColor,
            size: 50.0,
          ),
        ),
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
                  child: Column(
                    children: [
                      Text(
                        "Create Account!",
                        style:
                            AppText.header3(context, AppColors.appColor, 20.sp),
                        textAlign: TextAlign.center,
                      ),
                      Space(15.h),
                      Text(
                        "Create your personal account by providing",
                        style:
                            AppText.header2(context, AppColors.appColor, 20.sp),
                        textAlign: TextAlign.center,
                      ),
                      Space(3.h),
                      Text(
                        "the following details.",
                        style:
                            AppText.header2(context, AppColors.appColor, 20.sp),
                        textAlign: TextAlign.center,
                      ),
                      Space(90.h),

                      //first name
                      TextFormInput(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'First Name',
                          keyboardType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]'))
                          ],
                          controller: fistNameController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "First Name is required";
                            }
                            return null;
                          },
                          obscureText: false),
                      Space(32.h),

                      //last name
                      TextFormInput(
                          keyboardType: TextInputType.name,
                          labelText: 'Last Name',
                          controller: lastNameController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]'))
                          ],
                          capitalization: TextCapitalization.words,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Last Name is required";
                            }
                            return null;
                          },
                          obscureText: false),
                      Space(32.h),

                      // email address
                      TextFormInput(
                          // keyboardType: TextInputType.emailAddress,
                          labelText: 'Email',
                          controller: emailPhoneController,
                          focusNode: fieldFocusNode,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]'))
                          ],
                          capitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email address is required";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                                .hasMatch(value)) {
                              return 'Please input a valid email address';
                            }

                            return null;
                          },
                          obscureText: false),

                      Space(40.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Checkbox(
                              activeColor: AppColors.appColor,
                              checkColor: AppColors.whiteColor,
                              side: BorderSide(
                                  width: 0.8.w, color: AppColors.appColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                              value: toggleState.state,
                              onChanged: (value) {
                                toggleState.state = value!;
                              }),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "By creating your account you agree with",
                                  style: AppText.body4(
                                      context, AppColors.hintColor),
                                  textAlign: TextAlign.start,
                                ),
                                Space(2.h),
                                Text(
                                  "our Terms and Conditions",
                                  style: AppText.body4(
                                      context, AppColors.hintColor),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Space(60.h),
                      CustomButton(
                        buttonWidth: 244.w,
                        buttonText:
                            vm is Loading ? "Sending OTP..." : "Sign Up",
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: vm is Loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  fieldFocusNode.unfocus();
                                  if (toggleState.state == false) {
                                    return AppSnackBar.showInfoSnackBar(context,
                                        message:
                                            "Select the checkbox to continue");
                                  } else {
                                    ref
                                        .read(createAccountProvider.notifier)
                                        .createAccount(
                                          fistNameController.text,
                                          lastNameController.text,
                                          emailPhoneController.text,
                                        );
                                  }
                                  context.loaderOverlay.show();
                                }
                              },
                      ),
                      const Space(20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',
                              style:
                                  AppText.body4(context, AppColors.hintColor)),
                          InkWell(
                            onTap: () => context.navigate(const SigninScreen()),
                            child: Text(
                              ' Sign In',
                              style: AppText.body4(context, AppColors.appColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
