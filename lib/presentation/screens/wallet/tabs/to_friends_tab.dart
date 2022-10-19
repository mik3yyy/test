import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/verify_acct_no_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/fingerprint_auth.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/profile/vm/get_user_profile.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/enable_modal_route_source.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/transfer/transaction_pin_modal/pin_modal_sheet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/user_saved_beneficary_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/verify_acct_no_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transfer_vm.dart.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

import '../../../components/app text theme/app_text_theme.dart';
import '../../../components/reusable_widget.dart/custom_button.dart';

class FriendsTab extends StatefulHookConsumerWidget {
  const FriendsTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendsTabState();
}

class _FriendsTabState extends ConsumerState<FriendsTab> {
  final _formKey = GlobalKey<FormState>();
  bool togglePin = true;
  @override
  Widget build(BuildContext context) {
    final defaultWallet = ref.watch(userProfileProvider).value;
    final acctNoVm = ref.watch(verifyAcctNoProvider);
    final beneficiaryVm = ref.watch(usersavedWalletBeneficirayProvider);
    final vm = ref.watch(transferToWalletProvider);
    final accountNoController = useTextEditingController();
    final currencyController = useTextEditingController(
        text: defaultWallet?.data.defaultWallet.currencyCode);
    final friendNameController = useTextEditingController();
    final amountController = useTextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);

    ref.listen<RequestState>(verifyAcctNoProvider, (T, value) {
      if (value is Success<VerifyAcctNoRes>) {
        friendNameController.text =
            '${value.value!.data!.user!.firstName!} ${value.value!.data!.user!.lastName}';
      }
      if (value is Error) {
        return AppSnackBar.showErrorSnackBar(context,
            message: value.error.toString());
      }
    });

