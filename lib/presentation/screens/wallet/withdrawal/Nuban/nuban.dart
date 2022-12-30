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
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/model/bank/bank_details_res/bank_details_res.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/components/widget/appbar_title.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/notification/viewmodel/get_notification_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transactions.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/bank_details.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/nuban_view_model.dart/nuban_withdrawal.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/Nuban/select_bank.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/input/decimal_input.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../components/app text theme/app_text_theme.dart';
import 'widget/nuban_beneficiary.dart';

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

  bool savedRecipients = false;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final getBankDetails = ref.watch(getBankDetailsProvider);
    final nuban = ref.watch(nubanWithdrawalProvider);
    final walletBalance = ref.watch(getAccountDetailsProvider);
    // var toggle = ref.watch(toggleStateProvider);
    final descriptionController = useTextEditingController();
    final bankAccountController = useTextEditingController();
    final accountNameController = useTextEditingController();
    final bankController = useTextEditingController();
    final bankCodeController = useTextEditingController();
    final amountController = useTextEditingController();
    final verifyState = useState("");
    final acctName = useState("");
    final errorState = useState(false);
    final amount = useState<num>(0);
    final enteredAmount = useState(false);
    var formatter = NumberFormat("#,##0.00");

    ref.listen<RequestState>(getBankDetailsProvider, (_, value) {
      if (value is Loading) {
        errorState.value = false;
      }

      if (value is Success<BankDetailsRes>) {
        errorState.value = false;
        acctName.value = value.value!.data!.accountName.toString();
        accountNameController.text = value.value!.data!.accountName.toString();
        bankAccountController.text =
            value.value!.data!.accountNumber.toString();
      }

      if (value is Error) {
        errorState.value = true;
        acctName.value = value.error.toString();
      }
    });

    ref.listen<RequestState>(nubanWithdrawalProvider, (_, value) {
      if (value is Success<WithdrawRes>) {
        context.loaderOverlay.hide();

        ///REFRESH THE USER PROVIDER
        ref.invalidate(userProfileProvider);
        ref.invalidate(remoteNotificationListProvider);
        ref.invalidate(walletTransactionProvider);
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
                const HeaderTitle(),
                InnerPageLoadingIndicator(
                    loadingStream: getBankDetails is Loading),
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
                                      const Text("0.0")),
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
                                      if (element.currency?.name ==
                                          "Nigerian Naira") {
                                        amount.value =
                                            num.parse(element.balance ?? "");

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
                        const Space(10),
                        NubanBeneficiary(
                          acctName: acctName,
                          accountName: accountNameController,
                          accountNumber: bankAccountController,
                          bankName: bankController,
                          bankCode: bankCodeController,
                        ),
                        Space(20.h),
                        Text(
                          "Entered amount must be more than NGN 100",
                          style: AppText.body2(context, Colors.black, 16.sp),
                        ),

                        Space(20.h),
                        Stack(
                          children: [
                            InkWell(
                              child: EditForm(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  labelText: 'Enter amount',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  controller: amountController,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp('[ ]')),
                                    DecimalTextInputFormatter(decimalRange: 2),
                                  ],
                                  obscureText: false,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      enteredAmount.value = false;
                                      return;
                                    }
                                    if ((value.contains("..") ||
                                        (amountController.text
                                            .contains("..")))) {
                                      return;
                                    }
                                    if ((num.parse(value) > amount.value) ||
                                        (num.parse(value) == 0)) {
                                      enteredAmount.value = true;
                                    } else {
                                      enteredAmount.value = false;
                                    }
                                  },
                                  validator: (value) => null),
                            ),
                          ],
                        ),
                        Space(8.h),

                        if (enteredAmount.value == true) ...[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Amount cannot be more than available amount or zero',
                              style: AppText.body2(context, Colors.red, 15.sp),
                            ),
                          ),
                        ] else
                          ...[],

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
                                // pushNewScreen(context,
                                //     screen: SelectBankScreen(
                                //       bankCode: bankCodeController,
                                //       bankName: bankController,
                                //     ),
                                //     pageTransitionAnimation:
                                //         PageTransitionAnimation.slideRight);
                              },
                            ),
                          ),
                          obscureText: false,
                          validator: (value) => null,
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
                          keyboardType: TextInputType.number,
                          // textAlign: TextAlign.start,
                          controller: bankAccountController,
                          obscureText: false,
                          textLength: 10,
                          suffixIcon: getBankDetails is Loading
                              ? const Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 10, bottom: 10, top: 30),
                                  child: SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        color: AppColors.appColor,
                                      )),
                                )
                              : const SizedBox.shrink(),
                          validator: (value) => null,
                          onChanged: (value) {
                            verifyState.value = value;

                            /// CLEAR THE ACCT NAME VALUE WHEN BANK ACCOUNT IS EMPTY
                            if (value.isEmpty) {
                              acctName.value = "";
                            }
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
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            getBankDetails is Loading ? "" : acctName.value,
                            style: AppText.body2(
                                context,
                                errorState.value ? Colors.red : Colors.green,
                                15.sp),
                          ),
                        ),
                        Space(30.h),

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
                                value: savedRecipients,
                                onChanged: (value) {
                                  setState(() {
                                    savedRecipients = value;
                                  });
                                }),
                          ],
                        ),

                        Space(40.h),
                        CustomButton(
                            buttonText: nuban is Loading
                                ? loading(
                                    Colors.white,
                                  )
                                : buttonText(context, "Withdraw to Bank"),
                            bgColor: AppColors.appColor,
                            borderColor: AppColors.appColor,
                            textColor: Colors.white,
                            onPressed: getBankDetails is Loading
                                ? null
                                : nuban is Loading
                                    ? null
                                    : () {
                                        if (enteredAmount.value == true) {
                                          context.loaderOverlay.hide();
                                          AppDialog.showErrorMessageDialog(
                                              context,
                                              "Amount cannot be more than available amount or zero");
                                        } else if (amountController
                                            .text.isEmpty) {
                                          AppDialog.showErrorMessageDialog(
                                              context, "Amount is required");
                                        } else if (descriptionController
                                            .text.isEmpty) {
                                          AppDialog.showErrorMessageDialog(
                                              context,
                                              "Purpose of withdrawal is required");
                                        } else if (errorState.value == true) {
                                          AppDialog.showErrorMessageDialog(
                                              context,
                                              "Account number could not be verified");
                                        } else {
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }

                                          var nubanReq = NubanReq(
                                              accountName:
                                                  accountNameController.text,
                                              accountNumber:
                                                  bankAccountController.text,
                                              amount: num.tryParse(
                                                      amountController.text) ??
                                                  0.0,
                                              bankCode: bankCodeController.text,
                                              description:
                                                  descriptionController.text);
                                          ref
                                              .read(nubanWithdrawalProvider
                                                  .notifier)
                                              .nubanWithdrawal(nubanReq);
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

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: MediaQuery.of(context).size.width,
      color: AppColors.appColor.withOpacity(0.05),
      child: Padding(
        padding: EdgeInsets.only(right: 180.w),
        child: Center(
          child: Text(
            'Withdraw From Wallets',
            style: AppText.body2(context, Colors.black54, 20.sp),
          ),
        ),
      ),
    );
  }
}

Widget loadingDetails(Color color) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 30),
    child: loadingDetails(AppColors.appColor),
  );
}
