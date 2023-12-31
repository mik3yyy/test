import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/deactivate_account/deactivate_account_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/deactivate_account/view_model/view_model.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DeactivateAccount extends StatefulHookConsumerWidget {
  const DeactivateAccount({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeactivateAccountState();
}

class _DeactivateAccountState extends ConsumerState<DeactivateAccount> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    passwordController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final deactivate = ref.watch(deactivateAccountProvider);

    ref.listen<RequestState>(deactivateAccountProvider, (_, state) {
      if (state is Loading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
      if (state is Success<DeactivateAccountRes>) {
        navigator.key.currentContext!.navigateReplaceRoot(const SigninScreen());
        PreferenceManager.clear();

        return AppSnackBar.showSuccessSnackBar(context,
            message: state.value!.message.toString());
      }
      if (state is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: state.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title:
            const AppBarTitle(title: "Deactivate Account", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Space(10),
                Text(
                  """Deactivating account deletes your Kayndrexsphere account. A new sign up will be required if you decide to return.
                  """,
                  style: AppText.body2(context, Colors.black45, 17.sp),
                ),
                Text(
                  "You lose all saved currencies once you deactivate your account",
                  style: AppText.body2(context, Colors.black45, 17.sp),
                ),
                const Space(100),
                Form(
                  key: formKey,
                  child: EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Enter Password',
                    // textAlign: TextAlign.start,
                    controller: passwordController,
                    obscureText: obscure,
                    validator: (value) => null,

                    suffixIcon: SizedBox(
                      width: 55.w,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.h),
                          child: Icon(
                            obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Space(40),
                EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Reason for deactivation',
                    // textAlign: TextAlign.start,
                    controller: reasonController,
                    obscureText: false,
                    // validator: (value) => validatePassword(value),
                    validator: (String? value) => null),
                const Space(50),
                CustomButton(
                  buttonText: deactivate is Loading
                      ? loading(
                          Colors.white,
                        )
                      : buttonText(context, "Deactivate Account"),
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: deactivate is Loading
                      ? null
                      : () {
                          if (passwordController.text.isEmpty) {
                            return AppSnackBar.showErrorSnackBar(context,
                                message: "Password is required");
                          } else if (reasonController.text.isEmpty) {
                            return AppSnackBar.showErrorSnackBar(context,
                                message: "Reason for deactivation is required");
                          } else {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            ref
                                .read(deactivateAccountProvider.notifier)
                                .deactivateAccount(passwordController.text,
                                    reasonController.text);
                          }
                        },
                  buttonWidth: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
