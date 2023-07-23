import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_email_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/SignIn_2FA/sign_in_2fa.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/security/email/Change_Email_Vm/change_email_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

enum VerifyRoute {
  changeEmail,
  loginUser,
}

class ChangeEmail extends StatefulHookConsumerWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends ConsumerState<ChangeEmail> {
  final formKey = GlobalKey<FormState>();
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final changeEmail = ref.watch(changeEmailProvider);
    final oldEmail = useTextEditingController();
    final newEmail = useTextEditingController();
    final password = useTextEditingController();

    ref.listen<RequestState>(changeEmailProvider, (T, value) {
      if (value is Success) {
        //TODO:remove comment
        // context.navigate(Verify2FA(
        //   emailAdress: newEmail.text,
        //   verifyRoute: VerifyRoute.changeEmail,
        // ));
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
        title: const AppBarTitle(title: "Change Email", color: Colors.black),
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
                //old password
                TextFormInput(
                  keyboardType: TextInputType.emailAddress,
                  capitalization: TextCapitalization.none,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: 'Enter current email',
                  controller: oldEmail,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  ],
                  validator: (value) => validateEmail(value),
                  obscureText: false,
                ),
                Space(32.h),

                // new password
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
                Space(32.h),

                // confirm password
                TextFormInput(
                  keyboardType: TextInputType.text,
                  capitalization: TextCapitalization.none,
                  labelText: 'Enter password',
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  ],
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password is required';
                    }

                    return null;
                  },
                  obscureText: isObscured,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.h),
                      child: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.appColor,
                      ),
                    ),
                  ),
                ),
                Space(150.h),
                CustomButton(
                    buttonText: changeEmail is Loading
                        ? loading(
                            Colors.white,
                          )
                        : buttonText(context, "Save"),
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
                              var changeEmail = ChangeEmailReq(
                                  oldEmail: oldEmail.text,
                                  newEmail: newEmail.text,
                                  password: password.text);

                              ref
                                  .read(changeEmailProvider.notifier)
                                  .changeEmail(changeEmail);
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
