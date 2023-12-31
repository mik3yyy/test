import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/SignIn_2FA/sign_in_2fa.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/create_account.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forget_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/fingerprint_auth.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/main_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/ForgotEmail/forgot_email_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/change_email.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../transaction_pin/transaction_pin.dart';
import 'device_id.dart';

class SigninScreen extends StatefulHookConsumerWidget {
  final String? email;
  final bool transactionPin;

  const SigninScreen({Key? key, this.email, this.transactionPin = false})
      : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(localAuthStateProvider.notifier).hasBiometrics();
      ref.read(deviceInfoProvider.notifier).deviceId();
      ref.read(deviceInfoProvider.notifier).timeZone();
    });
  }

  bool toogle = true;

  @override
  Widget build(BuildContext context) {
    final email = PreferenceManager.email;
    final verify = ref.watch(verifyAuthProvider);
    final login = ref.watch(signInProvider);
    final device = ref.watch(deviceInfoProvider);
    final emailPhoneController = useTextEditingController(text: email);
    final passwordController = useTextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);

    /// SEND TO MAIN SCREEN HAS A NEW USER

    ref.listen<RequestState>(signInProvider, (T, value) {
      if (value is Success<SigninRes>) {
        setState(() {
          isLoading = false;
        });
        if (value.value!.data!.user.transactionPinAddedAt == null) {
          context.navigate(const TransactionPinScreen());
        } else {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isLoading = false;
            });
            navigator.key.currentContext!.navigateReplaceRoot(MainScreen(
              menuScreenContext: context,
            ));
          });
        }
      }
      if (value is Error) {
        setState(() {
          isLoading = false;
        });

        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    /// SEND TO 2FA VERIFICATION SCREEN

    ref.listen<RequestState>(verifyAuthProvider, (T, value) {
      if (value is Success<GenericRes>) {
        setState(() {
          isLoading = false;
        });
        //TODO: remove comment from the code below
        // context.navigate(Verify2FA(
        //   emailAdress: emailPhoneController.text,
        //   verifyRoute: VerifyRoute.loginUser,
        // ));
      }
      if (value is Error) {
        setState(() {
          isLoading = false;
        });
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    ref.listen<LocalAuthState>(localAuthStateProvider, (T, value) {
      if (value.isAuthenticated) {
        setState(() {
          isLoading = true;
        });
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InnerPageLoadingIndicator(
                      loadingStream: login is Loading || verify is Loading),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
                    child: AbsorbPointer(
                      absorbing: login is Loading,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              "Welcome Back!",
                              style: AppText.header3(
                                  context, AppColors.appColor, 20.sp),
                              textAlign: TextAlign.center,
                            ),
                            Space(12.h),
                            Text(
                              "Continue to Sign in",
                              style: AppText.header2(
                                  context, AppColors.appColor, 20.sp),
                              textAlign: TextAlign.center,
                            ),
                            Space(150.h),

                            //email
                            TextFormInput(
                                labelText: "Enter Email ",
                                controller: emailPhoneController,
                                capitalization: TextCapitalization.none,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp('[ ]'))
                                ],
                                validator: (value) {
                                  // if (value!.isEmpty) {
                                  //   return "";
                                  // }

                                  return null;
                                },
                                obscureText: false),
                            Space(32.h),

                            //password
                            TextFormInput(
                              labelText: 'Password',
                              controller: passwordController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp('[ ]'))
                              ],
                              capitalization: TextCapitalization.none,
                              validator: (String? value) {
                                // if (value!.length < 8) {
                                //   return '';
                                // }
                                // if (value!.isEmpty) {
                                //   return "";
                                // }
                                return null;
                              },
                              obscureText: toogle,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    toogle = !toogle;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 0.h),
                                  child: Icon(
                                    toogle
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.appColor,
                                  ),
                                ),
                              ),
                            ),
                            Space(32.h),

                            Space(130.h),

                            Row(
                              mainAxisAlignment: PreferenceManager.hasBiometrics
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  buttonWidth: 280.w,
                                  buttonText: buttonText(context, "Sign in"),
                                  bgColor: AppColors.appColor,
                                  borderColor: AppColors.appColor,
                                  textColor: Colors.white,
                                  onPressed: (verify is Loading) ||
                                          (login is Loading)
                                      ? null
                                      : () async {
                                          if ((emailPhoneController
                                                  .text.isEmpty) ||
                                              (passwordController
                                                  .text.isEmpty)) {
                                            return;
                                          } else {
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }

                                            var signinReq = SigninReq(
                                                emailPhone:
                                                    emailPhoneController.text,
                                                password:
                                                    passwordController.text,
                                                timezone: device.timeZone,
                                                deviceId: device.deviceId);

                                            setState(() {
                                              isLoading = true;
                                            });

                                            ///CHECK IF USERPASSWORD IS SAVED
                                            if (!PreferenceManager.isSaved) {
                                              ref
                                                  .read(credentialProvider
                                                      .notifier)
                                                  .storeCredential(
                                                      Constants.userPassword,
                                                      passwordController.text);
                                            }

                                            /// CHECK END HERE

                                            switch (widget.transactionPin) {
                                              case false:
                                                ref
                                                    .read(
                                                        signInProvider.notifier)
                                                    .signIn(signinReq);

                                                break;
                                              case true:
                                                ref
                                                    .read(verifyAuthProvider
                                                        .notifier)
                                                    .verifyAuth(signinReq);
                                                break;
                                              default:
                                            }
                                          }
                                        },
                                ),
                                PreferenceManager.hasBiometrics
                                    ? GestureDetector(
                                        onTap: () async {
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                          if (PreferenceManager
                                                  .enableBioMetrics ==
                                              true) {
                                            ref
                                                .read(localAuthStateProvider
                                                    .notifier)
                                                .authenticate();
                                          } else {
                                            showOkAlertDialog(
                                              context: context,
                                              message:
                                                  'Login and enable biometric',
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 55.h,
                                          width: 80.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.appColor,
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                              "assets/images/fingerprint-3.png",
                                            ),
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                            Space(40.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //TODO:remove comment from the code below
                                // TextButton(
                                //   onPressed: (verify is Loading) ||
                                //           (login is Loading)
                                //       ? null
                                //       : () => context
                                //               .navigate(const ForgotEmailScreen(
                                //             forgotEmailRoute:
                                //                 ForgotEmailRoute.signIn,
                                //           )),
                                //   child: Text(
                                //     "Forgot Email?",
                                //     style: AppText.body4(
                                //         context, AppColors.appColor),
                                //     textAlign: TextAlign.center,
                                //   ),
                                //   style: TextButton.styleFrom(
                                //     foregroundColor: AppColors.appColor,
                                //     backgroundColor: Colors.transparent,
                                //     disabledForegroundColor: Colors.grey,
                                //   ),
                                // ),
                                TextButton(
                                  onPressed:
                                      (verify is Loading) || (login is Loading)
                                          ? null
                                          : () => context
                                              .navigate(ForgotPasswordScreen()),
                                  child: Text(
                                    "Forgot Password?",
                                    style: AppText.body4(
                                        context, AppColors.appColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.appColor,
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            Space(40.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don’t have an account? ',
                                    style: AppText.body4(
                                        context, AppColors.hintColor)),
                                TextButton(
                                    style: TextButton.styleFrom(),
                                    onPressed: () {
                                      //print(widget.account);
                                      context.navigate(
                                          const CreateAccountScreen());
                                    },
                                    child: Text(
                                      ' Sign up',
                                      style: AppText.body4(
                                          context, AppColors.appColor),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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

Widget buttonText(BuildContext context, String text) {
  return Text(
    text,
    style: AppText.header1(context, Colors.white, 20.sp),
  );
}

Widget loading(Color color) {
  return SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(color: color),
  );
}
