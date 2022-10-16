import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/Nuban/nuban_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_req/bank_details_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/bank_details.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/get_beneficiary_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/nuban_withdrawal.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/verify_account_number.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/select_bank.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../components/app text theme/app_text_theme.dart';

class NubanWithdraw extends StatefulHookConsumerWidget {
  const NubanWithdraw({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NubanWithdrawState();
}

class _NubanWithdrawState extends ConsumerState<NubanWithdraw> {
  final toggleStateProvider = StateProvider<bool>((ref) {
    return false;
  });
  final transactionPinStateProvider = StateProvider<bool>((ref) => false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final accountName = ref.watch(getBankDetailsProvider);
    final nuban = ref.watch(nubanWithdrawalProvider);
    final recipientDetail = ref.watch(accountDetailProvider);
    FocusScopeNode currentFocus = FocusScope.of(context);
    final walletBalance = ref.watch(getAccountDetailsProvider);
    final toggle = ref.watch(toggleStateProvider.state);
    final descriptionController = useTextEditingController();
    final accountNumber = useState("");
    final bankAccountController =
        useTextEditingController(text: accountNumber.value);
    final acctName = useState("");
    final accountNameController =
        useTextEditingController(text: acctName.value);
    final bankController = useTextEditingController();
    final bankCodeController = useTextEditingController();
    final amountController = useTextEditingController();
    final errorState = useState("");
    final amount = useState(0);
    final enteredAmount = useState(false);
    var formatter = NumberFormat("#,##0.00");

    ref.listen<RequestState>(nubanWithdrawalProvider, (previous, value) {
      if (value is Success<WithdrawRes>) {
        context.loaderOverlay.hide();
        // ref.refresh(getAccountDetailsProvider);
        ref.refresh(userProfileProvider);
        // ref.refresh(walletTransactionProvider);
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
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          title: const AppBarTitle(title: "NUBAN", color: Colors.black),
          leading: const BackButton(color: Colors.black),
          automaticallyImplyLeading: false,
          centerTitle: true,
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
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          strokeWidth: 4,
                                        ),
                                      ),
                                  data: (data) {
                                    data.data!.wallets!.any(((element) {
                                      if (element.currency!.name ==
                                          "Nigerian Naira") {
                                        amount.value = element.balance!.toInt();

                                        return true;
                                      } else {
                                        return false;
                                      }
                                    }));

                                    return Text(
                                      "NGN ${formatter.format(amount.value)}",
                                      style: AppText.body2Bold(
                                          context, Colors.black, 23.sp),
                                    );
                                  })
                            ],
                          ),
                        ),

