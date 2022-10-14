import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/constant/constant.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/referral_code.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/select_language/select_language.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/set_currency_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/transaction_information/webview/card_webview.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/add-fund-to-wallet/currency_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/web_view_route_name.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/select_country_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';

class CurrencyScreen extends HookConsumerWidget {
  CurrencyScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(setCurrencyProvider);

    final currencyController = useTextEditingController();
    final countryController = useTextEditingController();
    final countryCodeController = useTextEditingController();
    final languageController = useTextEditingController();

    ref.listen<RequestState>(setCurrencyProvider, (T, value) {
      if (value is Success) {
        context.navigate(ReferralCodeScreen());
        return AppSnackBar.showSuccessSnackBar(
          context,
          message: "Registration completed successfully!",
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
                      "Currency",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),

                    Space(160.h),

                    // country
                    InkWell(
                      onTap: () {
                        pushNewScreen(context,
                            screen: SelectCountryScreen(
                                countryName: countryController,
                                countryCode: countryCodeController),
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideRight);
                        // countryBuild(
                        //   context,
                        //   countryController,
                        // );
                      },
                      child: TextFormInput(
                        enabled: false,
                        labelText: 'Country',
                        controller: countryController,
                        capitalization: TextCapitalization.none,
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textColor,
                        ),
                        validator: (value) {
                          if (countryController.text.isEmpty &&
                              value!.isEmpty) {
                            return "Country is required";
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                    ),
                    Space(32.h),

                    // currency
                    GestureDetector(
                      onTap: () {
                        // context.navigate()
                        pushNewScreen(context,
                            screen: SelectCurrencyScreen(
                              currencyCode: currencyController,
                              routeName: 'addFunds',
                            ),
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideRight);
                      },
                      child: TextFormInput(
                        enabled: false,
                        labelText: 'Currency',
                        controller: currencyController,
                        capitalization: TextCapitalization.none,
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textColor,
                        ),
                        validator: (value) {
                          if (currencyController.text.isEmpty &&
                              value!.isEmpty) {
                            return "Currency is required";
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                    ),
                    Space(32.h),

                    // language
                    GestureDetector(
                      onTap: () {
                        pushNewScreen(context,
                            screen: SelectLanguage(
                              languageName: languageController,
                            ),
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideRight);
                      },
                      child: TextFormInput(
                        enabled: false,
                        labelText: 'Language',
                        controller: languageController,
                        capitalization: TextCapitalization.none,
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textColor,
                        ),
                        validator: (value) {
                          if (languageController.text.isEmpty &&
                              value!.isEmpty) {
                            return "Language is required";
                          }
                          return null;
                        },
                        obscureText: false,
                      ),
                    ),
                    Space(190.h),
                    CustomButton(
                      buttonWidth: 244.w,
                      buttonText: vm is Loading
                          ? loading()
                          : buttonText(context, "Process"),
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: vm is Loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                ref
                                    .read(setCurrencyProvider.notifier)
                                    .setCurrency(
                                        currencyController.text,
                                        languageController.text,
                                        countryController.text);
                                context.loaderOverlay.show();
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
      ),
    );
  }
}
