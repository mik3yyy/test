import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/create_account_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/verify_account.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/create_account_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class CreateAccountScreen extends StatefulHookConsumerWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final formKey = GlobalKey<FormState>();
  bool toogle = false;
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final vm = ref.watch(createAccountProvider);
    final fistNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailPhoneController = useTextEditingController();
    ref.listen<RequestState>(createAccountProvider, (T, value) {
      if (value is Success<CreatAccountRes>) {
        context.navigate(VerifyAccountScreen(
          emailAdress: emailPhoneController.text,
        ));

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: AbsorbPointer(
            absorbing: vm is Loading,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
                  child: Column(
                    children: [
                      InnerPageLoadingIndicator(loadingStream: vm is Loading),
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
                              value: toogle,
                              onChanged: (value) {
                                setState(() {
                                  toogle = !toogle;
                                });
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
                                Row(
                                  children: [
                                    Text(
                                      "our ",
                                      style: AppText.body4(
                                          context, AppColors.hintColor),
                                      textAlign: TextAlign.start,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.navigate(const AppWebView(
                                          url: Constants.terms,
                                          successMsg: '',
                                          webViewRoute: WebViewRoute.terms,
                                        ));
                                      },
                                      child: Text(
                                        'Terms and Conditions',
                                        style: AppText.body4(
                                            context, AppColors.appColor),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Space(60.h),
                      CustomButton(
                        buttonWidth: 244.w,
                        buttonText: vm is Loading
                            ? loading(
                                Colors.white,
                              )
                            : buttonText(context, "Sign Up"),
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: vm is Loading
                            ? null
                            : () {
                                if ((emailPhoneController.text.isEmpty) ||
                                    (fistNameController.text.isEmpty) ||
                                    (lastNameController.text.isEmpty)) {
                                  return;
                                } else if (formKey.currentState!.validate()) {
                                  if (toogle == false) {
                                    return AppSnackBar.showInfoSnackBar(context,
                                        message:
                                            "Select the checkbox to continue");
                                  } else {
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
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
                          TextButton(
                              style: TextButton.styleFrom(),
                              onPressed: () {
                                context.navigate(const SigninScreen());
                                // print(widget.account);
                                // switch (widget.account) {
                                //   case Account.existingAccount:
                                //     context.navigate(const SigninScreen(
                                //       account: Account.existingAccount,
                                //     ));
                                //     break;
                                //   case Account.newAccount:

                                //     ));

                                //     break;
                                //   default:
                                // }
                              },
                              child: Text(
                                ' Sign In',
                                style:
                                    AppText.body4(context, AppColors.appColor),
                              )),
                        ],
                      ),
                      Space(40.h),
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
