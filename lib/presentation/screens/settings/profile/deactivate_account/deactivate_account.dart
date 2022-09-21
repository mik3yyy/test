import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/deactivate_account/deactivate_account_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/deactivate_account/view_model/view_model.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
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
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    final deactivate = ref.watch(deactivateAccountProvider);
    final passwordController = useTextEditingController();
    final reasonController = useTextEditingController();

    ref.listen<RequestState>(deactivateAccountProvider, (_, state) {
      if (state is Loading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
      if (state is Success<DeactivateAccountRes>) {
        AppDialog.showSuccessMessageDialog(
            context, state.value!.message.toString(), onpressed: () {
          navigator.key.currentContext!
              .navigateReplaceRoot(const SigninScreen());
          PreferenceManager.removeToken();
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: Text(
          'Deactivate Account',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
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
                const Space(20),
                Text(
                  """Deactivating account deletes your Kayndrexsphere account.A new sign up will be required if you decide to return.
                  """,
                  style: AppText.body2(context, Colors.black45, 18.sp),
                ),
                Text(
                  "You lose all saved currencies once you deactivate your account",
                  style: AppText.body2(context, Colors.black45, 18.sp),
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
                    validator: (value) => validatePassword(value),

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
                      ? "Deactivating"
                      : 'Deactivate Account',
                  bgColor: AppColors.appColor,
                  borderColor: AppColors.appColor,
                  textColor: Colors.white,
                  onPressed: deactivate is Loading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(deactivateAccountProvider.notifier)
                                .deactivateAccount(passwordController.text,
                                    reasonController.text);

                            // context.loaderOverlay.show();
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
