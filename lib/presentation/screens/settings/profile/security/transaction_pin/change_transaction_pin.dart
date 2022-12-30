import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/profile/req/change_transactionpin_req.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/loading_util/loading_util.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/text%20field/text_form_field.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/change_transaction_pin_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../../components/app text theme/app_text_theme.dart';

class ResetTransactionPin extends HookConsumerWidget {
  ResetTransactionPin({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final pinToggleStateProvider = StateProvider<bool>((ref) => true);
  final pinConfirmToggleStateProvider = StateProvider<bool>((ref) => true);
  final oldPinToggleStateProvider = StateProvider<bool>((ref) => true);

  final fieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confirmController = useTextEditingController();
    final controller = useTextEditingController();
    final oldPasswordController = useTextEditingController();
    var togglePassword = ref.watch(pinToggleStateProvider);
    var toggleConfirmPin = ref.watch(pinConfirmToggleStateProvider);
    var toggleOldPin = ref.watch(oldPinToggleStateProvider);
    final vn = ref.watch(changeTransactionPinProvider);
    ref.listen<RequestState>(changeTransactionPinProvider, (_, value) {
      if (value is Loading) {
        ScreenView.showLoadingView(context);
      } else {
        ScreenView.hideLoadingView(context);
      }
      if (value is Success) {
        Navigator.pop(context);

        return AppSnackBar.showSuccessSnackBar(context,
            message: 'Transaction Pin changed successfully');
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(
            title: "Change Transaction Pin", color: Colors.black),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.appColor.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsets.only(right: 200.w),
                    child: Center(
                      child: Text(
                        'Change Transaction Pin',
                        style: AppText.body2(context, Colors.black54, 20.sp),
                      ),
                    ),
                  ),
                ),
                Space(20.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: Column(
                    children: [
                      //old password
                      TextFormInput(
                        keyboardType: TextInputType.number,
                        capitalization: TextCapitalization.none,
                        labelText: 'Old PIN',
                        textLength: 4,
                        controller: oldPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Transaction pin is required";
                          }
                          if (value.length > 4) {
                            return 'Transaction pin must not be more than 4 numbers';
                          }
                          return null;
                        },
                        obscureText: toggleOldPin,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            ref.read(oldPinToggleStateProvider.notifier).state =
                                toggleOldPin ? false : true;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.h),
                            child: Icon(
                              toggleOldPin
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.appColor,
                            ),
                          ),
                        ),
                      ),
                      Space(32.h),

                      // new password
                      TextFormInput(
                        keyboardType: TextInputType.number,
                        capitalization: TextCapitalization.none,
                        labelText: 'New PIN',
                        textLength: 4,
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
                        obscureText: togglePassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            ref.read(pinToggleStateProvider.notifier).state =
                                togglePassword ? false : true;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.h),
                            child: Icon(
                              togglePassword
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
                        capitalization: TextCapitalization.none,
                        labelText: 'Re-enter new PIN',
                        controller: confirmController,
                        textLength: 4,
                        focusNode: fieldFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirm Transaction Pin is required';
                          } else if (controller.text !=
                              confirmController.text) {
                            return 'Transaction Pin doesn\'t match';
                          }

                          return null;
                        },
                        obscureText: toggleConfirmPin,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            ref
                                .read(pinConfirmToggleStateProvider.notifier)
                                .state = toggleConfirmPin ? false : true;
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
                      Space(150.h),
                      CustomButton(
                          buttonText: vn is Loading
                              ? loading(
                                  Colors.white,
                                )
                              : buttonText(context, "Save"),
                          bgColor: AppColors.appColor,
                          borderColor: AppColors.appColor,
                          textColor: Colors.white,
                          onPressed: vn is Loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    fieldFocusNode.unfocus();
                                    ChangeTransactionPinReq
                                        changeTransactionPin =
                                        ChangeTransactionPinReq(
                                      oldPin: oldPasswordController.text,
                                      newPin: controller.text,
                                      confirmNewPin: confirmController.text,
                                    );

                                    ref
                                        .read(changeTransactionPinProvider
                                            .notifier)
                                        .changeTransactionPin(
                                            changeTransactionPin);
                                  }
                                },
                          buttonWidth: MediaQuery.of(context).size.width),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
