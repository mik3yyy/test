import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/bank_details.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/bank_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/widget/currency.dart';
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

  final String amount = '750';

  @override
  Widget build(BuildContext context) {
    final accountName = ref.watch(getBankDetailsProvider);
    final toggle = ref.watch(toggleStateProvider.state);
    final transactionPinToggle = ref.watch(transactionPinStateProvider.state);
    final fistNameController = useTextEditingController();
    final bankAccountController = useTextEditingController();
    final currencyController = useTextEditingController();
    final bankController = useTextEditingController();
    final bankCodeController = useTextEditingController();
    final amountController = useTextEditingController();
    final errorState = useState("");

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
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Center(
                              child: Text(
                                '\$',
                                style:
                                    AppText.body2(context, Colors.black, 15.sp),
                              ),
                            ),
                          ),
                          Space(15.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Naira wallet Balance',
                                style:
                                    AppText.body2(context, Colors.black, 18.sp),
                              ),
                              const Space(2),
                              Text(
                                'NGN $amount',
                                style: AppText.body2Bold(
                                    context, Colors.black, 23.sp),
                              ),
                            ],
                          ),
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
                              validator: (value) => validateCountry(value)),
                        ),
                        Positioned(
                            left: 375.w,
                            right: 0,
                            bottom: 17.h,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.red,
                              size: 15,
                            )),
                      ],
                    ),
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
                    SelectBank(
                      bankController: bankController,
                      bankCode: bankCodeController,
                    ),
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

                    accountName.when(error: (error, stackTrace) {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          errorState.value.length < 10 ? "" : error.toString(),
                          style: AppText.body2(context, Colors.red, 18.sp),
                        ),
                      );
                    }, loading: () {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '...',
                          style: AppText.body2(context, Colors.black, 18.sp),
                        ),
                      );
                    }, idle: () {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '',
                          style:
                              AppText.body2(context, Colors.greenAccent, 18.sp),
                        ),
                      );
                    }, success: (data) {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          data!.data.accountName.toString(),
                          style:
                              AppText.body2(context, Colors.greenAccent, 18.sp),
                        ),
                      );
                    }),

                    Space(20.h),

                    EditForm(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        labelText: 'Purpose of withdrawal/transfer ',
                        keyboardType: TextInputType.text,
                        // textAlign: TextAlign.start,
                        controller: fistNameController,
                        obscureText: false,
                        validator: (value) => validatePhoneNumber(value)),
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
                    Space(20.h),
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
                                style: AppText.header2(
                                    context, Colors.black, 20.sp),
                              ),
                              const Space(2),
                              Text(
                                'Enter transaction PIN',
                                style: AppText.body2Bold(
                                    context, Colors.black, 23.sp),
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
                      keyboardType: TextInputType.text,
                      // textAlign: TextAlign.start,
                      controller: fistNameController,
                      obscureText: transactionPinToggle.state,
                      validator: (value) => validatePassword(value),
                      suffixIcon: SizedBox(
                        width: 55.w,
                        child: GestureDetector(
                          onTap: () {
                            transactionPinToggle.state =
                                !transactionPinToggle.state;
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
                        buttonText: 'Withdraw to bank',
                        bgColor: AppColors.appColor,
                        borderColor: AppColors.appColor,
                        textColor: Colors.white,
                        onPressed: () {},
                        buttonWidth: MediaQuery.of(context).size.width),
                    Space(7.h),
                    Center(
                      child: Text(
                        'Cancel',
                        style:
                            AppText.header3(context, AppColors.appColor, 20.sp),
                      ),
                    ),
                  ],
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
  String gtBank = "Guarantee trust bank";
  String uba = "UBA Plc";
  String accessbankDiamond = "Access (Diamond)";
  String accessBank = "Access Bank";
  String zenithBank = "Zenith bank";
  String fidelity = "Fidelity bank";
  String stanbicBank = "Stanbic IBTC";
  String firstBank = "First bank Nigeria";
  String sterlingBank = "Sterling bank";
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
