import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/forget_password/forgot_password_otp.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/forgot_password_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/auth_security/auth_secure.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(forgotPasswordProvider);
    final controller = useTextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);
    ref.listen<RequestState>(forgotPasswordProvider, (_, value) {
      if (value is Success) {
        context.navigate(ForgetPasswordOTPScreen(
          emailAdress: controller.text,
        ));
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Please Check Your Mail for Verification Code",
        );
      }
      if (value is Error) {
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
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.grey.shade100,
          title: const AppBarTitle(
              title: "Forgot Password", color: AppColors.appColor),
          leading: const BackButton(color: Colors.black),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      "Forgot your Kayndrexsphere Password?",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),

                    Space(180.h),

                    // phone number or email
                    TextFormInput(
                      labelText: 'Email Address',
                      capitalization: TextCapitalization.none,
                      controller: controller,
                      validator: (value) => validateEmail(value),
                      obscureText: false,
                    ),

                    Space(260.h),
                    CustomButton(
                      buttonWidth: double.infinity,
                      buttonText: vm is Loading
                          ? loading(
                              Colors.white,
                            )
                          : buttonText(context, "Send"),
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: vm is Loading
                          ? null
                          : () async {
                              final pref =
                                  await SharedPreferences.getInstance();

                              if (controller.text.isEmpty) {
                                return;
                              } else if (formKey.currentState!.validate()) {
                                pref.setString(
                                    Constants.email, controller.text);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                ref
                                    .read(credentialProvider.notifier)
                                    .storeCredential(Constants.userPassword,
                                        controller.text);
                                ref
                                    .read(forgotPasswordProvider.notifier)
                                    .forgotPassword(controller.text);
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