                        const NubanBeneficiary(),

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
                                  validator: (value) =>
                                      withdrawalAmount(value)),
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

                        // Space(20.h),
                        //*
                        //*
                        //* Select currency
                        //*
                        //*

                        // CurrencyWidget(
                        //   currencyController: currencyController,
                        //   text: 'Select wallet to transfer from',
                        // ),
                        Space(20.h),
                        //*
                        //*
                        //* Select bank
                        //
                        //*
                        EditForm(
                          enabled: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Select bank',
                          keyboardType: TextInputType.text,
                          // textAlign: TextAlign.start,
                          controller: bankController,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: GestureDetector(
                              child: const Icon(
                                CupertinoIcons.chevron_down,
                                color: Color(0xffA8A8A8),
                                size: 15,
                              ),
                              onTap: () {
                                pushNewScreen(context,
                                    screen: SelectBankScreen(
                                      bankCode: bankCodeController,
                                      bankName: bankController,
                                    ),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.slideRight);
                              },
                            ),
                          ),
                          obscureText: false,
                          validator: (value) => validateCountry(value),
                          onTap: () {
                            pushNewScreen(context,
                                screen: SelectBankScreen(
                                  bankCode: bankCodeController,
                                  bankName: bankController,
                                ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.slideRight);
                          },
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
                          validator: (value) =>
                              validateNubanAccountNumber(value),

                          onChanged: (value) {
                            errorState.value = value;
                            if (value.length == 10) {
                              var getBankAccountDetails = GetBankAccountDetails(
                                bankCode: bankCodeController.text,
                                accountNumber: bankAccountController.text,
                              );
                              ref
                                  .read(accountDetailProvider.notifier)
                                  .getDetails(getBankAccountDetails);
                            } else {}
                          },
                        ),
                        Space(10.h),
                        recipientDetail.when(data: (data) {
                          acctName.value = data.data.accountName.toString();
                          accountNumber.value =
                              data.data.accountNumber.toString();
                          // setState(() {

                          // });

                          return data.data.accountName == null
                              ? const SizedBox.shrink()
                              : Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    data.data.accountName.toString(),
                                    style: AppText.body2(
                                        context, Colors.green, 15.sp),
                                  ),
                                );
                        }, error: (e, s) {
                          return Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              errorState.value.length < 10 ? "" : e.toString(),
                              style: AppText.body2(context, Colors.red, 15.sp),
                            ),
                          );
                        }, loading: () {
                          return Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '...',
                              style:
                                  AppText.body2(context, Colors.black, 15.sp),
                            ),
                          );
                        }),

                        EditForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            labelText: 'Purpose of withdrawal/transfer ',
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.start,
                            controller: descriptionController,
                            obscureText: false,
                            validator: (value) => validatePurpose(value)),
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
                        Space(40.h),
                        CustomButton(
                            buttonText: nuban is Loading
                                ? loading()
                                : buttonText(context, "Withdraw to Bank"),
                            bgColor: AppColors.appColor,
                            borderColor: AppColors.appColor,
                            textColor: Colors.white,
                            onPressed: accountName is Loading
                                ? null
                                : nuban is Loading
                                    ? null
                                    : () {
                                        if (enteredAmount.value == true) {
                                          context.loaderOverlay.hide();
                                          AppDialog.showErrorMessageDialog(
                                              context,
                                              "Withdrawal amount cannot be more than available amount");
                                        } else {
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }

                                          if ((formKey.currentState!
                                              .validate())) {
                                            var nubanReq = NubanReq(
                                                accountName:
                                                    accountNameController.text,
                                                accountNumber:
                                                    bankAccountController.text,
                                                amount: int.parse(
                                                    amountController.text),
                                                bankCode:
                                                    bankCodeController.text,
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
      ),
    );
  }
}

class NubanBeneficiary extends StatefulHookConsumerWidget {
  const NubanBeneficiary({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NubanBeneficiaryState();
}

class _NubanBeneficiaryState extends ConsumerState<NubanBeneficiary> {
  @override
  Widget build(BuildContext context) {
    final beneficiaryVm = ref.watch(nubanBeneficiaryProvider);
    return beneficiaryVm.when(
      data: (value) {
        return value.data!.beneficiaries!.isEmpty
            ? const SizedBox.shrink()
            : Container(
                color: AppColors.appColor.withOpacity(0.09),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space(10.h),
                      SizedBox(
                        // color: Colors.red,
                        height: 100,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.data!.beneficiaries!.length,
                          itemBuilder: (context, index) {
                            final user = value.data!.beneficiaries![index];

                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      // accountNoController.text = item
                                      //     .beneficiary!.accountNumber!;
                                      // friendNameController.text =
                                      //     '${item.beneficiary!.firstName} ${item.beneficiary!.lastName}';
                                    });
                                  },
                                  child: Container(
                                    height: 80.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '${user.beneficiaryName}',
                                      style: AppText.body2(
                                          context, Colors.black45, 40.sp),
                                    )),
                                  ),
                                ),
                                Space(10.h),
                                Text(
                                  '${user.beneficiaryName}',
                                  style: AppText.body2(
                                      context, Colors.black, 16.sp),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 20.w);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
      error: (Object error, StackTrace? stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        //When enpoint is loading, it should display default ideas with overlay loading
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.appBgColor,
          ),
        );
      },
    );
  }
}
