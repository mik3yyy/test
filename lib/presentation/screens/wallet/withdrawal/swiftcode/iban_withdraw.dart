import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/iban/iban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/view_model.dart/iban_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class IbanView extends StatefulHookConsumerWidget {
  const IbanView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IbanViewState();
}

class _IbanViewState extends ConsumerState<IbanView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });
  // final transactionPinStateProvider = StateProvider<bool>((ref) => true);
  @override
  Widget build(BuildContext context) {
    final toggle = ref.watch(toggleStateProvider.state);
    final iban = ref.watch(ibanWithdrawalProvider);
    // final transactionPinToggle = ref.watch(transactionPinStateProvider.state);
    final senderAddressController = useTextEditingController();
    final cityController = useTextEditingController();
    final streetNumberController = useTextEditingController();
    final zipCodeController = useTextEditingController();
    final routNumberController = useTextEditingController();
    final swiftCodeController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final bankNameController = useTextEditingController();
    final receipientAddress = useTextEditingController();
    final receipientName = useTextEditingController();
    final receipientAccountNumber = useTextEditingController();
    final amountController = useTextEditingController();

    // final enteredAmount = useState(false);
    // final amount = useState(0);

    // listen to either success or failure response
    ref.listen<RequestState>(ibanWithdrawalProvider, (previous, value) {
      if (value is Success<WithdrawRes>) {
        ref.refresh(getAccountDetailsProvider);

        AppDialog.showSuccessMessageDialog(
          context,
          value.value!.message!,
          onpressed: () => Navigator.pop(context),
        );
      }

      if (value is Error) {
        AppDialog.showErrorMessageDialog(context, value.error.toString());
      }
    });
    return Form(
      key: formKey,
      child: Column(
        children: [
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter amount',
              keyboardType: TextInputType.number,
              // textAlign: TextAlign.start,
              controller: amountController,
              obscureText: false,
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                // if (int.tryParse(value)! > amount.value) {
                //   enteredAmount.value = true;
                // } else {
                //   enteredAmount.value = false;
                // }
              },
              validator: (value) => validateAmount(value)),
          Space(8.h),

          // if (enteredAmount.value == true) ...[
          //   Align(
          //     alignment: Alignment.bottomLeft,
          //     child: Text(
          //       'Withdrawal amount cannot be more than available amount',
          //       style: AppText.body2(context, Colors.red, 15.sp),
          //     ),
          //   ),
          // ] else
          //   ...[],
          // Space(20.h),
          //*
          //*
          //* Select currency
          //*
          //*
          // CurrencyWidget(
          //   currencyController: currencyController,
          //   text: 'Select wallet to withdraw from',
          // ),

          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter IBAN recipient name',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: receipientName,
              obscureText: false,
              validator: (value) => null),

          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter account number of recipient',
              keyboardType: TextInputType.number,
              // textAlign: TextAlign.start,
              controller: receipientAccountNumber,
              obscureText: false,
              validator: (value) => validateCountry(value)),
          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter bank name',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: bankNameController,
              obscureText: false,
              validator: (value) => validateCountry(value)),

          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter recipient address',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: receipientAddress,
              obscureText: false,
              validator: (value) {
                return null;
              }),
          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter swift code of recipient’s bank',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: swiftCodeController,
              obscureText: false,
              validator: (value) {
                return null;
              }),
          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter routing number',
              keyboardType: TextInputType.number,
              // textAlign: TextAlign.start,
              controller: routNumberController,
              obscureText: false,
              validator: (value) {
                return null;
              }),
          Space(20.h),
          Row(
            children: [
              SizedBox(
                width: 150,
                child: EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Enter Zip',
                    keyboardType: TextInputType.number,
                    // textAlign: TextAlign.start,
                    controller: zipCodeController,
                    obscureText: false,
                    validator: (value) {
                      return null;
                    }),
              ),
              const Space(60),
              SizedBox(
                width: 130,
                child: EditForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Street no.',
                    keyboardType: TextInputType.text,
                    // textAlign: TextAlign.start,
                    controller: streetNumberController,
                    obscureText: false,
                    validator: (value) {
                      return null;
                    }),
              ),
            ],
          ),
          Space(20.h),

          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Street name',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: senderAddressController,
              obscureText: false,
              validator: (value) => null),
          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'City',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: cityController,
              obscureText: false,
              validator: (value) => null),

          Space(20.h),

          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Purpose of withdrawal/transfer ',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: descriptionController,
              obscureText: false,
              validator: (value) => null),
          Space(20.h),
          Row(
            children: [
              Text(
                'Add to beneficiaries',
                style: AppText.header2(context, Colors.black, 20.sp),
              ),
              const Spacer(),
              Switch.adaptive(
                  activeColor: Colors.greenAccent,
                  value: toggle.state,
                  onChanged: (value) {
                    toggle.state = !toggle.state;
                  }),
            ],
          ),
          // Space(20.h),
          // Container(
          //   height: 80.h,
          //   width: MediaQuery.of(context).size.width,
          //   color: AppColors.appColor.withOpacity(0.05),
          //   child: Row(
          //     children: [
          //       Space(20.w),
          //       const Icon(
          //         Icons.security,
          //         size: 30,
          //       ),
          //       Space(15.w),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'For security reasons',
          //             style: AppText.header2(context, Colors.black, 20.sp),
          //           ),
          //           const Space(2),
          //           Text(
          //             'Enter transaction PIN',
          //             style: AppText.body2Bold(context, Colors.black, 23.sp),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // Space(20.h),
          // EditForm(
          //   autovalidateMode: AutovalidateMode.onUserInteraction,
          //   labelText: 'Enter Transaction Pin',
          //   keyboardType: TextInputType.text,
          //   // textAlign: TextAlign.start,
          //   controller: fistNameController,
          //   obscureText: transactionPinToggle.state,
          //   validator: (value) => validatePassword(value),
          //   suffixIcon: SizedBox(
          //     width: 55.w,
          //     child: GestureDetector(
          //       onTap: () {
          //         transactionPinToggle.state = !transactionPinToggle.state;
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.only(bottom: 0.h),
          //         child: Icon(
          //           transactionPinToggle.state
          //               ? Icons.visibility_off_outlined
          //               : Icons.visibility_outlined,
          //           color: Colors.grey.shade300,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Space(20.h),
          CustomButton(
              buttonText:
                  iban is Loading ? "Processing ..." : 'Withdraw to bank',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: iban is Loading
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        var ibanReq = IbanReq(
                            accountNumber: receipientAccountNumber.text,
                            routingNumber: routNumberController.text,
                            swiftCode: swiftCodeController.text,
                            bankName: bankNameController.text,
                            beneficiaryName: receipientName.text,
                            beneficiaryAddress: receipientAddress.text,
                            description: descriptionController.text,
                            amount: amountController.text,
                            zip: zipCodeController.text,
                            streetNo: streetNumberController.text,
                            streetName: senderAddressController.text,
                            city: cityController.text);

                        ref
                            .read(ibanWithdrawalProvider.notifier)
                            .ibanWithdrawal(ibanReq);
                        context.loaderOverlay.show();
                      }
                    },
              buttonWidth: MediaQuery.of(context).size.width),
          Space(7.h),
          Center(
            child: Text(
              'Cancel',
              style: AppText.header3(context, AppColors.appColor, 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}
