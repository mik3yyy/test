import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent-tab-view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/bank_details.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/bank_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/nuban_withdrawal.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/select_country.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/widget/currency.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/withdrawal_controller.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class NubanWithdraw extends StatefulHookConsumerWidget {
  const NubanWithdraw({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NubanWithdrawState();
}

class _NubanWithdrawState extends ConsumerState<NubanWithdraw> {
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });
  final transactionPinStateProvider = StateProvider<bool>((ref) => true);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final accountName = ref.watch(getBankDetailsProvider);
    final nuban = ref.watch(nubanWithdrawalProvider);
    final savedBeneficiary = ref.watch(genericController);
    final walletBalance = ref.watch(getAccountDetailsProvider);
    final toggle = ref.watch(toggleStateProvider.state);
    // final transactionPinToggle = ref.watch(transactionPinStateProvider.state);
    final descriptionController = useTextEditingController();
    final bankAccountController = useTextEditingController(
        text: savedBeneficiary.passBeneficiary.accountNumber);
    final currencyController = useTextEditingController();
    final bankController = useTextEditingController();
    final bankCodeController = useTextEditingController();
    final amountController = useTextEditingController();
    final errorState = useState("");
    final amount = useState(0);
    final enteredAmount = useState(false);
    final recipientAccountName =
        useState(savedBeneficiary.passBeneficiary.accountName);

    ref.listen<RequestState>(nubanWithdrawalProvider, (previous, value) {
      if (value is Success<WithdrawRes>) {
        ref.refresh(getAccountDetailsProvider);
        AppDialog.showSuccessMessageDialog(context, value.value!.message!);
      }

      if (value is Error) {
        AppDialog.showErrorMessageDialog(context, value.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'NUBAN',
          style: AppText.header2(context, Colors.black, 20.sp),
        ),
        leading: InkWell(
          onTap: (() => Navigator.pop(context)),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space(20.h),
                      Container(
                        height: 80.h,
                        padding: const EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.appColor.withOpacity(0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Naira wallet Balance',
                              style:
                                  AppText.body2(context, Colors.black, 18.sp),
                            ),
                            const Space(2),
                            walletBalance.when(
                                error: ((error, stackTrace) =>
                                    Text(error.toString())),
                                loading: () => const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 4,
                                      ),
                                    ),
                                idle: () => const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 3,
                                      ),
                                    ),
                                success: (data) {
                                  amount.value =
                                      data!.data!.wallets![1].balance!.toInt();

                                  return Text(
                                    "NGN ${data.data!.wallets![1].balance.toString()}",
                                    style: AppText.body2Bold(
                                        context, Colors.black, 23.sp),
                                  );
                                })
                          ],
                        ),
                      ),
                      Space(20.h),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: EditForm(
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
                          ),
                        ],
                      ),
                      Space(8.h),

                      if (enteredAmount.value == true) ...[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Withdrawal amount cannot be more than available amount',
                            style: AppText.body2(context, Colors.red, 15.sp),
                          ),
                        ),
                      ] else
                        ...[],

                      Space(20.h),
                      //*
                      //*
                      //* Select currency
                      //*
                      //*

                      CurrencyWidget(
                        currencyController: currencyController,
                        text: 'Select wallet to transfer from',
                      ),
                      Space(20.h),
                      //*
                      //*
                      //* Select bank
                      //*
                      //*
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: SelectBankScreen(
                                    bankCode: bankCodeController,
                                    bankName: bankController,
                                  ),
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.slideRight);
                              // countryBuild(context, countryController);
                            },
                            child: EditForm(
                                enabled: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                labelText: 'Select bank',
                                keyboardType: TextInputType.text,
                                // textAlign: TextAlign.start,
                                controller: bankController,
                                obscureText: false,
                                validator: (value) => validateCountry(value)),
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
                      // SelectBank(
                      //   bankController: bankController,
                      //   bankCode: bankCodeController,
                      // ),
                      Space(20.h),
                      EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText:
                            'Enter NUBAN (Nigerian account no) of recipient',
                        keyboardType: TextInputType.text,
                        // textAlign: TextAlign.start,
                        controller: bankAccountController,
                        obscureText: false,
                        validator: (value) => validateNubanAccountNumber(value),

                        onChanged: (value) {
                          errorState.value = value;
                          if (value.length == 10) {
                            var getBankAccountDetails = GetBankAccountDetails(
                              bankCode: bankCodeController.text,
                              accountNumber: bankAccountController.text,
                            );
                            ref
                                .read(getBankDetailsProvider.notifier)
                                .getDetails(getBankAccountDetails);
                          } else {}
                        },
                      ),
                      Space(10.h),
                      savedBeneficiary.passBeneficiary.accountName.isEmpty
                          ? accountName.when(error: (error, stackTrace) {
                              return Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  errorState.value.length < 10
                                      ? ""
                                      : error.toString(),
                                  style:
                                      AppText.body2(context, Colors.red, 18.sp),
                                ),
                              );
                            }, loading: () {
                              return Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '...',
                                  style: AppText.body2(
                                      context, Colors.black, 18.sp),
                                ),
                              );
                            }, idle: () {
                              return const SizedBox.shrink();
                            }, success: (data) {
                              recipientAccountName.value =
                                  data!.data.accountName.toString();

                              return Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  data.data.accountName.toString(),
                                  style: AppText.body2(
                                      context, Colors.greenAccent, 18.sp),
                                ),
                              );
                            })
                          : Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                savedBeneficiary.passBeneficiary.accountName
                                    .toString(),
                                style: AppText.body2(
                                    context, Colors.greenAccent, 18.sp),
                              ),
                            ),

                      Space(20.h),

                      EditForm(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      // Space(20.h),
                      // EditForm(
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   labelText: 'Enter Transaction Pin',
                      //   keyboardType: TextInputType.text,
                      //   // textAlign: TextAlign.start,
                      //   controller: enterPinController,
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
                      Space(20.h),
                      CustomButton(
                          buttonText: nuban is Loading
                              ? "Processing"
                              : 'Withdraw to bank',
                          bgColor: AppColors.appColor,
                          borderColor: AppColors.appColor,
                          textColor: Colors.white,
                          onPressed: accountName is Loading
                              ? null
                              : nuban is Loading
                                  ? null
                                  : () {
                                      if ((formKey.currentState!.validate())) {
                                        fieldFocusNode.unfocus();
                                        if (enteredAmount.value == true) {
                                          AppDialog.showErrorMessageDialog(
                                              context,
                                              "Withdrawal amount cannot be more than available amount");
                                        } else {
                                          fieldFocusNode.unfocus();
                                          var nubanReq = NubanReq(
                                              accountName:
                                                  recipientAccountName.value,
                                              accountNumber:
                                                  bankAccountController.text,
                                              amount: int.parse(
                                                  amountController.text),
                                              bankCode: bankCodeController.text,
                                              description:
                                                  descriptionController.text);
                                          ref
                                              .read(nubanWithdrawalProvider
                                                  .notifier)
                                              .nubanWithdrawal(nubanReq);
                                        }
                                      }
                                    },
                          buttonWidth: MediaQuery.of(context).size.width),
                      Space(7.h),
                      Center(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Cancel',
                            style: AppText.header3(
                                context, AppColors.appColor, 20.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Space(100.h),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectBank extends StatefulHookConsumerWidget {
  final TextEditingController bankController;
  final TextEditingController bankCode;
  const SelectBank(
      {Key? key, required this.bankController, required this.bankCode})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectBankState();
}

class _SelectBankState extends ConsumerState<SelectBank> {
  @override
  Widget build(BuildContext context) {
    final bankRes = ref.watch(getBankProvider);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: CupertinoActionSheet(
                      actions: [
                        Container(
                          color: Colors.white,
                          child: CupertinoActionSheetAction(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              child: Center(
                                child: Text(
                                  "Select Bank",
                                  style: AppText.body2(
                                      context, Colors.black, 20.sp),
                                ),
                              ),
                            ),
                            isDefaultAction: true,
                            onPressed: () {
                              // widget.bankController.text = gtBank;
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            height: 500,
                            child: bankRes.when(
                              idle: () => const CircularProgressIndicator(),
                              loading: () => const CircularProgressIndicator(),
                              error: (e, s) => Text(e.toString()),
                              success: (data) {
                                return SizedBox(
                                  height: 500,
                                  child: ListView.separated(
                                    itemCount: data!.data!.length,
                                    itemBuilder: (context, index) {
                                      final bank = data.data![index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.w, right: 5.w),
                                        child: Container(
                                          color: Colors.white,
                                          child: CupertinoActionSheetAction(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30.w, right: 30.w),
                                              child: Center(
                                                child: Text(
                                                  bank.name.toString(),
                                                  style: AppText.body2(context,
                                                      Colors.black, 17.sp),
                                                ),
                                              ),
                                            ),
                                            isDefaultAction: true,
                                            onPressed: () {
                                              widget.bankController.text =
                                                  bank.name!;
                                              widget.bankCode.text = bank.code!;
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 5,
                                      );
                                    },
                                  ),
                                );
                              },
                            )),
                      ],
                      // actions: [
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             gtBank,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDefaultAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = gtBank;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      // ],

                      // actions: <Widget>[
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             gtBank,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDefaultAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = gtBank;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             uba,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDestructiveAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = uba;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             accessbankDiamond,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDestructiveAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = accessbankDiamond;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             accessBank,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDestructiveAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = accessBank;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             zenithBank,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDestructiveAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = zenithBank;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             stanbicBank,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDestructiveAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = stanbicBank;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             sterlingBank,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDestructiveAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = sterlingBank;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      //   Container(
                      //     color: Colors.white,
                      //     child: CupertinoActionSheetAction(
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      //         child: Center(
                      //           child: Text(
                      //             fidelity,
                      //             style: AppText.body2(
                      //                 context, Colors.black, 20.sp),
                      //           ),
                      //         ),
                      //       ),
                      //       isDestructiveAction: true,
                      //       onPressed: () {
                      //         widget.bankController.text = fidelity;
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   ),
                      // ],
                      cancelButton: CupertinoActionSheetAction(
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Select bank name of recipient',

              // textAlign: TextAlign.start,
              controller: widget.bankController,
              obscureText: false,
              validator: (value) => validateCountry(value)),
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
    );
  }
}
