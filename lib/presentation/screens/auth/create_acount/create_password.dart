import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/currency.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/create_password_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';

class CreatePasswordScreen extends StatefulHookConsumerWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {
  final formKey = GlobalKey<FormState>();

  bool password = true;
  bool confirm = true;

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(createPasswordProvider);
    FocusScopeNode currentFocus = FocusScope.of(context);

    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    ref.listen<RequestState>(createPasswordProvider, (_, value) {
      if (value is Loading) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success) {
        context.navigate(CurrencyScreen());
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Password created successfully",
        );
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
              child: Column(
                children: [
                  Text(
                    "Create Password",
                    style: AppText.header3(context, AppColors.appColor, 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  Space(12.h),
                  Text(
                    "Create a Unique Kayndrexsphere",
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  Space(5.h),
                  Text(
                    "Password",
                    style: AppText.header2(context, AppColors.appColor, 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  Space(160.h),

                  // password
                  TextFormInput(
                    labelText: 'Password',
                    controller: passwordController,
                    capitalization: TextCapitalization.none,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Password is requied";
                      }

                      return null;
                    },
                    obscureText: password,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          password = !password;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.h),
                        child: Icon(
                          password ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.appColor,
                        ),
                      ),
                    ),
                  ),
                  Space(32.h),

                  // confirm password
                  TextFormInput(
                    labelText: 'Confirm Password',
                    controller: confirmPasswordController,
                    capitalization: TextCapitalization.none,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        return 'Password doesn\'t match';
                      }

                      // validator has to return something :)
                      return null;
                    },
                    obscureText: confirm,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          confirm = !confirm;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.h),
                        child: Icon(
                          confirm ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.appColor,
                        ),
                      ),
                    ),
                  ),
                  Space(190.h),
                  CustomButton(
                    buttonWidth: 244.w,
                    buttonText: vm is Loading
                        ? loading(
                            Colors.white,
                          )
                        : buttonText(context, "Save"),
                    bgColor: AppColors.appColor,
                    borderColor: AppColors.appColor,
                    textColor: Colors.white,
                    onPressed: vm is Loading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              ref
                                  .read(createPasswordProvider.notifier)
                                  .createPassword(passwordController.text,
                                      confirmPasswordController.text);
                            }
                          },
                  ),
                  Space(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Text(
                        ' | ',
                        style: AppText.body4(context, AppColors.appColor),
                      ),
                      TextButton(
                          onPressed: () {
                            context.navigate(const AppWebView(
                              url: Constants.terms,
                              successMsg: '',
                              webViewRoute: WebViewRoute.terms,
                            ));
                          },
                          child: Text(
                            'Terms',
                            style: AppText.body4(context, AppColors.appColor),
                          )),
                    ],
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
