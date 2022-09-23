import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_success_event.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../Data/controller/controller/generic_state_notifier.dart';
import '../../../components/AppSnackBar/snackbar/app_snackbar_view.dart';
import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';
import '../../../components/text field/text_form_field.dart';
import '../vm/set_transaction_pin_vm.dart';
import '../widgets/alert_dialog.dart';

class TransactionPinScreen extends StatefulHookConsumerWidget {
  const TransactionPinScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionPinScreenState();
}

class _TransactionPinScreenState extends ConsumerState<TransactionPinScreen> {
  final formKey = GlobalKey<FormState>();
  final pinToggleStateProvider = StateProvider<bool>((ref) => true);
  final pinConfirmToggleStateProvider = StateProvider<bool>((ref) => true);
  final fieldFocusNode = FocusNode();

  bool togglePin = true;
  bool toggleConfirmPin = true;

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(transactionPinProvider);
    final pinController = useTextEditingController();
    final confirmPinController = useTextEditingController();
    ref.listen<RequestState>(transactionPinProvider, (T, value) {
      if (value is Success<bool>) {
        if (value.value == true) {
          ref.refresh(providers);
          context.loaderOverlay.hide();

          successAlart(
              context, "Your Transaction Pin has been set", "Continue");
        }
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
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Set your PIN",
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(19.h),
                    Text(
                      "Confirm all transactions using this PIN",
                      style:
                          AppText.header2(context, AppColors.appColor, 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    Space(70.h),

                    // pin
                    TextFormInput(
                      keyboardType: TextInputType.number,
                      labelText: 'Enter Transaction Pin',
                      capitalization: TextCapitalization.none,
                      textLength: 4,
                      // inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      controller: pinController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Transaction pin is requied";
                        }
                        if (value.length > 4) {
                          return 'Transaction pin must not be more than 4 numbers';
                        }
                        return null;
                      },
                      obscureText: togglePin,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          togglePin = !togglePin;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.h),
                          child: Icon(
                            togglePin ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.appColor,
                          ),
                        ),
                      ),
                    ),
                    Space(42.h),

                    //confirm pin
                    TextFormInput(
                      keyboardType: TextInputType.number,
                      capitalization: TextCapitalization.none,
                      labelText: 'Re-Enter Transaction PIN',
                      controller: confirmPinController,
                      focusNode: fieldFocusNode,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Confirm transaction pin is required';
                        } else if (pinController.text !=
                            confirmPinController.text) {
                          return 'Transaction pin doesn\'t match';
                        }

                        // validator has to return something :)
                        return null;
                      },
                      obscureText: toggleConfirmPin,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          toggleConfirmPin = !toggleConfirmPin;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.h),
                          child: Icon(
                            toggleConfirmPin
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.appColor,
                          ),
                        ),
                      ),
                    ),
                    const Space(300),

                    CustomButton(
                      buttonWidth: double.infinity,
                      buttonText: vm is Loading ? "Please wait" : 'Set PIN',
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: vm is Loading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                fieldFocusNode.unfocus();
                                ref
                                    .read(transactionPinProvider.notifier)
                                    .transactionPin(pinController.text,
                                        confirmPinController.text);
                                context.loaderOverlay.show();
                              }
                            },
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
