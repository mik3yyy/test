import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/success.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/ref_code_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class ReferralCodeScreen extends HookConsumerWidget {
  ReferralCodeScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(refCodeProvider);

    final controller = useTextEditingController();
    ref.listen<RequestState>(refCodeProvider, (T, value) {
      if (value is Success) {
        context.navigate(const SuccessScreen());

        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Check Your Mail or SMS for Verification Code",
        );
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
                      "Referral code",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(19.h),
                    Text(
                      "Type in referral code of whomever",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(5.h),
                    Text(
                      "referred you and help them earn kayndrex",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(160.h),

                    // referral code
                    TextFormInput(
                      labelText: 'Enter referral code',
                      focusNode: fieldFocusNode,
                      capitalization: TextCapitalization.none,
                      controller: controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Referral Code is required';
                        }

                        return null;
                      },
                      obscureText: false,
                    ),

                    Space(270.h),
                    Row(
                      children: [
                        Space(97.w),
                        CustomButton(
                          buttonWidth: 190.w,
                          buttonText: buttonText(context, "Done"),
                          bgColor: AppColors.appColor,
                          borderColor: AppColors.appColor,
                          textColor: Colors.white,
                          onPressed: vm is Loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    fieldFocusNode.unfocus();
                                    ref
                                        .read(refCodeProvider.notifier)
                                        .refCode(controller.text);
                                    context.loaderOverlay.show();
                                  }
                                },
                        ),
                        Space(30.w),
                        TextButton(
                            onPressed: () =>
                                context.navigate(const SuccessScreen()),
                            child: Text(
                              'Skip',
                              style: AppText.body4(context, AppColors.appColor),
                            ))
                      ],
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
      ),
    );
  }
}
