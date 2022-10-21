import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Aba/aba_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/aba%5BABA%5D/viewmodel/aba_viewmodel.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/aba%5BABA%5D/viewmodel/currency_list.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class ABAWithdrawal extends StatefulHookConsumerWidget {
  const ABAWithdrawal({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ABAWithdrawalState();
}

class _ABAWithdrawalState extends ConsumerState<ABAWithdrawal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();

  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });
  final transactionPinStateProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context) {
    final aba = ref.watch(abaWithdrawalProvider);
    final walletBalance = ref.watch(getAccountDetailsProvider);
    final toggle = ref.watch(toggleStateProvider.state);
    final routNumberController = useTextEditingController();
    final swiftCodeController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final bankNameController = useTextEditingController();
    final receipientAddress = useTextEditingController();
    final receipientName = useTextEditingController();
    final accountNumber = useTextEditingController();
    final currencyController = useTextEditingController();
    final amountController = useTextEditingController();
    final currencyCode = useState("");
    final enteredAmount = useState(false);
    final amount = useState(0);

    ref.listen<RequestState>(abaWithdrawalProvider, (previous, value) {
      if (value is Success<WithdrawRes>) {
        context.loaderOverlay.hide();
        AppDialog.showSuccessMessageDialog(
          context,
          value.value!.message!,
          onpressed: () => Navigator.pop(context),
        );
      }

      if (value is Error) {
        context.loaderOverlay.hide();
        AppDialog.showErrorMessageDialog(context, value.error.toString());
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
          backgroundColor: Colors.transparent,
          title: const AppBarTitle(title: "ACH [ABA]", color: Colors.black),
          leading: const BackButton(color: Colors.black),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.appColor.withOpacity(0.05),
                    child: Padding(
                      padding: EdgeInsets.only(right: 210.w),
                      child: Center(
                        child: Text(
                          'Withdraw From Wallets',
                          style: AppText.body2(context, Colors.black54, 20.sp),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(20.h),
                        Container(
                          height: 80.h,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.appColor.withOpacity(0.05),
                          child: Row(
                            children: [
                              Space(20.w),
                              Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: Center(
                                  child: Text(
                                    '\$',
                                    style: AppText.body2(
                                        context, Colors.black, 15.sp),
                                  ),
                                ),
                              ),
                              Space(15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dollar wallet balance',
                                    style: AppText.body2(
                                        context, Colors.black, 18.sp),
                                  ),
                                  const Space(2),
                                  walletBalance.when(
                                      error: ((error, stackTrace) =>
                                          Text(error.toString())),
                                      loading: () => const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator
                                                .adaptive(
                                              strokeWidth: 4,
                                            ),
                                          ),
                                      data: (data) {
                                        data.data!.wallets!.any(((element) {
                                          if (element.currency!.name ==
                                              "US Dollar") {
                                            amount.value =
                                                element.balance!.toInt();

                                            return true;
                                          } else {
                                            return false;
                                          }
                                        }));

                                        return Text(
                                          "\$ ${amount.value}",
                                          style: AppText.body2Bold(
                                              context, Colors.black, 23.sp),
                                        );
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                        Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter amount',
                            keyboardType: TextInputType.number,
                            // textAlign: TextAlign.start,
                            controller: amountController,
                            obscureText: false,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              if (int.tryParse(value)! > amount.value) {
                                enteredAmount.value = true;
                              } else {
                                enteredAmount.value = false;
                              }
                            },
                            validator: (value) => validateAmount(value)),
                        Space(8.h),
                        if (enteredAmount.value == true) ...[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Withdrawal amount cannot be more than available amount',
                              style: AppText.body2(context, Colors.red, 15.sp),
                            ),
                          ),
                        ] else ...[
                          const SizedBox.shrink()
                        ],

                        Space(20.h),
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.w, right: 25.w),
                                        child: CupertinoActionSheet(
                                          actions: [
                                            SizedBox(
                                              height: 270,
                                              child: ListView.separated(
                                                itemCount: currencylist.length,
                                                itemBuilder: (context, index) {
                                                  final currency =
                                                      currencylist[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      currencyController.text =
                                                          currency.currency;
                                                      currencyCode.value =
                                                          currency.code;
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: DefaultTextStyle(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    22.sp),
                                                            child: Text(currency
                                                                .currency)),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    height: 5.h,
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            child: const Text("Close"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: EditForm(
                                  enabled: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  labelText: 'Select wallet to transfer from',

                                  // textAlign: TextAlign.start,
                                  controller: currencyController,
                                  obscureText: false,
                                  validator: (value) => wallet(value)),
                            ),
                            Positioned(
                              left: 375.w,
                              right: 0,
                              bottom: 17.h,
                              child: const Icon(
                                CupertinoIcons.chevron_down,
                                color: Color(0xffA8A8A8),
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                        Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter ACH [ABA] recipient name ',
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.start,
                            controller: receipientName,
                            obscureText: false,
                            validator: (value) => accountName(value)),
                        Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter account number of recipient',
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.start,
                            controller: accountNumber,
                            obscureText: false,
                            validator: (value) {
                              return null;
                            }),
                        Space(20.h),
                        // Stack(
                        //   children: [
                        //     InkWell(
                        //       onTap: () {},
                        //       child: EditForm(
                        //           autovalidateMode:
                        //               AutovalidateMode.onUserInteraction,
                        //           labelText: 'Country',
                        //           keyboardType: TextInputType.number,
                        //           // textAlign: TextAlign.start,
                        //           controller: fistNameController,
                        //           obscureText: false,
                        //           validator: (value) => validateCountry(value)),
                        //     ),
                        //     Positioned(
                        //       left: 375.w,
                        //       right: 0,
                        //       bottom: 17.h,
                        //       child: const Icon(
                        //         CupertinoIcons.chevron_down,
                        //         color: Color(0xffA8A8A8),
                        //         size: 15,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter bank name of recipient',
                            keyboardType: TextInputType.name,
                            // textAlign: TextAlign.start,
                            controller: bankNameController,
                            obscureText: false,
                            validator: (value) => validatePhoneNumber(value)),
                        Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter bank address of recipient',
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.start,
                            controller: receipientAddress,
                            obscureText: false,
                            validator: (value) {
                              return null;
                            }),
                        Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter Routing number',
                            keyboardType: TextInputType.number,
                            // textAlign: TextAlign.start,
                            controller: routNumberController,
                            obscureText: false,
                            validator: (value) {
                              return null;
                            }),
                        Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Enter switft code of recipient’s bank',
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.start,
                            controller: swiftCodeController,
                            obscureText: false,
                            validator: (value) {
                              return null;
                            }),
                        Space(20.h),
                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Purpose of withdrawal/transfer ',
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.start,
                            controller: descriptionController,
                            obscureText: false,
                            validator: (value) => validatePhoneNumber(value)),
                        Space(20.h),
                        Row(
                          children: [
                            Text(
                              'Add to beneficiaries',
                              style:
                                  AppText.header2(context, Colors.black, 20.sp),
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
                        //             style: AppText.header2(
                        //                 context, Colors.black, 20.sp),
                        //           ),
                        //           const Space(2),
                        //           Text(
                        //             'Enter transaction PIN',
                        //             style: AppText.body2Bold(
                        //                 context, Colors.black, 23.sp),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Space(20.h),
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
                        //         transactionPinToggle.state =
                        //             !transactionPinToggle.state;
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
                        // Space(20.h),
                        CustomButton(
                            buttonText: aba is Loading
                                ? loading(
                                    Colors.white,
                                  )
                                : buttonText(context, "Withdraw to Bank"),
                            bgColor: AppColors.appColor,
                            borderColor: AppColors.appColor,
                            textColor: Colors.white,
                            onPressed: aba is Loading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      fieldFocusNode.unfocus();

                                      if (enteredAmount.value == true) {
                                        AppDialog.showErrorMessageDialog(
                                            context,
                                            "Withdrawal amount cannot be more than available amount");
                                      } else {
                                        var abaReq = AbaReq(
                                            accountNumber: accountNumber.text,
                                            routingNumber:
                                                routNumberController.text,
                                            swiftCode: swiftCodeController.text,
                                            bankName: bankNameController.text,
                                            beneficiaryName:
                                                receipientName.text,
                                            beneficiaryAddress:
                                                receipientAddress.text,
                                            walletToDebit: currencyCode.value,
                                            description:
                                                descriptionController.text,
                                            amount: amountController.text);

                                        ref
                                            .read(
                                                abaWithdrawalProvider.notifier)
                                            .abaWithdrawal(abaReq);
                                        context.loaderOverlay.show();
                                      }
                                    }
                                  },
                            buttonWidth: MediaQuery.of(context).size.width),
                        Space(7.h),
                        Center(
                          child: Text(
                            'Cancel',
                            style: AppText.header3(
                                context, AppColors.appColor, 20.sp),
                          ),
                        ),
                        const Space(100)
                      ],
                    ),
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
