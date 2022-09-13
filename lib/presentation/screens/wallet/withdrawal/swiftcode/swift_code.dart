import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/sepa/sepa_req.dart';
import 'package:kayndrexsphere_mobile/Data/services/payment/withdrawal/withdrawal_res.dart/withdrawal_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/reusable_widget.dart/custom_button.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/edit_form.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/widget/validator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/get_account_details_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/iban_withdraw.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/select_country_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/view_model.dart/iban_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/swiftcode/view_model.dart/sepa_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../components/app text theme/app_text_theme.dart';
import '../aba[ABA]/viewmodel/currency_list.dart';

class SwiftCodeView extends StatefulHookConsumerWidget {
  const SwiftCodeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwiftCodeViewState();
}

class _SwiftCodeViewState extends ConsumerState<SwiftCodeView> {
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });

  final toggleSelectionProvider = StateProvider<String>((ref) => 'IBAN');

  @override
  Widget build(BuildContext context) {
    final selection = ref.watch(toggleSelectionProvider.state);

    /// listens to Sepa withraw
    ref.listen<RequestState>(sepaWithdrawalProvider, (previous, value) {
      if (value is Success<WithdrawRes>) {
        context.loaderOverlay.hide();
      }

      if (value is Error) {
        context.loaderOverlay.hide();
      }
    });

    /// listens to Iban withraw
    ref.listen<RequestState>(ibanWithdrawalProvider, (previous, value) {
      if (value is Success<WithdrawRes>) {
        context.loaderOverlay.hide();
      }

      if (value is Error) {
        context.loaderOverlay.hide();
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
          title: Text(
            'SWIFTCODE [BIC]',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ToggleSelection(
                            textColor: selection.state == 'IBAN'
                                ? AppColors.appColor
                                : Colors.grey[400]!,
                            borderColor: selection.state == 'IBAN'
                                ? AppColors.appColor
                                : Colors.grey[200]!,
                            color: selection.state == 'IBAN'
                                ? Colors.grey[200]!
                                : Colors.grey[100]!,
                            name: 'IBAN',
                            onPressed: () {
                              selection.state = 'IBAN';
                            },
                          ),
                          ToggleSelection(
                            textColor: selection.state == 'SEPA'
                                ? AppColors.appColor
                                : Colors.grey[400]!,
                            borderColor: selection.state == 'SEPA'
                                ? AppColors.appColor
                                : Colors.grey[200]!,
                            color: selection.state == 'SEPA'
                                ? Colors.grey[200]!
                                : Colors.grey[100]!,
                            name: 'SEPA',
                            onPressed: () {
                              selection.state = 'SEPA';
                            },
                          ),
                        ],
                      ),
                      Space(20.h),
                      selection.state == "IBAN"
                          ? const IbanView()
                          : const SepaView()
                    ],
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

class SepaView extends StatefulHookConsumerWidget {
  const SepaView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SepaViewState();
}

class _SepaViewState extends ConsumerState<SepaView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fieldFocusNode = FocusNode();
  final toggleStateProvider = StateProvider<bool>((ref) {
    return true;
  });
  final transactionPinStateProvider = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context) {
    final toggle = ref.watch(toggleStateProvider.state);
    final walletBalance = ref.watch(getAccountDetailsProvider);
    final sepa = ref.watch(sepaWithdrawalProvider);
    final senderAddressController = useTextEditingController();
    final cityController = useTextEditingController();
    final streetNumberController = useTextEditingController();
    final zipCodeController = useTextEditingController();
    final routNumberController = useTextEditingController();
    final swiftCodeController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final bankNameController = useTextEditingController();
    final receipientAddress = useTextEditingController();
    final receipientAccountNumber = useTextEditingController();
    final countryController = useTextEditingController();
    final countryCodeController = useTextEditingController();
    final amountController = useTextEditingController();
    final receipientNameController = useTextEditingController();
    final currencyController = useTextEditingController();
    final currencyCode = useState("");
    final selectedCurrency = useState("");
    final enteredAmount = useState(false);
    final amount = useState(0);

    // listen to either success or failure response
    ref.listen<RequestState>(sepaWithdrawalProvider, (previous, value) {
      if (value is Success<WithdrawRes>) {
        ref.refresh(getAccountDetailsProvider);
        AppDialog.showSuccessMessageDialog(context, value.value!.message!);
      }

      if (value is Error) {
        AppDialog.showErrorMessageDialog(context, value.error.toString());
      }
    });

    return Form(
      key: formKey,
      child: Column(
        children: [
          ///Show availabe amount in selected wallet
          selectedCurrency.value.isEmpty
              ? const SizedBox.shrink()
              : Container(
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
                        style: AppText.body2(context, Colors.black, 18.sp),
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
                          data: (data) {
                            String getCurrency() {
                              if (selectedCurrency.value == "Naira") {
                                amount.value =
                                    data.data!.wallets![1].balance!.toInt();

                                return "NGN ${data.data!.wallets![1].balance.toString()}";
                              }
                              if (selectedCurrency.value == "Dollar") {
                                data.data!.wallets!.any(((element) {
                                  if (element.currency!.name == "US Dollar") {
                                    amount.value = element.balance!.toInt();

                                    return true;
                                  } else {
                                    return false;
                                  }
                                }));
                                return "\$ ${amount.value}";
                              }
                              if (selectedCurrency.value == "Euro") {
                                data.data!.wallets!.any(((element) {
                                  if (element.currency!.code == "EUR") {
                                    amount.value = element.balance!.toInt();

                                    return true;
                                  } else {
                                    return false;
                                  }
                                }));
                                return "€ ${amount.value}";
                              }

                              if (selectedCurrency.value == "Pound") {
                                data.data!.wallets!.any(((element) {
                                  if (element.currency!.code == "GBP") {
                                    amount.value = element.balance!.toInt();

                                    return true;
                                  } else {
                                    return false;
                                  }
                                }));
                                return "£ ${amount.value}";
                              }
                              if (selectedCurrency.value == "Kayndrex") {
                                return "${data.data!.wallets![0].currency!.symbol.toString()} ${data.data!.wallets![0].balance.toString()}";
                              } else {
                                return "";
                              }
                            }

                            return Text(
                              getCurrency(),
                              style: AppText.body2Bold(
                                  context, Colors.black, 23.sp),
                            );
                          })
                    ],
                  ),
                ),

          Space(20.h),
          //*
          //*
          //* Select currency
          //*
          //*
          Stack(
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
                              SizedBox(
                                height: 270,
                                child: ListView.separated(
                                  itemCount: currencylist.length,
                                  itemBuilder: (context, index) {
                                    final currency = currencylist[index];
                                    return GestureDetector(
                                      onTap: () {
                                        currencyController.text =
                                            currency.currency;
                                        currencyCode.value = currency.code;
                                        selectedCurrency.value =
                                            currency.currency;
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        color: Colors.white,
                                        child: Center(
                                          child: DefaultTextStyle(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22.sp),
                                              child: Text(currency.currency)),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 5.h,
                                    );
                                  },
                                ),
                              )
                            ],
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
                if (int.tryParse(value)! > amount.value) {
                  enteredAmount.value = true;
                } else {
                  enteredAmount.value = false;
                }
              },
              validator: (value) => validateAmount(value)),
          Space(8.5.h),

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

          Space(17.5.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter SEPA recipient name',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: receipientNameController,
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
              validator: (value) => null),
          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter recipient bank name',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: bankNameController,
              obscureText: false,
              validator: (value) => null),

          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter bank address of recipient',
              keyboardType: TextInputType.text,
              // textAlign: TextAlign.start,
              controller: receipientAddress,
              obscureText: false,
              validator: (value) {
                return null;
              }),
          Space(20.h),

          Stack(
            children: [
              InkWell(
                onTap: () {
                  pushNewScreen(context,
                      screen: SelectCountryScreen(
                          countryName: countryController,
                          countryCode: countryCodeController),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight);
                  // countryBuild(context, countryController);
                },
                child: EditForm(
                    enabled: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: 'Enter country',
                    keyboardType: TextInputType.text,
                    // textAlign: TextAlign.start,
                    controller: countryController,
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
          Space(20.h),
          EditForm(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter swift code of recipient’s bank',
              keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.text,
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
                  sepa is Loading ? "Processing ..." : 'Withdraw to bank',
              bgColor: AppColors.appColor,
              borderColor: AppColors.appColor,
              textColor: Colors.white,
              onPressed: sepa is Loading
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        fieldFocusNode.unfocus();
                        if (enteredAmount.value == true) {
                          AppDialog.showErrorMessageDialog(context,
                              "Withdrawal amount cannot be more than available amount");
                        } else {
                          var sepaReq = SepaReq(
                              accountNumber: receipientAccountNumber.text,
                              routingNumber: routNumberController.text,
                              swiftCode: swiftCodeController.text,
                              bankName: bankNameController.text,
                              beneficiaryName: receipientNameController.text,
                              beneficiaryAddress: receipientAddress.text,
                              walletToDebit: currencyCode.value,
                              description: descriptionController.text,
                              amount: amountController.text,
                              currencyCode: currencyCode.value,
                              country: countryCodeController.text,
                              zip: zipCodeController.text,
                              streetNo: streetNumberController.text,
                              streetName: senderAddressController.text,
                              city: cityController.text);

                          ref
                              .read(sepaWithdrawalProvider.notifier)
                              .sepaWithdrawal(sepaReq);
                          context.loaderOverlay.show();
                        }
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

class ToggleSelection extends StatelessWidget {
  final String name;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final void Function()? onPressed;
  const ToggleSelection(
      {Key? key,
      required this.name,
      required this.color,
      required this.borderColor,
      required this.textColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      height: 40,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: borderColor),
          borderRadius: BorderRadius.circular(30.r),
          color: color),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            name,
            style: AppText.body2(context, textColor, 19.sp),
          ),
        ),
      ),
    );
  }
}
