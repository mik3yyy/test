import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/widgets/user_wallets.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transfer_vm.dart.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';

class ToWallet extends StatefulHookConsumerWidget {
  const ToWallet({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToWalletState();
}

class _ToWalletState extends ConsumerState<ToWallet> {
  final passwordToggleStateProvider = StateProvider<bool>((ref) => true);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final defaultWallet = ref.watch(userProfileProvider).value;
    FocusScopeNode currentFocus = FocusScope.of(context);
    // final defaultWallet = ref.watch(signInProvider);
    final vm = ref.watch(transferToWalletProvider);
    final transactionPinToggle = ref.watch(passwordToggleStateProvider.state);

    final amountController = useTextEditingController();
    final toCurrencyController = useTextEditingController();
    final transactionPinController = useTextEditingController();

    ref.listen<RequestState>(transferToWalletProvider, (T, value) {
      if (value is Success) {
        // context.loaderOverlay.hide();
        AppDialog.showSuccessMessageDialog(
            context, 'Funds transferred successfully');
        //Refreshing user account details, so the new balance can reflect on the screen

        ref.refresh(userProfileProvider);
      }
      if (value is Error) {
        // context.loaderOverlay.hide();
        AppDialog.showErrorMessageDialog(context, value.error.toString());
      }
    });

    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Transfer from ${defaultWallet?.data.defaultWallet.currencyCode} wallet to other wallets',
                  style: AppText.body2(context, Colors.black, 19.sp),
                ),
              ),
              Space(25.h),
              Text(
                'Enter amount',
                style: AppText.body2(context, AppColors.appColor, 19.sp),
              ),
              Space(5.h),
              WalletTextField(
                labelText: 'Enter amount',
                obscureText: false,
                color: Colors.white,
                keyboardType: TextInputType.number,
                controller: amountController,
                readOnly: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              Space(25.h),
              Text(
                'Select currency wallet',
                style: AppText.body2(context, AppColors.appColor, 19.sp),
              ),
              Space(5.h),
              WalletTextField(
                labelText: 'Select currency wallet',
                obscureText: false,
                color: Colors.white,
                keyboardType: TextInputType.number,
                controller: toCurrencyController,
                readOnly: false,
                suffixIcon: SelectWalletList(
                  currency: toCurrencyController,
                  routeName: "transferScreen",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              Space(35.h),
              Container(
                height: 80.h,
                width: MediaQuery.of(context).size.width,
                color: AppColors.appColor.withOpacity(0.05),
                child: Row(
                  children: [
                    Space(20.w),
                    const Icon(
                      Icons.security,
                      size: 30,
                    ),
                    Space(15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'For security reasons',
                          style: AppText.header2(context, Colors.black, 20.sp),
                        ),
                        const Space(2),
                        Text(
                          'Enter transaction PIN',
                          style:
                              AppText.body2Bold(context, Colors.black, 23.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Space(20.h),
              EditForm(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: 'Enter Transaction Pin',
                keyboardType: TextInputType.number,
                // textAlign: TextAlign.start,
                controller: transactionPinController,
                obscureText: transactionPinToggle.state,
                // validator: (value) => validatePassword(value),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Transaction pin is required';
                  }
                  return null;
                },
                suffixIcon: SizedBox(
                  width: 55.w,
                  child: GestureDetector(
                    onTap: () {
                      transactionPinToggle.state = !transactionPinToggle.state;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.h),
                      child: Icon(
                        transactionPinToggle.state
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              Space(20.h),
              CustomButton(
                buttonText: vm is Loading ? "Processing" : 'Transfer',
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
                              .read(transferToWalletProvider.notifier)
                              .transferToWallet(
                                defaultWallet!.data.defaultWallet.currencyCode!,
                                toCurrencyController.text,
                                int.parse(amountController.text),
                                transactionPinController.text,
                              );
                          context.loaderOverlay.show();
                        }
                      },
                buttonWidth: MediaQuery.of(context).size.width,
              ),
              Space(7.h),
              Center(
                child: Text(
                  'Cancel',
                  style: AppText.header3(context, AppColors.appColor, 20.sp),
                ),
              ),
              Space(80.h),
            ],
          ),
        ),
      ),
    );
  }
}
