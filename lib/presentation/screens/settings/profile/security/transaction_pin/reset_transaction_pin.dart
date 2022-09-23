import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';

import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/reset_pin_vm.dart';

import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ResetPinScreen extends StatefulHookConsumerWidget {
  final String otpCode;
  final String emailPhone;
  const ResetPinScreen({
    Key? key,
    required this.emailPhone,
    required this.otpCode,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends ConsumerState<ResetPinScreen> {
  final formKey = GlobalKey<FormState>();
  final pinToggleStateProvider = StateProvider<bool>((ref) => true);
  final pinConfirmToggleStateProvider = StateProvider<bool>((ref) => true);

  final fieldFocusNode = FocusNode();
  TextEditingController confirmController = TextEditingController();
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    confirmController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(resetPinProvider);

    final togglePassword = ref.watch(pinToggleStateProvider.state);
    final toggleConfirmPin = ref.watch(pinConfirmToggleStateProvider.state);

    ref.listen<RequestState>(resetPinProvider, (T, value) {
      if (value is Success) {
        context.loaderOverlay.hide();
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);

        return AppSnackBar.showSuccessSnackBar(context,
            message: 'Transaction Pin changed successfully');
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
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          title: Text(
            'Security',
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 40.h,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.appColor.withOpacity(0.1),
                      child: Padding(
                        padding: EdgeInsets.only(left: 23.w, top: 7),
                        child: Text(
                          'Reset Transaction Pin',
                          style: AppText.body2(context, Colors.black54, 20.sp),
                        ),
                      ),
                    ),

                    Space(120.h),

                    // new password
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Column(
                        children: [
                          TextFormInput(
                            keyboardType: TextInputType.number,
                            labelText: 'New Pin',
                            capitalization: TextCapitalization.none,
                            controller: controller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Transaction pin is requied";
                              }
                              if (value.length > 4) {
                                return 'Transaction pin must not be more than 4 numbers';
                              }
                              return null;
                            },
                            obscureText: togglePassword.state,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                togglePassword.state = !togglePassword.state;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 0.h),
                                child: Icon(
                                  togglePassword.state
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                          ),

                          Space(32.h),

                          // confirm password
                          TextFormInput(
                            keyboardType: TextInputType.number,
                            labelText: 'Confirm New Pin',
                            capitalization: TextCapitalization.none,
                            controller: confirmController,
                            focusNode: fieldFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Confirm Transaction Pin is required';
                              } else if (controller.text !=
                                  confirmController.text) {
                                return 'Transaction Pin doesn\'t match';
                              }

                              // validator has to return something :)
                              return null;
                            },
                            obscureText: toggleConfirmPin.state,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                toggleConfirmPin.state =
                                    !toggleConfirmPin.state;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 0.h),
                                child: Icon(
                                  toggleConfirmPin.state
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                          ),

                          Space(150.h),
                          CustomButton(
                            buttonWidth: double.infinity,
                            buttonText:
                                vm is Loading ? "Setting New Pin" : 'Continue',
                            bgColor: AppColors.appColor,
                            borderColor: AppColors.appColor,
                            textColor: Colors.white,
                            onPressed: vm is Loading
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      fieldFocusNode.unfocus();
                                      ref
                                          .read(resetPinProvider.notifier)
                                          .resetPin(
                                            widget.otpCode,
                                            controller.text,
                                            confirmController.text,
                                          );
                                      context.loaderOverlay.show();
                                    }
                                  },
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
