import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/signin_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/create_account.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forget_password.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/sign_in_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/main_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../transaction_pin/transaction_pin.dart';

class SigninScreen extends StatefulHookConsumerWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  SigninRes? signinRes;
  final formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);

  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Verify your FingerPrint',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');

    context.navigate(MainScreen(menuScreenContext: context));
  }

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    _getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(signInProvider);

    final emailPhoneController = TextEditingController();
    final passwordController = TextEditingController();
    final togglePasswords = ref.watch(passwordToggleStateProvider.state);

    ref.listen<RequestState>(signInProvider, (T, value) {
      if (value is Success<SigninRes>) {
        if (value.value!.data!.user!.transactionPinAddedAt == null) {
          context.navigate(TransactionPinScreen());
        } else {
          context.navigate(MainScreen(menuScreenContext: context));
        }
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
                        labelText: 'Email or Phone Number',
                        controller: emailPhoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email address or Phone Number is required";
                          }
                          if (!RegExp(
                                  "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                              .hasMatch(value)) {
                            return 'Please input a valid email address';
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
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    fieldFocusNode.unfocus();
                                    ref.read(signInProvider.notifier).signIn(
                                        emailPhoneController.text,
                                        passwordController.text);
                                    context.loaderOverlay.show();
                                  }
                                },
                        ),
                        GestureDetector(
                          onTap: _authenticate,
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
                      ],
                    ),
                    Space(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t have an account? ',
                            style: AppText.body4(context, AppColors.appColor)),
                        InkWell(
                          onTap: () => context.navigate(CreateAccountScreen()),
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