    ref.listen<RequestState>(transferToWalletProvider, (T, value) {
      if (value is Success<bool>) {
        // context.loaderOverlay.hide();
        AppDialog.showSuccessMessageDialog(
          context,
          'Funds transferred successfully',
          onpressed: () => Navigator.pop(context),
        );

        ref.refresh(getUserProfileProvider);
        ref.refresh(userProfileProvider);
        // ref.refresh(usersavedWalletBeneficirayProvider);
      }
      if (value is Error) {
        AppDialog.showErrorMessageDialog(context, value.error.toString());
      }
    });
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            beneficiaryVm.when(
              data: (value) {
                return value.data!.walletBeneficiaries!.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        color: AppColors.appColor.withOpacity(0.09),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Space(10.h),
                              SizedBox(
                                // color: Colors.red,
                                height: 100,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      value.data!.walletBeneficiaries!.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        value.data!.walletBeneficiaries![index];

                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              accountNoController.text = item
                                                  .beneficiary!.accountNumber!;
                                              friendNameController.text =
                                                  '${item.beneficiary!.firstName} ${item.beneficiary!.lastName}';
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
                                              '${item.beneficiary!.firstName?[0]}',
                                              style: AppText.body2(
                                                  context,
                                                  AppColors.appColor
                                                      .withOpacity(0.5),
                                                  40.sp),
                                            )),
                                          ),
                                        ),
                                        Space(10.h),
                                        Expanded(
                                          child: Text(
                                            '${item.beneficiary!.firstName} ${item.beneficiary!.lastName}',
                                            style: AppText.body2(context,
                                                AppColors.appColor, 16.sp),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
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
            ),
            Space(25.h),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Make transfer from your ${defaultWallet?.data.defaultWallet.currencyCode} wallet',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(40.h),
                  Text(
                    'Enter Kayndrexsphere account number',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(5.h),
                  WalletTextField(
                    labelText: 'Enter account number',
                    obscureText: false,
                    color: Colors.white,
                    readOnly: false,
                    keyboardType: TextInputType.number,
                    controller: accountNoController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Account Number can\'t be empty';
                      }
                      if (value.length != 8) {
                        return 'Account Number Must be 8 digits';
                      }

                      // validator has to return something :)
                      return null;
                    },
                    onChanged: (value) {
                      if (value.length == 8) {
                        value = accountNoController.text;

                        ref
                            .read(verifyAcctNoProvider.notifier)
                            .verifyAcctNo(accountNoController.text);
                      } else if (value.length > 8) {
                        return;
                      } else if (value.length < 8) {
                        return;
                      }
                    },
                  ),
                  Space(25.h),
                  Text(
                    'Friend Name:',
                    // 'Enter the name of your friend',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(5.h),
                  WalletTextField(
                    // labelText: 'hhhh',
                    // initialValue: friendNameController.text,
                    labelText: acctNoVm is Loading
                        ? 'Fetching...'
                        : friendNameController.text,
                    controller: friendNameController,
                    obscureText: false,
                    color: Colors.white,
                    // readOnly: true,

                    // enabled: false,
                  ),
                  Space(25.h),
                  Text(
                    'Enter transfer amount',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(5.h),
                  WalletTextField(
                    labelText: 'Enter amount',
                    obscureText: false,
                    color: Colors.white,
                    readOnly: false,
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Amount is required";
                      }
                      return null;
                    },
                  ),
                  Space(25.h),
                  Text(
                    'Currency',
                    style: AppText.body2(context, AppColors.appColor, 19.sp),
                  ),
                  Space(5.h),
                  WalletTextField(
                    controller: currencyController,
                    labelText: defaultWallet?.data.defaultWallet.currencyCode,
                    obscureText: false,
                    color: AppColors.appColor.withOpacity(0.05),
                    readOnly: true,
                  ),
                  Space(10.h),

                  const SaveBeneficiaryCheckBox(),
                  // if (PreferenceManager.enableBioMetrics) ...[
                  //   const SizedBox.shrink()
                  // ] else ...[
                  //   const TransactionPinMessage(),
                  //   Space(20.h),
                  //   EditForm(
                  //     autovalidateMode: AutovalidateMode.onUserInteraction,
                  //     labelText: 'Enter Transaction Pin',
                  //     keyboardType: TextInputType.number,
                  //     controller: transactionPin,
                  //     obscureText: togglePin,
                  //     validator: (value) => null,
                  //     suffixIcon: SizedBox(
                  //       width: 55.w,
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             togglePin = !togglePin;
                  //           });
                  //         },
                  //         child: Padding(
                  //           padding: EdgeInsets.only(bottom: 0.h),
                  //           child: Icon(
                  //             togglePin
                  //                 ? Icons.visibility_off_outlined
                  //                 : Icons.visibility_outlined,
                  //             color: Colors.grey.shade300,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ],

                  // Space(20.h),

                  Space(20.h),
                  CustomButton(
                      buttonText: vm is Loading
                          ? loading()
                          : buttonText(context, "Transfer"),
                      bgColor: AppColors.appColor,
                      borderColor: AppColors.appColor,
                      textColor: Colors.white,
                      onPressed: acctNoVm is Loading
                          ? null
                          : vm is Loading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }

                                    // ref
                                    //     .read(transferToWalletProvider.notifier)
                                    //     .transferToAnotherUser(
                                    //       accountNoController.text,
                                    //       currencyController.text,
                                    //       int.parse(amountController.text),
                                    //       "",
                                    //       savedAsBenefeciaryChecked,
                                    //     );

                                    if (PreferenceManager
                                        .enableTransactionBioMetrics) {
                                      ref
                                          .read(localAuthStateProvider.notifier)
                                          .authenticateTransaction()
                                          .then((value) {
                                        ref
                                            .read(transferToWalletProvider
                                                .notifier)
                                            .transferToAnotherUser(
                                              accountNoController.text,
                                              currencyController.text,
                                              int.parse(amountController.text),
                                              value,
                                              savedAsBenefeciaryChecked,
                                            );
                                      });
                                    } else {
                                      showModalBottomSheet(
                                          context: context,
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(20))),
                                          builder: (context) {
                                            return PinModalSheet(
                                              routeName:
                                                  ModalRouteName.toFriend,
                                              fromCurrency:
                                                  accountNoController.text,
                                              toCurrency:
                                                  currencyController.text,
                                              transferAmount: int.parse(
                                                  amountController.text),
                                              saveBeneficiary:
                                                  savedAsBenefeciaryChecked,
                                            );
                                          });
                                    }
                                  }
                                },
                      buttonWidth: MediaQuery.of(context).size.width),
                  Space(7.h),
                  Center(
                    child: Text(
                      'Cancel',
                      style:
                          AppText.header3(context, AppColors.appColor, 20.sp),
                    ),
                  ),
                  Space(80.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SaveBeneficiaryCheckBox extends StatefulWidget {
  const SaveBeneficiaryCheckBox({Key? key}) : super(key: key);

  @override
  _SaveBeneficiaryCheckBoxState createState() =>
      _SaveBeneficiaryCheckBoxState();
}

bool savedAsBenefeciaryChecked = false;

class _SaveBeneficiaryCheckBoxState extends State<SaveBeneficiaryCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        controlAffinity: ListTileControlAffinity.leading,
        value: savedAsBenefeciaryChecked,
        checkColor: Colors.white,
        activeColor: AppColors.appColor,
        // selectedTileColor: AppColors.primaryColor,
        // title: Transform.translate(offset: Offset(-15,0),
        title: Transform.translate(
          offset: const Offset(-17, 0),
          child: Text(
            'Save beneficiary',
            style: AppText.body2(context, AppColors.appColor, 18.sp),
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            savedAsBenefeciaryChecked = newValue!;
          });
        });
  }
}

class TransactionPinMessage extends StatelessWidget {
  const TransactionPinMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                style: AppText.body2Bold(context, Colors.black, 23.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
