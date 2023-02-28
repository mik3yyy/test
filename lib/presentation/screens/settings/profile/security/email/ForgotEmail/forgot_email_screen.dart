import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/forgotten_email_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/edit_info.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/ForgotEmail/reset_email_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/ForgotEmail/vm/forgotten_email_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

enum ForgotEmailRoute { signIn, profile }

class ForgotEmailScreen extends StatefulHookConsumerWidget {
  final ForgotEmailRoute forgotEmailRoute;
  const ForgotEmailScreen({super.key, required this.forgotEmailRoute});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotEmailScreenState();
}

class _ForgotEmailScreenState extends ConsumerState<ForgotEmailScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscured = true;
  String? phoneCode;
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
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final phoneNo = useState<PhoneNumber>(PhoneNumber(isoCode: "GB"));
    final changeEmail = ref.watch(forgottenEmailProvider);
    final phonenumber = useTextEditingController();

    ref.listen<RequestState>(forgottenEmailProvider, (T, value) {
      if (value is Success<ForgettenEmailRes>) {
        context.navigate(ResetEmailScreen(
          forgotEmailRoute: widget.forgotEmailRoute,
        ));
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
                        """Enter the phone number associated with your account to receive a code.
                        """,
                        style: AppText.body2(context, Colors.black45, 17.sp),
                      ),
                    ),
                  ],
                ),
                // Space(20.h),
                // //old password
                // TextFormInput(
                //   keyboardType: TextInputType.number,
                //   capitalization: TextCapitalization.none,
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   labelText: 'Enter phone number',
                //   controller: phonenumber,
                //   inputFormatters: [
                //     FilteringTextInputFormatter.deny(RegExp('[ ]'))
                //   ],
                //   validator: (value) => validateEmail(value),
                //   obscureText: false,
                // ),

                const Space(25),

                IntlPhoneNumber(
                  initialNo: phoneNo,
                  numberChanged: (PhoneNumber value) {
                    setState(() {
                      phoneCode = value.dialCode;

                      // phoneCode = value.dialCode!;
                    });
                  },
                  phoneController: phonenumber,
                ),

                Space(150.h),
                CustomButton(
                    buttonText: changeEmail is Loading
                        ? loading(
                            Colors.white,
                          )
                        : buttonText(context, "Next"),
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: changeEmail is Loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              ref
                                  .read(forgottenEmailProvider.notifier)
                                  .forgottenEmail(
                                      phonenumber.text, phoneCode.toString());

                              // var changeEmail = ChangeEmailReq(
                              //     oldEmail: oldEmail.text,
                              //     newEmail: newEmail.text,
                              //     password: password.text);

                              // ref
                              //     .read(changeEmailProvider.notifier)
                              //     .changeEmail(changeEmail);
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
