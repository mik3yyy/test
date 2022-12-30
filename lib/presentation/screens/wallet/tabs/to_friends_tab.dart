import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/services/wallet/models/res/verify_acct_no_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/fingerprint_auth.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/user_profile/user_profile_db.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/vm/get_profile_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/shared/enable_modal_route_source.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/widget/beneficiary.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/tabs/widget/beneficiary_checkbox.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/transfer/transaction_pin_modal/pin_modal_sheet.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/user_saved_beneficary_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/verify_acct_no_vm.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/vm/wallet_transfer_vm.dart.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/widget/wallet_textfield.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/wallet/withdrawal/dialog/dialog.dart';
import 'package:kayndrexsphere_mobile/presentation/shared/preference_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/input/decimal_input.dart';
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
    final saveduser = ref.watch(savedUserProvider);
    final defaultWallet = ref.watch(userProfileProvider);
    final acctNoVm = ref.watch(verifyAcctNoProvider);
    final vm = ref.watch(transferToWalletProvider);
    final accountNoController = useTextEditingController();
    final currencyController = useTextEditingController(
        text: defaultWallet.value?.data.defaultWallet.currencyCode ?? "");
    final friendNameController = useTextEditingController();
    final amountController = useTextEditingController();
    FocusScopeNode currentFocus = FocusScope.of(context);
    final saveBeneficiary = useState(false);

    /// VERIFY ACCOUNT NUMBER LISTENER
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

    /// TRANSFER WALLET LISTENER
    ref.listen<RequestState>(transferToWalletProvider, (T, value) {
      if (value is Success<bool>) {
        AppDialog.showSuccessMessageDialog(
          context,
          'Funds transferred successfully',
          onpressed: () => Navigator.pop(context),
        );

        if (saveBeneficiary.value) {
          ref.invalidate(usersavedWalletBeneficirayProvider);
        }
      }
      if (value is Error) {
        AppDialog.showErrorMessageDialog(context, value.error.toString());
      }
    });
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space(25.h),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BeneficiaryView(
                    accountNoController: accountNoController,
                    friendNameController: friendNameController,
                  ),
                  // Space(30.h),
                  Text(
                    'Make transfer from your ${defaultWallet.maybeWhen(data: (data) => data.data.defaultWallet.currencyCode, orElse: () => saveduser.countryCode ?? "")} wallet',
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatter: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      DecimalTextInputFormatter(decimalRange: 2),
                    ],
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
                    labelText:
                        "${defaultWallet.maybeWhen(data: (data) => data.data.defaultWallet.currencyCode, orElse: () => saveduser.countryCode)}",
                    obscureText: false,
                    color: AppColors.appColor.withOpacity(0.05),
                    readOnly: true,
                  ),
                  Space(10.h),
                  SaveBeneficiaryCheckBox(saved: saveBeneficiary),
                  Space(20.h),
                  CustomButton(
                      buttonText: vm is Loading
                          ? loading(
                              Colors.white,
                            )
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
                                    var value =
                                        num.parse(amountController.text);
                                    var userBalance =
                                        num.parse(saveduser.balance.toString());

                                    if ((userBalance < value) || (value == 0)) {
                                      AppDialog.showErrorMessageDialog(context,
                                          "Amount cannot be more than available amount or zero");
                                      return;
                                    }
                                    if (PreferenceManager
                                        .enableTransactionBioMetrics) {
                                      ref
                                          .read(localAuthStateProvider.notifier)
                                          .authenticateTransaction()
                                          .then((value) {
                                        if (Platform.isAndroid) {
                                          if (value ==
                                              "Could not be Authenticated. Try again") {
                                            return;
                                          } else {
                                            ref
                                                .read(transferToWalletProvider
                                                    .notifier)
                                                .transferToAnotherUser(
                                                  accountNoController.text,
                                                  currencyController.text,
                                                  num.tryParse(amountController
                                                          .text) ??
                                                      0.0,
                                                  value,
                                                  saveBeneficiary.value,
                                                );
                                          }
                                        }
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
                                              transferAmount: num.tryParse(
                                                      amountController.text) ??
                                                  0,
                                              saveBeneficiary:
                                                  saveBeneficiary.value,
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
