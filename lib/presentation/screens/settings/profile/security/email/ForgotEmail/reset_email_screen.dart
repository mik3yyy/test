import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/req/reset_email_req.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/ForgotEmail/forgot_email_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/ForgotEmail/vm/reset_email_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class ResetEmailScreen extends StatefulHookConsumerWidget {
  final ForgotEmailRoute forgotEmailRoute;

  const ResetEmailScreen({required this.forgotEmailRoute, Key? key})
      : super(key: key);
  // const ResetEmailScreen({super.key, required this.forgotEmailRoute});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetEmailScreenState();
}

class _ResetEmailScreenState extends ConsumerState<ResetEmailScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscured = true;
  PhoneNumber number = PhoneNumber(isoCode: 'GB');
  // seperatePhoneAndDialCode() {
  //   for (var country in Countries.allCountries) {
  //     if (country.values.contains("United States")) {
  //       log(country["code"].toString());
  //       // phoneCode = country["dial_code"].toString();
  //       // isCode = country["code"].toString();
  //       // print(country["dial_code"]);
  //     }
  //   }
  // }

  @override
  void initState() {
    // seperatePhoneAndDialCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final resetEmail = ref.watch(resetEmailProvider);
    final code = useTextEditingController();
    final newEmail = useTextEditingController();
    final newPassword = useTextEditingController();

    ref.listen<RequestState>(resetEmailProvider, (T, value) {
      if (value is Success<GenericRes>) {
        if (widget.forgotEmailRoute == ForgotEmailRoute.profile) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          context.navigateReplace(SigninScreen(
            email: newEmail.text,
          ));
        }

        return AppSnackBar.showSuccessSnackBar(context,
            message: value.value!.message.toString());
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.grey.shade100,
        title: const AppBarTitle(title: "Forgotten email", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Space(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.grey.shade400,
                    ),
                    Space(20.w),
                    Expanded(
                      child: Text(
                        """Please ensure that your account exist with the phone number you provided.
                        """,
                        style: AppText.body2(context, Colors.black45, 17.sp),
                      ),
                    ),
                  ],
                ),
                Space(20.h),
                //old password
                TextFormInput(
                  keyboardType: TextInputType.number,
                  capitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Enter Code',
                  controller: code,
                  textLength: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  ],
                  validator: (value) => null,
                  obscureText: false,
                ),

                TextFormInput(
                  keyboardType: TextInputType.emailAddress,
                  capitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Enter new email',
                  controller: newEmail,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  ],
                  validator: (value) => validateEmail(value),
                  obscureText: false,
                ),
                const Space(25),

                TextFormInput(
                  keyboardType: TextInputType.emailAddress,
                  capitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Enter new password',
                  controller: newEmail,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  ],
                  validator: (value) => validatePassword(value),
                  obscureText: false,
                ),

                Space(150.h),
                CustomButton(
                    buttonText: resetEmail is Loading
                        ? loading(
                            Colors.white,
                          )
                        : buttonText(context, "Save"),
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: resetEmail is Loading
                        ? null
                        : () {
                            if (code.text.isEmpty) {
                              return;
                            }
                            if (formKey.currentState!.validate()) {
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              var reset = ResetEmailReq(
                                  code: code.text,
                                  newEmail: newEmail.text,
                                  newpassowrd: newPassword.text,
                                  the2FaToken: PreferenceManager.twoFaToken);

                              ref
                                  .read(resetEmailProvider.notifier)
                                  .resetEmail(reset);
                            }
                          },
                    buttonWidth: MediaQuery.of(context).size.width),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
