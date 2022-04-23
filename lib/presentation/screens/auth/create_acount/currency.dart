import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/referral_code.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/vm/set_currency_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/country.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/currency.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/language.dart';
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
    final currencyController = TextEditingController();
    final countryController = TextEditingController();
    final languageController = TextEditingController();
    ref.listen<RequestState>(setCurrencyProvider, (T, value) {
      if (value is Success) {
        context.navigate(const ReferralCodeScreen());
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
              child: Form(
                key: formKey,
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
                        countryBuild(context, countryController);
                      },
                      child: TextFormInput(
                        enabled: false,
                        textAlign: TextAlign.center,
                        labelText: 'Country',
                        controller: countryController,
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
                        currencyBuild(context, currencyController);
                      },
                      child: TextFormInput(
                        enabled: false,
                        textAlign: TextAlign.center,
                        labelText: 'Currency',
                        controller: currencyController,
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
                        openLanguagePickerDialog(context, languageController);
                      },
                      child: TextFormInput(
                        enabled: false,
                        textAlign: TextAlign.center,
                        labelText: 'Language',
                        controller: languageController,
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
                      buttonText: vm is Loading ? "Proceeding..." : "Proceed",
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
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: InkWell(
                              // onTap: () =>
                              // context.navigate(const VerifyAccountScreen()),
                              child: Text(
                                'Privacy Policy ',
                                style:
                                    AppText.body4(context, AppColors.appColor),
                              ),
                            ),
                          ),
                          TextSpan(
                              text: ' | ',
                              style:
                                  AppText.body4(context, AppColors.appColor)),
                          WidgetSpan(
                            child: InkWell(
                              // onTap: () =>
                              // context.navigate(const VerifyAccountScreen()),
                              child: Text(
                                ' Terms',
                                style:
                                    AppText.body4(context, AppColors.appColor),
                              ),
                            ),
                          ),
                        ],
                      ),
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
