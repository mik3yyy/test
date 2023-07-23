import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/two_fa_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/SignIn_2FA/resend_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/SignIn_2FA/vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/main_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/Change_Email_Vm/resend_email_2fa.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/change_email.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/Change_Email_Vm/verify_change_email_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class Verify2FA extends StatefulHookConsumerWidget {
  final String emailAdress;
  final VerifyRoute verifyRoute;

  const Verify2FA(
    this.verifyRoute,
    this.emailAdress, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Verify2FAState();
}

class _Verify2FAState extends ConsumerState<Verify2FA> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController verifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final vm = ref.watch(verify2FAProvider);
    final emailChange = ref.watch(verifyEmailChangeProvider);
    final resend2FA = ref.watch(resend2FAProvider);
    final resendEmail2FA = ref.watch(resendEmail2FAProvider);

    /// VERIFICATION CODE FOR SIGN IN
    ref.listen<RequestState>(verify2FAProvider, (T, value) {
      if (value is Loading<SigninRes>) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success<SigninRes>) {
        context.loaderOverlay.hide();
        navigator.key.currentContext!.navigateReplaceRoot(MainScreen(
          menuScreenContext: context,
        ));
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    /// RESEND VERIFICATION CODE FOR SIGN IN
    ref.listen<RequestState>(resend2FAProvider, (T, value) {
      if (value is Loading<GenericRes>) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success<GenericRes>) {
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

    /// EMAIL VERIFICATION CODE FOR SIGN IN
    ref.listen<RequestState>(verifyEmailChangeProvider, (T, value) {
      if (value is Loading<GenericRes>) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success<GenericRes>) {
        ref
            .read(credentialProvider.notifier)
            .storeCredential(Constants.userEmail, widget.emailAdress);

        navigator.key.currentContext!.navigateReplaceRoot(MainScreen(
          menuScreenContext: context,
        ));
        return AppSnackBar.showSuccessSnackBar(context,
            message: value.value!.message.toString());
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    /// RESEND VERIFICATION CODE FOR SIGN IN
    ref.listen<RequestState>(resendEmail2FAProvider, (T, value) {
      if (value is Loading<GenericRes>) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success<GenericRes>) {
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

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
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
                      "Verify Account!",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(12.h),
                    Text(
                      "Enter 6-digit code we have sent to",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(5.h),
                    Text(
                      widget.emailAdress,
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(120.h),
                    PinCodeTextField(
                      autoDisposeControllers: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Verification code is required';
                        }
                        if (value.length < 4) {
                          return null;
                        }
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
                      errorTextSpace: 50.5,
                      autoDismissKeyboard: true,
                      errorTextMargin:
                          const EdgeInsets.symmetric(horizontal: 100),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      appContext: context,
                      length: 6,
                      onCompleted: (value) async {
                        var email = await ref
                            .read(credentialProvider.notifier)
                            .getCredential(Constants.userEmail);
                        if (value.length == 6) {
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          String userEmail() {
                            if (widget.emailAdress.isEmpty) {
                              return email ?? "";
                            } else {
                              return widget.emailAdress;
                            }
                          }

                          var verify2FA = The2FaReq(
                              email: userEmail(), code: verifyController.text);
                          switch (widget.verifyRoute) {
                            case VerifyRoute.loginUser:
                              ref
                                  .read(verify2FAProvider.notifier)
                                  .verify2FA(verify2FA);
                              break;
                            case VerifyRoute.changeEmail:
                              ref
                                  .read(verifyEmailChangeProvider.notifier)
                                  .changeEmail(verifyController.text);
                              break;
                            default:
                          }
                        }
                      },
                      onChanged: (String value) {},
                    ),
                    Space(80.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Didn’t receive the code?',
                            style: AppText.body4(context, AppColors.hintColor)),
                        TextButton(
                            onPressed: () async {
                              var email = await ref
                                  .read(credentialProvider.notifier)
                                  .getCredential(Constants.userEmail);
                              String userEmail() {
                                if (widget.emailAdress.isEmpty) {
                                  return email ?? "";
                                } else {
                                  return widget.emailAdress;
                                }
                              }

                              switch (widget.verifyRoute) {
                                case VerifyRoute.loginUser:
                                  ref
                                      .read(resend2FAProvider.notifier)
                                      .resend2FA(userEmail());
                                  break;
                                case VerifyRoute.changeEmail:
                                  ref
                                      .read(resendEmail2FAProvider.notifier)
                                      .resendEmail2FA(widget.emailAdress);
                                  break;
                                default:
                              }
                            },
                            child: (resend2FA is Loading) ||
                                    (resendEmail2FA is Loading)
                                ? loading(
                                    AppColors.appColor,
                                  )
                                : Text(
                                    ' Resend Code',
                                    style: AppText.body4(
                                        context, AppColors.appColor),
                                  )),
                      ],
                    ),
                    Space(160.h),
                    CustomButton(
                      buttonWidth: 244.w,
                      buttonText: (vm is Loading) || (emailChange is Loading)
                          ? loading(
                              Colors.white,
                            )
                          : buttonText(context, "Process"),
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: (vm is Loading) || (emailChange is Loading)
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                var email = await ref
                                    .read(credentialProvider.notifier)
                                    .getCredential(Constants.userEmail);
                                String userEmail() {
                                  if (widget.emailAdress.isEmpty) {
                                    return email ?? "";
                                  } else {
                                    return widget.emailAdress;
                                  }
                                }

                                var verify2FA = The2FaReq(
                                    email: userEmail(),
                                    code: verifyController.text);
                                switch (widget.verifyRoute) {
                                  case VerifyRoute.loginUser:
                                    ref
                                        .read(verify2FAProvider.notifier)
                                        .verify2FA(verify2FA);
                                    break;
                                  case VerifyRoute.changeEmail:
                                    ref
                                        .read(
                                            verifyEmailChangeProvider.notifier)
                                        .changeEmail(verifyController.text);
                                    break;
                                  default:
                                }
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
      ),
    );
  }
}
