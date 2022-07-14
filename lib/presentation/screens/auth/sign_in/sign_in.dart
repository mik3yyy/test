import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/sign_in_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/choose_account.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forget_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/fingerprint_auth.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/main_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../transaction_pin/transaction_pin.dart';
import 'device_id.dart';

class SigninScreen extends StatefulHookConsumerWidget {
  final String? email;
  const SigninScreen({Key? key, this.email}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  SigninRes? signinRes;
  final formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);

  @override
  void initState() {
    super.initState();
    ref.read(localAuthStateProvider.notifier).hasBiometrics();

    ref.read(deviceInfoProvider.notifier).deviceId();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(signInProvider);
    final localAuth = ref.watch(localAuthStateProvider);
    final deviceId = ref.watch(deviceInfoProvider);
    final emailPhoneController = useTextEditingController(text: widget.email);
    final passwordController = useTextEditingController();
    final togglePasswords = ref.watch(passwordToggleStateProvider.state);

    ref.listen<RequestState>(signInProvider, (T, value) {
      if (value is Success<SigninRes>) {
        if (value.value!.data!.user.transactionPinAddedAt == null) {
          context.loaderOverlay.hide();
          PreferenceManager.isFirstLaunch = true;
          PreferenceManager.isloggedIn = true;
          context.navigate(const TransactionPinScreen());
        } else {
          PreferenceManager.isFirstLaunch = false;
          PreferenceManager.isloggedIn = true;
          ref.read(getAccountDetailsProvider.notifier).getAccountDetails();
          ref.read(getProfileProvider.notifier).getProfile();

          Future.delayed(const Duration(seconds: 2), () {
            context.loaderOverlay.hide();
            context.navigate(MainScreen(menuScreenContext: context));
          });
        }
      }
      if (value is Error) {
        context.loaderOverlay.hide();
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    ref.listen<LocalAuthState>(localAuthStateProvider, (T, value) {
      if (value.isAuthenticated) {
        context.loaderOverlay.show();
      }
      if (value.success) {
        context.loaderOverlay.hide();
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
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
                        labelText: "Email or Phone Number",
                        controller: emailPhoneController,
                        capitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email address or Phone Number is required";
                          }

                          return null;
                        },
                        obscureText: false),
                    Space(32.h),

                    //password
                    TextFormInput(
                      labelText: 'Password',
                      controller: passwordController,
                      focusNode: fieldFocusNode,
                      capitalization: TextCapitalization.none,
                      validator: (String? value) {
                        if (value!.length < 8) {
                          return 'Password must at least be 8 characters';
                        }
                        if (value.isEmpty) {
                          return 'Invalid password';
                        }
                        return null;
                      },
                      obscureText: togglePasswords.state,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          togglePasswords.state = !togglePasswords.state;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.h),
                          child: Icon(
                            togglePasswords.state
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.appColor,
                          ),
                        ),
                      ),
                    ),
                    Space(32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => context.navigate(ForgotPasswordScreen()),
                          child: Text(
                            "Forgot Password?",
                            style: AppText.body4(context, AppColors.appColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    Space(160.h),

                    Row(
                      mainAxisAlignment: localAuth.hasBiometric
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          buttonWidth: 280.w,
                          buttonText:
                              vm is Loading ? 'authenticating' : 'Sign In',
                          bgColor: AppColors.appColor,
                          borderColor: AppColors.appColor,
                          textColor: Colors.white,
                          onPressed: vm is Loading
                              ? null
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    fieldFocusNode.unfocus();

                                    var signinReq = SigninReq(
                                        emailPhone: emailPhoneController.text,
                                        password: passwordController.text,
                                        timezone: "Africa/Lagos",
                                        deviceId: deviceId);
                                    ref
                                        .read(credentialProvider.notifier)
                                        .storeCredential(Constants.userPassword,
                                            passwordController.text);

                                    ref
                                        .read(signInProvider.notifier)
                                        .signIn(signinReq);

                                    context.loaderOverlay.show();
                                  }
                                },
                        ),
                        localAuth.hasBiometric
                            ? GestureDetector(
                                onTap: () async {
                                  if (PreferenceManager.enableBioMetrics ==
                                      true) {
                                    ref
                                        .read(localAuthStateProvider.notifier)
                                        .authenticate();
                                  } else {
                                    return;
                                  }
                                },
                                child: Container(
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
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                    Space(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t have an account? ',
                            style: AppText.body4(context, AppColors.hintColor)),
                        InkWell(
                          onTap: () => context.navigate(const ChooseAccount()),
                          child: Text(
                            ' Sign up',
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
    );
  }
}
